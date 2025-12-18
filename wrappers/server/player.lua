FM.player = {}

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

local function isNewQBInv()
    local version = GetResourceMetadata(Resources.QBInv.name or 'qb-inventory', 'version', 0)
    if not version then return false end

    local vNums = {}

    for num in version:gmatch("(%d+)") do
        vNums[#vNums + 1] = tonumber(num)
    end

    return vNums and vNums[1] >= 2
end

local function getPlayerBySrc(src)
    if not src then return end

    local _fwp = ESX and ESX.GetPlayerFromId(src) or QB and QB.Functions.GetPlayer(src) or nil
    if not _fwp or type(_fwp) ~= 'table' then return end

    -- Only set source from PlayerData if it exists (QB structure)
    if _fwp.PlayerData and _fwp.PlayerData.source then
        _fwp.source = _fwp.PlayerData.source
    end

    return _fwp
end

local function getPlayerByIdentifier(identifier)
    if not identifier then return end
    local _fwp = ESX and ESX.GetPlayerFromIdentifier(identifier) or QB and QB.Functions.GetPlayerByCitizenId(identifier) or
        nil
    if not _fwp or type(_fwp) ~= 'table' then return end

    -- Only set source from PlayerData if it exists (QB structure)
    if _fwp.PlayerData and _fwp.PlayerData.source then
        _fwp.source = _fwp.PlayerData.source
    end

    return _fwp
end

---Get player fullname by identifier
---@param identifier string The player identifier
---@return string|nil The player's full name or nil if not found
FM.player.getFullnameByIdentifier = function(identifier)
    if not identifier then return nil end

    if ESX then
        local result = MySQL.scalar.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {identifier})
        if result then
            local data = MySQL.query.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {identifier})
            if data and data[1] then
                return (data[1].firstname or '') .. ' ' .. (data[1].lastname or '')
            end
        end
    elseif QB then
        local result = MySQL.query.await('SELECT JSON_EXTRACT(charinfo, "$.firstname") as firstname, JSON_EXTRACT(charinfo, "$.lastname") as lastname FROM players WHERE citizenid = ?', {identifier})
        if result and result[1] then
            local firstname = result[1].firstname and string.gsub(result[1].firstname, '"', '') or ''
            local lastname = result[1].lastname and string.gsub(result[1].lastname, '"', '') or ''
            return firstname .. ' ' .. lastname
        end
    end

    return nil
end

