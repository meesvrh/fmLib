FM.player = {}

local function getPlayerBySrc(src)
    if not src then return end

    local _fwp = ESX and ESX.GetPlayerFromId(src) or QB and QB.Functions.GetPlayer(src) or nil
    if not _fwp or not type(_fwp) == 'table' then return end

    _fwp.source = QB and _fwp.PlayerData.source or _fwp.source
    return _fwp
end

local function getPlayerByIdentifier(identifier)
    if not identifier then return end
    local _fwp = ESX and ESX.GetPlayerFromIdentifier(identifier) or QB and QB.Functions.GetPlayerByCitizenId(identifier) or nil
    if not _fwp or not type(_fwp) == 'table' then return end

    _fwp.source = QB and _fwp.PlayerData.source or _fwp.source
    return _fwp
end

---@param id number|string
function FM.player.get(id)
    local _fwp = type(id) == 'number' and getPlayerBySrc(id) or type(id) == 'string' and getPlayerByIdentifier(id) or nil
    if not _fwp or type(_fwp) ~= 'table' then return end

    local p = {}

    ---@param item string
    ---@param amount number
    ---@param metadata? any
    ---@param ignoreCheck? boolean
    p.addItem = function(item, amount, metadata, ignoreCheck)
        if not item or not amount then return false end
        if not ignoreCheck and not p.canAddItem(item, amount) then return false end

        if OXInv then
            OXInv:AddItem(_fwp.source, item, amount, metadata)

            return true
        elseif ESX then
            _fwp.addInventoryItem(item, amount)

            return true
        elseif QB then
            return _fwp.Functions.AddItem(item, amount)
        end
    end

    ---@param amount number
    ---@param moneyType? string
    p.addMoney = function(amount, moneyType)
        moneyType = moneyType or Defaults.MONEY
        if not amount then return end

        if ESX then _fwp.addAccountMoney(moneyType, amount)
        elseif QB then _fwp.Functions.AddMoney(moneyType, amount) end
    end

    p.canAddItem = function(item, amount)
        if not item or not amount then return false end

        if OXInv then return OXInv:CanCarryItem(_fwp.source, item, amount)
        elseif QBInv then return QBInv:CanAddItem(_fwp.source, item, amount)
        elseif QSInv then return QSInv:CanCarryItem(_fwp.source, item, amount)
        elseif ESX then return _fwp.canCarryItem(item, amount)
        elseif QB then return true end
    end

    ---@param moneyType? string
    ---@return number | nil amount
    p.getMoney = function(moneyType)
        moneyType = moneyType or Defaults.MONEY

        if ESX then
            local acc = _fwp.getAccount(moneyType)
            if not acc then FM.console.err('Money Type not found: '..moneyType) return 0 end

            return acc.money
        elseif QB then 
            local money = _fwp.PlayerData.money[moneyType]
            if money == nil then FM.console.err('Money Type not found: '..moneyType) return 0 end

            return money
        end
    end

    ---@return string identifier
    p.getIdentifier = function()
        if ESX then return _fwp.getIdentifier()
        elseif QB then return _fwp.PlayerData.citizenid end
    end

    ---@return { name: string, label: string, grade: number, gradeLabel: string } job
    p.getJob = function()
        if ESX then
            return {
                name = _fwp.job.name,
                label = _fwp.job.label,
                grade = _fwp.job.grade,
                gradeLabel = _fwp.job.grade_label
            }
        elseif QB then
            return {
                name = _fwp.PlayerData.job.name,
                label = _fwp.PlayerData.job.label,
                grade = _fwp.PlayerData.job.grade.level,
                gradeLabel = _fwp.PlayerData.job.grade.name
            }
        end
    end

    ---@return { name: string, label: string, grade: number, gradeLabel: string } gang
    p.getGang = function()
        if ESX then return p.getJob()
        elseif QB then
            return {
                name = _fwp.PlayerData.gang.name,
                label = _fwp.PlayerData.gang.label,
                grade = _fwp.PlayerData.gang.grade.level,
                gradeLabel = _fwp.PlayerData.gang.grade.name
            }
        end
    end

    ---@param item string
    ---@return { name: string, label: string, amount: number } item
    p.getItem = function(item)
        if not item then return end

        if OXInv then
            item = OXInv:GetItem(_fwp.source, item, nil, false)
            if not item then return end

            return {
                name = item.name,
                label = item.label,
                amount = item.count
            }
        elseif ESX then
            item = _fwp.getInventoryItem(item)
            if not item then return end

            return {
                name = item.name,
                label = item.label,
                amount = item.count
            }
        elseif QB then
            item = _fwp.Functions.GetItemByName(item)
            if not item then return end

            return {
                name = item.name,
                label = item.label,
                amount = item.amount
            }
        end
    end

    ---@return { [slot]: { name: string, amount: number, label: string } } inventory
    p.getItems = function()
        local inventory = {}

        if ESX then
            local items = _fwp.getInventory()
            for slot, item in pairs(items) do
                inventory[slot] = {
                    name = item.name,
                    label = item.label,
                    amount = item.count
                }
            end
        elseif QB then
            local items = _fwp.PlayerData.items
            for slot, item in pairs(items) do
                inventory[slot] = {
                    name = item.name,
                    label = item.label,
                    amount = item.amount
                }
            end
        end

        return inventory
    end

    ---@return string firstName
    p.getFirstName = function()
        if ESX then return _fwp.getName().split(' ')[1]
        elseif QB then return _fwp.PlayerData.charinfo.firstname end
    end

    ---@return string lastName
    p.getLastName = function()
        if ESX then return _fwp.getName().split(' ')[2]
        elseif QB then return _fwp.PlayerData.charinfo.lastname end
    end

    ---@return string fullName
    p.getFullName = function()
        if ESX then return _fwp.getName()
        elseif QB then return _fwp.PlayerData.charinfo.firstname .. ' ' .. _fwp.PlayerData.charinfo.lastname end
    end

    ---@param item string
    ---@param amount number
    ---@return boolean
    p.hasItemAmount = function(item, amount)
        if not item then return end

        item = p.getItem(item)
        return item and item.amount >= amount or false
    end

    ---@return boolean
    p.isAdmin = function()
        if ESX then
            return _fwp.getGroup() == Defaults.ADMIN_ESX
        elseif QB then
            if QB.Functions.HasPermission(_fwp.source, Defaults.ADMIN_QB) or QB.Functions.HasPermission(_fwp.source, Defaults.GOD_QB) then
                return true
            end
        end

        -- IN SERVER.CFG: add_ace group.admin fmLib.admin allow
        return IsPlayerAceAllowed(_fwp.source, 'fmLib.admin')
    end

    ---@return string | table group
    p.getGroup = function()
        if ESX then return _fwp.getGroup()
        elseif QB then return QB.Functions.GetPermission(_fwp.source) end
    end

    ---@param message string
    ---@param type? 'success'|'error'
    p.notify = function(message, type)
        if not message then return end

        if ESX then TriggerClientEvent('esx:showNotification', _fwp.source, message, type)
        elseif QB then TriggerClientEvent('QBCore:Notify', _fwp.source, message, type) end
    end

    ---@param item string
    ---@param amount number
    ---@param slotId? number
    ---@param metadata? any
    p.removeItem = function(item, amount, slotId, metadata)
        if not item or not amount then return end
        
        if OXInv then OXInv:RemoveItem(_fwp.source, item, amount, metadata, slotId)
        elseif ESX then _fwp.removeInventoryItem(item, amount)
        elseif QB then _fwp.Functions.RemoveItem(item, amount) end
    end

    ---@param amount number
    ---@param moneyType? string
    p.removeMoney = function(amount, moneyType)
        moneyType = moneyType or Defaults.MONEY
        if not amount then return end

        if ESX then _fwp.removeAccountMoney(moneyType, amount)
        elseif QB then _fwp.Functions.RemoveMoney(moneyType, amount) end
    end
    
    return p
end

FM.p = FM.player