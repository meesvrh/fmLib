FM.player = {}

local function getPlayerBySrc(src)
    if not src then return end
    return ESX and ESX.GetPlayerFromId(src) or QB and QB.Functions.GetPlayer(src) or nil
end

local function getPlayerByIdentifier(identifier)
    if not identifier then return end
    return ESX and ESX.GetPlayerFromIdentifier(identifier) or QB and QB.Functions.GetPlayerByCitizenId(identifier) or nil
end

---@param amount number
---@param moneyType? string
function FM.player:addMoney(amount, moneyType)
    moneyType = moneyType or Defaults.MONEY
    if not amount then return end

    if ESX then self._fwp.addAccountMoney(moneyType, amount)
    elseif QB then self._fwp.Functions.AddMoney(moneyType, amount) end
end

---@param amount number
---@param moneyType? string
function FM.player:removeMoney(amount, moneyType)
    moneyType = moneyType or Defaults.MONEY
    if not amount then return end

    if ESX then self._fwp.removeAccountMoney(moneyType, amount)
    elseif QB then self._fwp.Functions.RemoveMoney(moneyType, amount) end
end

---@param moneyType? string
---@return number amount
function FM.player:getMoney(moneyType)
    moneyType = moneyType or Defaults.MONEY

    if ESX then return self._fwp.getAccount(moneyType).money
    elseif QB then return self._fwp.PlayerData.money[moneyType] end
end

---@return { name: string, label: string, grade: number, gradeLabel: string } job
function FM.player:getJob()
    if ESX then
        return {
            name = self._fwp.job.name,
            label = self._fwp.job.label,
            grade = self._fwp.job.grade,
            gradeLabel = self._fwp.job.grade_label
        }
    elseif QB then
        return {
            name = self._fwp.PlayerData.job.name,
            label = self._fwp.PlayerData.job.label,
            grade = self._fwp.PlayerData.job.grade.level,
            gradeLabel = self._fwp.PlayerData.job.grade.name
        }
    end
end

---@return { name: string, label: string, grade: number, gradeLabel: string } gang
function FM.player:getGang()
    if ESX then return FM.getJob()
    elseif QB then
        return {
            name = self._fwp.PlayerData.gang.name,
            label = self._fwp.PlayerData.gang.label,
            grade = self._fwp.PlayerData.gang.grade.level,
            gradeLabel = self._fwp.PlayerData.gang.grade.name
        }
    end
end

---@return boolean
function FM.player:isAdmin()
    if ESX then
        return self._fwp.getGroup() == "admin"
    elseif QB then
        return QB.Functions.HasPermission(self._fwp.source, "god")
    end
end

---@param item string
---@return { name: string, label: string, amount: number } item
function FM.player:getItem(item)
    if not item then return end

    if ESX then
        item = self._fwp.getInventoryItem(item)
        if not item then return end

        return {
            name = item.name,
            label = item.label,
            amount = item.count
        }
    elseif QB then
        item = self._fwp.Functions.GetItemByName(item)
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
function FM.player:hasItemAmount(item, amount)
    if not item then return end

    item = self:getItem(item)
    return item and item.amount >= amount or false
end

---@param item string
---@param amount number
function FM.player:addItem(item, amount)
    if not item or not amount then return end

    if ESX then self._fwp.addInventoryItem(item, amount)
    elseif QB then self._fwp.Functions.AddItem(item, amount) end
end

---@param item string
---@param amount number
function FM.player:removeItem(item, amount)
    if not item or not amount then return end

    if ESX then self._fwp.removeInventoryItem(item, amount)
    elseif QB then self._fwp.Functions.RemoveItem(item, amount) end
end

---@return { [string]: { amount: number, label: string } } inventory
function FM.player:getInventoryItems()
    local inventory = {}

    if ESX then
        local items = self._fwp.getInventory()
        for _, v in pairs(items) do
            inventory[v.name] = {
                amount = v.count,
                label = v.label,
            }
        end
    elseif QB then
        local items = self._fwp.PlayerData.items
        for _, v in pairs(items) do
            inventory[v.name] = {
                amount = v.amount,
                label = v.label,
            }
        end
    end

    return inventory
end

---@return string firstName
function FM.player:getFirstName()
    if ESX then return self._fwp.getName().split(' ')[1]
    elseif QB then return self._fwp.PlayerData.charinfo.firstname end
end

---@return string lastName
function FM.player:getLastName()
    if ESX then return self._fwp.getName().split(' ')[2]
    elseif QB then return self._fwp.PlayerData.charinfo.lastname end
end

---@return string fullName
function FM.player:getFullName()
    if ESX then return self._fwp.getName()
    elseif QB then return self._fwp.PlayerData.charinfo.firstname .. ' ' .. self._fwp.PlayerData.charinfo.lastname end
end

---@return string identifier
function FM.player:getIdentifier()
    if ESX then return self._fwp.getIdentifier()
    elseif QB then return self._fwp.PlayerData.citizenid end
end

---@param id number|string
function FM.player:get(id)
    local p = type(id) == 'number' and getPlayerBySrc(id) or type(id) == 'string' and getPlayerByIdentifier(id) or nil
    if not p or type(p) ~= 'table' then return end

    return {
        addMoney = self.addMoney,
        addItem = self.addItem,
        getJob = self.getJob,
        getGang = self.getGang,
        getMoney = self.getMoney,
        getItem = self.getItem,
        getInventoryItems = self.getInventoryItems,
        getFirstName = self.getFirstName,
        getLastName = self.getLastName,
        getFullName = self.getFullName,
        getIdentifier = self.getIdentifier,
        hasItemAmount = self.hasItemAmount,
        isAdmin = self.isAdmin,
        removeMoney = self.removeMoney,
        removeItem = self.removeItem,
        _fwp = p
    }
end

FM.p = FM.player