--[[
    fmLib - ESX Server Player Adapter
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

    local result = MySQL.scalar.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {identifier})
    if result then
        local data = MySQL.query.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {identifier})
        if data and data[1] then
            return (data[1].firstname or '') .. ' ' .. (data[1].lastname or '')
        end
    end

    return nil
end

function adapter.getPlayerBySrc(src)
    if not src then return end

    local _fwp = ESX.GetPlayerFromId(src)
    if not _fwp or type(_fwp) ~= 'table' then return end

    local p = {
        src = _fwp.source
    }

    p.addItem = function(item, amount, metadata, ignoreCheck)
        if not item or not amount then return false end
        if not ignoreCheck and not p.canAddItem(item, amount) then return false end

        if string.find(item:lower(), 'weapon') and FM.inventory.hasFunction('addWeapon') then
            return FM.inventory.addWeapon(_fwp.source, item, 0)
        end

        if FM.inventory.hasFunction('addItem') then
            return FM.inventory.addItem(_fwp.source, item, amount, metadata)
        end

        _fwp.addInventoryItem(item, amount)

        return true
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

        _fwp.addAccountMoney(moneyType, amount)
    end

    p.canAddItem = function(item, amount)
        if not item or not amount then return false end

        if FM.inventory.hasFunction('canCarryItem') then
            return FM.inventory.canCarryItem(_fwp.source, item, amount)
        end

        return _fwp.canCarryItem(item, amount)
    end

    p.getMoney = function(moneyType)
        moneyType = moneyType or Defaults.MONEY

        local acc = _fwp.getAccount(moneyType)
        if not acc then
            Error('Money Type not found: ' .. moneyType)
            return 0
        end

        return acc.money
    end

    p.getIdentifier = function()
        return _fwp.getIdentifier()
    end

    p.getJob = function()
        return {
            name = _fwp.job.name,
            label = _fwp.job.label,
            grade = _fwp.job.grade,
            gradeLabel = _fwp.job.grade_label
        }
    end

    p.getGang = function()
        local job = p.getJob()
        if not job then return end

        return {
            name = job.name,
            label = job.label,
            grade = job.grade,
            gradeLabel = job.gradeLabel
        }
    end

    p.getItem = function(item)
        if not item then return end

        if string.find(item:lower(), 'weapon') and FM.inventory.hasFunction('getWeapon') then
            return FM.inventory.getWeapon(_fwp.source, item)
        end

        if FM.inventory.hasFunction('getItem') then
            return FM.inventory.getItem(_fwp.source, item)
        end

        local itemData = _fwp.getInventoryItem(item)
        if not itemData then return end

        return {
            name = itemData.name,
            label = itemData.label,
            amount = itemData.count
        }
    end

    p.getItems = function()
        if FM.inventory.hasFunction('getInventory') then
            return FM.inventory.getInventory(_fwp.source)
        end

        local inventory = {}
        local items = _fwp.getInventory()

        for slot, item in pairs(items) do
            inventory[slot] = {
                name = item.name,
                label = item.label,
                amount = item.count
            }
        end

        return inventory
    end

    p.getFirstName = function()
        return string.split(_fwp.getName(), ' ')[1]
    end

    p.getLastName = function()
        return string.split(_fwp.getName(), ' ')[2]
    end

    p.getFullName = function()
        return _fwp.getName()
    end

    p.hasItemAmount = function(item, amount)
        if not item then return end

        item = p.getItem(item)
        return item and item.amount >= amount or false
    end

    p.isAdmin = function()
        if _fwp.getGroup() == Defaults.ADMIN_ESX then
            return true
        end

        return IsPlayerAceAllowed(_fwp.source, 'command')

        -- Want custom admin group? Uncomment below and add the group in server.cfg
        -- IN SERVER.CFG: add_ace group.admin fmLib.admin allow
        -- return IsPlayerAceAllowed(_fwp.source, 'fmLib.admin')
    end

    p.getGroup = function()
        return _fwp.getGroup()
    end

    p.notify = function(message, type)
        if not message then return end

        TriggerClientEvent('esx:showNotification', _fwp.source, message, type)
    end

    p.removeItem = function(item, amount, slotId, metadata)
        if not item or not amount then return end

        if string.find(item:lower(), 'weapon') and FM.inventory.hasFunction('removeWeapon') then
            FM.inventory.removeWeapon(_fwp.source, item)
            return
        end

        if FM.inventory.hasFunction('removeItem') then
            FM.inventory.removeItem(_fwp.source, item, amount, slotId, metadata)
            return
        end

        _fwp.removeInventoryItem(item, amount)
    end

    p.removeMoney = function(amount, moneyType, transactionData)
        moneyType = moneyType or Defaults.MONEY
        if not amount then return end

        if transactionData and moneyType == 'bank' then
            if GetResourceState('RxBanking') == 'started' then
                local personalAcc = exports['RxBanking']:GetPlayerPersonalAccount(p.getIdentifier())
                if personalAcc then
                    exports['RxBanking']:CreateTransaction(-amount, transactionData.type,
                        personalAcc.iban, transactionData.toIban, transactionData.reason)
                end
            end
        end

        _fwp.removeAccountMoney(moneyType, amount)
    end

    p.setJob = function(jobName, jobGrade)
        if not jobName or not jobGrade then return end

        _fwp.setJob(jobName, jobGrade)
    end

    p.setGang = function(gangName, gangGrade)
        if not gangName or not gangGrade then return end

        _fwp.setJob(gangName, gangGrade)
    end

    return p
end

function adapter.getPlayerByIdentifier(identifier)
    if not identifier then return end

    local _fwp = ESX.GetPlayerFromIdentifier(identifier)
    if not _fwp or type(_fwp) ~= 'table' then return end

    return adapter.getPlayerBySrc(_fwp.source)
end

FM_Adapter_server_player_esx = adapter