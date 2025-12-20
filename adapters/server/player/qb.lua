--[[
    fmLib - QB Server Player Adapter
]]

local adapter = {}

function string.split(str, delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(str, delimiter, from)

    while delim_from do
        table.insert(result, string.sub(str, from, delim_from - 1))
        from = delim_to + 1
        delim_from, delim_to = string.find(str, delimiter, from)
    end

    table.insert(result, string.sub(str, from))
    return result
end

function adapter.getFullnameByIdentifier(identifier)
    if not identifier then return nil end

    local result = MySQL.query.await('SELECT JSON_EXTRACT(charinfo, "$.firstname") as firstname, JSON_EXTRACT(charinfo, "$.lastname") as lastname FROM players WHERE citizenid = ?', {identifier})
    if result and result[1] then
        local firstname = result[1].firstname and string.gsub(result[1].firstname, '"', '') or ''
        local lastname = result[1].lastname and string.gsub(result[1].lastname, '"', '') or ''
        return firstname .. ' ' .. lastname
    end

    return nil
end

function adapter.getPlayerBySrc(src)
    if not src then return end

    local _fwp = QB.Functions.GetPlayer(src)
    if not _fwp or type(_fwp) ~= 'table' then return end

    if _fwp.PlayerData and _fwp.PlayerData.source then
        _fwp.source = _fwp.PlayerData.source
    end

    local p = {
        src = _fwp.source
    }

    p.addItem = function(item, amount, metadata, ignoreCheck)
        if not item or not amount then return false end
        if not ignoreCheck and not p.canAddItem(item, amount) then return false end

        if FM.inventory.hasFunction('addItem') then
            return FM.inventory.addItem(_fwp.source, item, amount, metadata)
        end

        return _fwp.Functions.AddItem(item, amount, nil, metadata)
    end

    p.addMoney = function(amount, moneyType, transactionData)
        moneyType = moneyType or Defaults.MONEY
        if not amount then return end

        if transactionData and moneyType == 'bank' then
            if GetResourceState('RxBanking') == 'started' then
                local personalAcc = exports['RxBanking']:GetPlayerPersonalAccount(p.getIdentifier())
                if personalAcc then
                    exports['RxBanking']:CreateTransaction(amount, transactionData.type,
                        transactionData.fromIban, personalAcc.iban, transactionData.reason)
                end
            end
        end

        _fwp.Functions.AddMoney(moneyType, amount)
    end

    p.canAddItem = function(item, amount)
        if not item or not amount then return false end

        if FM.inventory.hasFunction('canCarryItem') then
            return FM.inventory.canCarryItem(_fwp.source, item, amount)
        end

        return true
    end

    p.getMoney = function(moneyType)
        moneyType = moneyType or Defaults.MONEY

        local money = _fwp.PlayerData.money[moneyType]
        if money == nil then
            Error('Money Type not found: ' .. moneyType)
            return 0
        end

        return money
    end

    p.getIdentifier = function()
        return _fwp.PlayerData.citizenid
    end

    p.getJob = function()
        return {
            name = _fwp.PlayerData.job.name,
            label = _fwp.PlayerData.job.label,
            grade = _fwp.PlayerData.job.grade.level,
            gradeLabel = _fwp.PlayerData.job.grade.name
        }
    end

    p.getGang = function()
        return {
            name = _fwp.PlayerData.gang.name,
            label = _fwp.PlayerData.gang.label,
            grade = _fwp.PlayerData.gang.grade.level,
            gradeLabel = _fwp.PlayerData.gang.grade.name
        }
    end

    p.getItem = function(item)
        if not item then return end

        if FM.inventory.hasFunction('getItem') then
            return FM.inventory.getItem(_fwp.source, item)
        end

        Debug('(p.getItem) Executing QB GetItemByName on: ' .. item)
        local itemData = _fwp.Functions.GetItemByName(item)
        if not itemData then return end
        Debug('(p.getItem) GetItemByName returned: ' .. itemData.name .. ' (x' .. itemData.amount .. ') ' .. itemData.label)

        return {
            name = itemData.name,
            label = itemData.label,
            amount = itemData.amount
        }
    end

    p.getItems = function()
        if FM.inventory.hasFunction('getInventory') then
            return FM.inventory.getInventory(_fwp.source)
        end

        local inventory = {}
        local items = _fwp.PlayerData.items

        for slot, item in pairs(items) do
            if item.amount == nil then item.amount = item.count end -- Simple QBox compatibility fix

            inventory[slot] = {
                name = item.name,
                label = item.label,
                amount = item.amount,
                metadata = item.info,
            }
        end

        return inventory
    end

    p.getFirstName = function()
        return _fwp.PlayerData.charinfo.firstname
    end

    p.getLastName = function()
        return _fwp.PlayerData.charinfo.lastname
    end

    p.getFullName = function()
        return _fwp.PlayerData.charinfo.firstname .. ' ' .. _fwp.PlayerData.charinfo.lastname
    end

    p.hasItemAmount = function(item, amount)
        if not item then return end

        item = p.getItem(item)
        return item and item.amount >= amount or false
    end

    p.isAdmin = function()
        if QB.Functions.HasPermission(_fwp.source, Defaults.ADMIN_QB) or QB.Functions.HasPermission(_fwp.source, Defaults.GOD_QB) then
            return true
        end

        return IsPlayerAceAllowed(_fwp.source, 'command')

        -- Want custom admin group? Uncomment below and add the group in server.cfg
        -- IN SERVER.CFG: add_ace group.admin fmLib.admin allow
        -- return IsPlayerAceAllowed(_fwp.source, 'fmLib.admin')
    end

    p.getGroup = function()
        return QB.Functions.GetPermission(_fwp.source)
    end

    p.notify = function(message, type)
        if not message then return end

        TriggerClientEvent('QBCore:Notify', _fwp.source, message, type)
    end

    p.removeItem = function(item, amount, slotId, metadata)
        if not item or not amount then return end

        if FM.inventory.hasFunction('removeItem') then
            FM.inventory.removeItem(_fwp.source, item, amount, slotId, metadata)
            return
        end

        _fwp.Functions.RemoveItem(item, amount)
    end

    p.removeMoney = function(amount, moneyType, transactionData)
        moneyType = moneyType or Defaults.MONEY
        if not amount then return end

        if transactionData and moneyType == 'bank' then
            if GetResourceState('RxBanking') == 'started' then
                local personalAcc = exports['RxBanking']:GetPlayerPersonalAccount(p.getIdentifier())
                if personalAcc then
                    exports['RxBanking']:CreateTransaction(amount, transactionData.type, personalAcc.iban,
                        transactionData.toIban, transactionData.reason)
                end
            end
        end

        _fwp.Functions.RemoveMoney(moneyType, amount)
    end

    p.setJob = function(jobName, jobGrade)
        if not jobName or not jobGrade then return end

        _fwp.Functions.SetJob(jobName, jobGrade)
    end

    p.setGang = function(gangName, gangGrade)
        if not gangName or not gangGrade then return end

        _fwp.Functions.SetGang(gangName, gangGrade)
    end

    return p
end

function adapter.getPlayerByIdentifier(identifier)
    if not identifier then return end

    local _fwp = QB.Functions.GetPlayerByCitizenId(identifier)
    if not _fwp or type(_fwp) ~= 'table' then return end

    return adapter.getPlayerBySrc(_fwp.PlayerData.source)
end

-- Event handlers
function adapter.onPlayerLoaded(player)
    TriggerEvent('fm:player:onPlayerLoaded', player.PlayerData.source)
end

-- Event registrations
RegisterNetEvent('QBCore:Server:PlayerLoaded', adapter.onPlayerLoaded)

FM_Adapter_server_player_qb = adapter