---@param id number|string
function FM.player.get(id)
    local _fwp = type(id) == 'number' and getPlayerBySrc(id) or type(id) == 'string' and getPlayerByIdentifier(id) or nil
    if not _fwp or type(_fwp) ~= 'table' then return end

    local p = {
        src = _fwp.source
    }

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
        elseif QSInv then
            QSInv:AddItem(_fwp.source, item, amount, nil, metadata)
            return true
        elseif TGIANN_INV then
            TGIANN_INV:AddItem(_fwp.source, item, amount, nil, metadata)
            return true
        elseif ESX then
            if CHEZZAInv and string.find(item:lower(), 'weapon') then
                _fwp.addWeapon(item, 0)
            else
                _fwp.addInventoryItem(item, amount)
            end
            return true
        elseif QB then
            return _fwp.Functions.AddItem(item, amount, nil, metadata)
        elseif ORIGEN_INVENTORY then
            local canCarry, reason = exports.origen_inventory:canCarryItem(_fwp.source, item, amount)
            return canCarry
        end

        return false
    end

    ---@param amount number
    ---@param moneyType? string
    ---@param transactionData? { type?: 'deposit' | 'withdraw' | 'transfer' | 'interest' | 'payment', reason?: string, fromIban?: string }
    p.addMoney = function(amount, moneyType, transactionData)
        moneyType = moneyType or Defaults.MONEY
        if not amount then return end

        if transactionData and moneyType == 'bank' then
            if GetResourceState(Resources.RX_BANKING.name) == 'started' then
                local personalAcc = exports[Resources.RX_BANKING.name]:GetPlayerPersonalAccount(p.getIdentifier())
                if personalAcc then
                    exports[Resources.RX_BANKING.name]:CreateTransaction(amount, transactionData.type,
                        transactionData.fromIban, personalAcc.iban, transactionData.reason)
                end
            end
        end

        if ESX then
            _fwp.addAccountMoney(moneyType, amount)
        elseif QB then
            _fwp.Functions.AddMoney(moneyType, amount)
        end
    end

    p.canAddItem = function(item, amount)
        if not item or not amount then return false end

        if OXInv then
            return OXInv:CanCarryItem(_fwp.source, item, amount)
        elseif QBInv and isNewQBInv() then
            return QBInv:CanAddItem(_fwp.source, item, amount)
        elseif QSInv then
            return QSInv:CanCarryItem(_fwp.source, item, amount)
        elseif ESX then
            return _fwp.canCarryItem(item, amount)
        elseif QB then
            return true
        end
    end

    ---@param moneyType? string
    ---@return number | nil amount
    p.getMoney = function(moneyType)
        moneyType = moneyType or Defaults.MONEY

        if ESX then
            local acc = _fwp.getAccount(moneyType)
            if not acc then
                FM.console.err('Money Type not found: ' .. moneyType)
                return 0
            end

            return acc.money
        elseif QB then
            local money = _fwp.PlayerData.money[moneyType]
            if money == nil then
                FM.console.err('Money Type not found: ' .. moneyType)
                return 0
            end

            return money
        end
    end

    ---@return string identifier
    p.getIdentifier = function()
        if ESX then
            return _fwp.getIdentifier()
        elseif QB then
            return _fwp.PlayerData.citizenid
        end
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

    ---@return { name: string, label: string, grade: number, gradeLabel: string } | nil gang
    p.getGang = function()
        if ESX then
            local job = p.getJob()
            if not job then return end

            return {
                name = job.name,
                label = job.label,
                grade = job.grade,
                gradeLabel = job.gradeLabel
            }
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
            if CHEZZAInv and string.find(item:lower(), 'weapon') then
                local loadoutNum, weapon = _fwp.getWeapon(item)

                if weapon then
                    item = weapon
                    item.count = 1 -- CHEZZAInv compatibility fix
                end
            else
                item = _fwp.getInventoryItem(item)
            end

            if not item then return end

            return {
                name = item.name,
                label = item.label,
                amount = item.count
            }
        elseif QB then
            Debug('(p.getItem) Executing QB GetItemByName on: ' .. item)
            item = _fwp.Functions.GetItemByName(item)
            if not item then return end
            Debug('(p.getItem) GetItemByName returned: ' .. item.name .. ' (x' .. item.amount .. ') ' .. item.label)

            return {
                name = item.name,
                label = item.label,
                amount = item.amount
            }
        end
    end

    ---@return { [slot]: { name: string, amount: number, label: string, metadata?: any } } inventory
    p.getItems = function()
        local inventory = {}

        if OXInv then
            local items = OXInv:GetInventory(_fwp.source).items

            for slot, item in pairs(items) do
                inventory[slot] = {
                    name = item.name,
                    label = item.label,
                    amount = item.count,
                    metadata = item.metadata,
                }
            end
        elseif QSInv then
            local items = QSInv:GetInventory(_fwp.source)
            for _, itemData in pairs(items) do
                inventory[itemData.slot] = {
                    name = itemData.name,
                    label = itemData.label,
                    amount = itemData.count,
                    metadata = itemData.info,
                }
            end
        elseif COREInv then
            local items = COREInv:getInventory()
            for _, item in pairs(items) do
                inventory[item.slot] = {
                    name = item.name,
                    label = item.label,
                    amount = item.amount,
                    metadata = item.metadata,
                }
            end
        elseif TGIANN_INV then
            local items = TGIANN_INV:GetPlayerItems(src)
            for _, item in pairs(items) do
                inventory[item.slot] = {
                    name = item.name,
                    label = item.label,
                    amount = item.amount,
                    metadata = item.metadata,
                }
            end
        elseif ESX then
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
                if item.amount == nil then item.amount = item.count end -- Simple QBox compatibility fix

                inventory[slot] = {
                    name = item.name,
                    label = item.label,
                    amount = item.amount,
                    metadata = item.info,
                }
            end
        end

        return inventory
    end

    ---@return string firstName
    p.getFirstName = function()
        if ESX then
            return string.split(_fwp.getName(), ' ')[1]
        elseif QB then
            return _fwp.PlayerData.charinfo.firstname
        end
    end

    ---@return string lastName
    p.getLastName = function()
        if ESX then
            return string.split(_fwp.getName(), ' ')[2]
        elseif QB then
            return _fwp.PlayerData.charinfo.lastname
        end
    end

    ---@return string fullName
    p.getFullName = function()
        if ESX then
            return _fwp.getName()
        elseif QB then
            return _fwp.PlayerData.charinfo.firstname .. ' ' .. _fwp.PlayerData.charinfo.lastname
        end
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
            if _fwp.getGroup() == Defaults.ADMIN_ESX then
                return true
            end
        elseif QB then
            if QB.Functions.HasPermission(_fwp.source, Defaults.ADMIN_QB) or QB.Functions.HasPermission(_fwp.source, Defaults.GOD_QB) then
                return true
            end
        end

        return IsPlayerAceAllowed(_fwp.source, 'command')

        -- Want custom admin group? Uncomment below and add the group in server.cfg
        -- IN SERVER.CFG: add_ace group.admin fmLib.admin allow
        -- return IsPlayerAceAllowed(_fwp.source, 'fmLib.admin')
    end

    ---@return string | table group
    p.getGroup = function()
        if ESX then
            return _fwp.getGroup()
        elseif QB then
            return QB.Functions.GetPermission(_fwp.source)
        end
    end

    ---@param message string
    ---@param type? 'success'|'error'
    p.notify = function(message, type)
        if not message then return end

        if ESX then
            TriggerClientEvent('esx:showNotification', _fwp.source, message, type)
        elseif QB then
            TriggerClientEvent('QBCore:Notify', _fwp.source, message, type)
        end
    end

    ---@param item string
    ---@param amount number
    ---@param slotId? number
    ---@param metadata? any
    p.removeItem = function(item, amount, slotId, metadata)
        if not item or not amount then return end

        if OXInv then
            OXInv:RemoveItem(_fwp.source, item, amount, metadata, slotId)
        elseif ESX then
            _fwp.removeInventoryItem(item, amount)
        elseif QB then
            _fwp.Functions.RemoveItem(item, amount)
        end
    end

    ---@param amount number
    ---@param moneyType? string
    ---@param transactionData? { type?: 'deposit' | 'withdraw' | 'transfer' | 'interest' | 'payment', reason?: string, toIban?: string }
    p.removeMoney = function(amount, moneyType, transactionData)
        moneyType = moneyType or Defaults.MONEY
        if not amount then return end

        if transactionData and moneyType == 'bank' then
            if GetResourceState(Resources.RX_BANKING.name) == 'started' then
                local personalAcc = exports[Resources.RX_BANKING.name]:GetPlayerPersonalAccount(p.getIdentifier())
                if personalAcc then
                    exports[Resources.RX_BANKING.name]:CreateTransaction(amount, transactionData.type, personalAcc.iban,
                        transactionData.toIban, transactionData.reason)
                end
            end
        end

        if ESX then
            _fwp.removeAccountMoney(moneyType, amount)
        elseif QB then
            _fwp.Functions.RemoveMoney(moneyType, amount)
        end
    end

    ---@param jobName string
    ---@param jobGrade number
    p.setJob = function(jobName, jobGrade)
        if not jobName or not jobGrade then return end

        if ESX then
            _fwp.setJob(jobName, jobGrade)
        elseif QB then
            _fwp.Functions.SetJob(jobName, jobGrade)
        end
    end

    p.setGang = function(gangName, gangGrade)
        if not gangName or not gangGrade then return end

        if ESX then
            _fwp.setJob(gangName, gangGrade)
        elseif QB then
            _fwp.Functions.SetGang(gangName, gangGrade)
        end
    end

    return p
end

--[[
    INTERNAL EVENT HANDLERS
    DO NOT USE
--]]

FM.callback.register('fm:internal:getGang', function(src)
    return FM.player.get(src).getGang()
end)

-- Aliases
FM.p = FM.player
