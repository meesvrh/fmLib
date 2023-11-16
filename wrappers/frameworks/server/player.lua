--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
    Discord: http://discord.rxscripts.xyz/
    Store: https://store.rxscripts.xyz/
--]]

FM.player = {}

local function getPlayerBySrc(src)
    if not src then return end
    return ESX and ESX.GetPlayerFromId(src) or QB and QB.Functions.GetPlayer(src) or nil
end

local function getPlayerByIdentifier(identifier)
    if not identifier then return end
    return ESX and ESX.GetPlayerFromIdentifier(identifier) or QB and QB.Functions.GetPlayerByCitizenId(identifier) or nil
end
 
---@param p table|number|string table: player, number: src, string: identifier 
function FM.player.get(p)
    if not p then return end
    return type(p) == 'number' and getPlayerBySrc(p) or type(p) == 'string' and getPlayerByIdentifier(p) or type(p) == 'table' and p or nil
end

---@param p table|number|string table: player, number: src, string: identifier
---@param moneyType? string default: Defaults.MONEY
---@param amount number
function FM.player.addMoney(p, moneyType, amount)
    p = FM.player.get(p)
    moneyType = moneyType or Defaults.MONEY
    if not p or not amount then return end

    if ESX then p.addAccountMoney(moneyType, amount)
    elseif QB then p.Functions.AddMoney(moneyType, amount) end
end

---@param p table|number|string table: player, number: src, string: identifier
---@param moneyType? string default: Defaults.MONEY
---@param amount number
function FM.player.removeMoney(p, moneyType, amount)
    p = FM.player.get(p)
    moneyType = moneyType or Defaults.MONEY
    if not p or not amount then return end

    if ESX then p.removeAccountMoney(moneyType, amount)
    elseif QB then p.Functions.RemoveMoney(moneyType, amount) end
end

---@param p table|number|string table: player, number: src, string: identifier
---@param moneyType? string default: Defaults.MONEY
---@return number amount
function FM.player.getMoney(p, moneyType)
    p = FM.player.get(p)
    moneyType = moneyType or Defaults.MONEY
    if not p then return end

    if ESX then return p.getAccount(moneyType).money
    elseif QB then return p.PlayerData.money[moneyType] end
end

---@param p table|number|string table: player, number: src, string: identifier
---@return { name: string, label: string, grade: number, gradeLabel: string } job
function FM.player.getJob(p)
    p = FM.player.get(p)
    if not p then return end

    if ESX then
        return {
            name = p.job.name,
            label = p.job.label,
            grade = p.job.grade,
            gradeLabel = p.job.grade_label
        }
    elseif QB then
        return {
            name = p.PlayerData.job.name,
            label = p.PlayerData.job.label,
            grade = p.PlayerData.job.grade.level,
            gradeLabel = p.PlayerData.job.grade.name
        }
    end
end

---@param p table|number|string table: player, number: src, string: identifier
---@return { name: string, label: string, grade: number, gradeLabel: string } gang
function FM.player.getGang(p)
    p = FM.player.get(p)
    if not p then return end

    if ESX then return FM.getJob(p)
    elseif QB then
        return {
            name = p.PlayerData.gang.name,
            label = p.PlayerData.gang.label,
            grade = p.PlayerData.gang.grade.level,
            gradeLabel = p.PlayerData.gang.grade.name
        }
    end
end

---@param src number
---@return boolean
function FM.player.isAdmin(src)
    if not src then return end

    if ESX then
        return FM.player.get(src).getGroup() == "admin"
    elseif QB then
        return QB.Functions.HasPermission(src, "god")
    end
end

---@param p table|number|string table: player, number: src, string: identifier
---@param item string
---@return { name: string, label: string, amount: number } item
function FM.player.getItem(p, item)
    p = FM.player.get(p)
    if not p or not item then return end

    if ESX then
        item = p.getInventoryItem(item)
        if not item then return end

        return {
            name = item.name,
            label = item.label,
            amount = item.count
        }
    elseif QB then
        item = p.Functions.GetItemByName(item)
        if not item then return end

        return {
            name = item.name,
            label = item.label,
            amount = item.amount
        }
    end
end

---@param p table|number|string table: player, number: src, string: identifier
---@param item string
---@param amount number
function FM.player.addItem(p, item, amount)
    p = FM.player.get(p)
    if not p or not item or not amount then return end

    if ESX then p.addInventoryItem(item, amount)
    elseif QB then p.Functions.AddItem(item, amount) end
end

---@param p table|number|string table: player, number: src, string: identifier
---@param item string
---@param amount number
function FM.player.removeItem(p, item, amount)
    p = FM.player.get(p)
    if not p or not item or not amount then return end

    if ESX then p.removeInventoryItem(item, amount)
    elseif QB then p.Functions.RemoveItem(item, amount) end
end

---@param p table|number|string table: player, number: src, string: identifier
---@return string firstName
function FM.player.getFirstName(p)
    p = FM.player.get(p)
    if not p then return end

    if ESX then return p.getName().split(' ')[1]
    elseif QB then return p.PlayerData.charinfo.firstname end
end

---@param p table|number|string table: player, number: src, string: identifier
---@return string lastName
function FM.player.getLastName(p)
    p = FM.player.get(p)
    if not p then return end

    if ESX then return p.getName().split(' ')[2]
    elseif QB then return p.PlayerData.charinfo.lastname end
end

---@param p table|number|string table: player, number: src, string: identifier
---@return string fullName
function FM.player.getFullName(p)
    p = FM.player.get(p)
    if not p then return end

    if ESX then return p.getName()
    elseif QB then return p.PlayerData.charinfo.firstname .. ' ' .. p.PlayerData.charinfo.lastname end
end

---@param p table|number|string table: player, number: src, string: identifier
---@return string identifier
function FM.player.getIdentifier(p)
    p = FM.player.get(p)
    if not p then return end

    if ESX then return p.getIdentifier()
    elseif QB then return p.PlayerData.citizenid end
end