FM.player = {}

local function getPlayerBySrc(src)
    if not src then return end
    return ESX and ESX.GetPlayerFromId(src) or QB and QB.Functions.GetPlayer(src) or nil
end

local function getPlayerByIdentifier(identifier)
    if not identifier then return end
    return ESX and ESX.GetPlayerFromIdentifier(identifier) or QB and QB.Functions.GetPlayerByCitizenId(identifier) or nil
end

---@param id number|string
function FM.player.get(id)
    local _fwp = type(id) == 'number' and getPlayerBySrc(id) or type(id) == 'string' and getPlayerByIdentifier(id) or nil
    if not _fwp or type(p) ~= 'table' then return end

    local p = {}

    ---@return table refreshedPlayer
    p.refresh = function()
        return FM.player.get(_fwp.source)
    end

    ---@return string identifier
    p.getIdentifier = function()
        if ESX then return _fwp.getIdentifier()
        elseif QB then return _fwp.PlayerData.citizenid end
    end

    ---@return string fullName
    p.getFullName = function()
        if ESX then return _fwp.getName()
        elseif QB then return _fwp.PlayerData.charinfo.firstname .. ' ' .. _fwp.PlayerData.charinfo.lastname end
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

    ---@param amount number
    ---@param moneyType? string
    p.addMoney = function(amount, moneyType)
        moneyType = moneyType or Defaults.MONEY
        if not amount then return end

        if ESX then _fwp.addAccountMoney(moneyType, amount)
        elseif QB then _fwp.Functions.AddMoney(moneyType, amount) end
    end

    ---@param amount number
    ---@param moneyType? string
    p.removeMoney = function(amount, moneyType)
        moneyType = moneyType or Defaults.MONEY
        if not amount then return end

        if ESX then _fwp.removeAccountMoney(moneyType, amount)
        elseif QB then _fwp.Functions.RemoveMoney(moneyType, amount) end
    end

    ---@param moneyType? string
    ---@return number amount
    p.getMoney = function(moneyType)
        moneyType = moneyType or Defaults.MONEY

        if ESX then return _fwp.getAccount(moneyType).money
        elseif QB then return _fwp.PlayerData.money[moneyType] end
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
        if ESX then return FM.getJob()
        elseif QB then
            return {
                name = _fwp.PlayerData.gang.name,
                label = _fwp.PlayerData.gang.label,
                grade = _fwp.PlayerData.gang.grade.level,
                gradeLabel = _fwp.PlayerData.gang.grade.name
            }
        end
    end

    ---@return boolean
    p.isAdmin = function()
        if ESX then
            return _fwp.getGroup() == "admin"
        elseif QB then
            return QB.Functions.HasPermission(_fwp.source, "god")
        end
    end

    ---@param item string
    ---@return { name: string, label: string, amount: number } item
    p.getItem = function(item)
        if not item then return end

        if ESX then
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

    ---@param item string
    ---@param amount number
    ---@return boolean
    p.hasItemAmount = function(item, amount)
        if not item then return end

        item = p.getItem(item)
        return item and item.amount >= amount or false
    end

    ---@param item string
    ---@param amount number
    p.addItem = function(item, amount)
        if not item or not amount then return end

        if ESX then _fwp.addInventoryItem(item, amount)
        elseif QB then _fwp.Functions.AddItem(item, amount) end
    end

    ---@param item string
    ---@param amount number
    p.removeItem = function(item, amount)
        if not item or not amount then return end

        if ESX then _fwp.removeInventoryItem(item, amount)
        elseif QB then _fwp.Functions.RemoveItem(item, amount) end
    end

    ---@return { [string]: { amount: number, label: string } } inventory
    p.getInventoryItems = function()
        local inventory = {}

        if ESX then
            local items = _fwp.getInventory()
            for _, v in pairs(items) do
                inventory[v.name] = {
                    amount = v.count,
                    label = v.label,
                }
            end
        elseif QB then
            local items = _fwp.PlayerData.items
            for _, v in pairs(items) do
                inventory[v.name] = {
                    amount = v.amount,
                    label = v.label,
                }
            end
        end

        return inventory
    end
    
    return p
end

FM.p = FM.player