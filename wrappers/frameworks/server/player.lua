--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
    Discord: http://discord.rxscripts.xyz/
    Store: https://store.rxscripts.xyz/
--]]

local function getPlayerBySrc(src)
    if not src then return end
    return ESX and ESX.GetPlayerFromId(src) or QB and QB.Functions.GetPlayer(src) or nil
end

local function getPlayerByIdentifier(identifier)
    if not identifier then return end
    return ESX and ESX.GetPlayerFromIdentifier(identifier) or QB and QB.Functions.GetPlayerByCitizenId(identifier) or nil
end

---@param p table|number|string|nil table: player, number: src, string: identifier
function FM.getPlayer(p)
    if not p then return end
    return type(p) == 'number' and getPlayerBySrc(p) or type(p) == 'string' and getPlayerByIdentifier(p) or type(p) == 'table' and p or nil
end

---@param p table|number|string|nil table: player, number: src, string: identifier
---@param moneyType? string default: Defaults.MONEY
---@param amount number
function FM.addMoney(p, moneyType, amount)
    p = FM.getPlayer(p)
    moneyType = moneyType or Defaults.MONEY
    if not p or not amount then return false end

    if ESX then p.addAccountMoney(moneyType, amount)
    elseif QB then p.Functions.AddMoney(moneyType, amount) end
end

---@param p table|number|string|nil table: player, number: src, string: identifier
---@param moneyType? string default: Defaults.MONEY
---@param amount number
function FM.removeMoney(p, moneyType, amount)
    p = FM.getPlayer(p)
    moneyType = moneyType or Defaults.MONEY
    if not p or not amount then return false end

    if ESX then p.removeAccountMoney(moneyType, amount)
    elseif QB then p.Functions.RemoveMoney(moneyType, amount) end
end

---@param p table|number|string|nil table: player, number: src, string: identifier
---@param moneyType? string default: Defaults.MONEY
function FM.getMoney(p, moneyType)
    p = FM.getPlayer(p)
    moneyType = moneyType or Defaults.MONEY
    if not p then return false end

    if ESX then return p.getAccount(moneyType).money
    elseif QB then return p.PlayerData.money[moneyType] end
end