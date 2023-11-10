--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
    Discord: http://discord.rxscripts.xyz/
    Store: https://store.rxscripts.xyz/
--]]

FM = {}
function FM:construct()
    setmetatable({}, self)
    self.__index = self
    return self
end
exports('new', function()
    return FM:construct()
end)

local ignoreResourceNotFoundErrors = Settings.ignoreResourceNotFoundErrors

function Err(str, ...)
    local strF = ... and string.format(str, ...) or str
    print("^7(^8ERROR^7) ^8"..strF.."^0")
end

if GetResourceState(Resources.ESX or 'es_extended') ~= 'missing' then
    ESX = exports[Resources.ESX or 'es_extended']:getSharedObject()
elseif GetResourceState(Resources.QB or 'qb-core') ~= 'missing' then
    QB = exports[Resources.QB or 'qb-core']:GetCoreObject()
elseif not ignoreResourceNotFoundErrors then
    Err("No core found for %s", GetCurrentResourceName())
    Err('Did you rename a resource? Go to fmLib/init.lua:8')
end

if GetResourceState(Resources.OXTarget or 'ox_target') ~= 'missing' then
    OXTarget = exports[Resources.OXTarget or 'ox_target']
elseif GetResourceState(Resources.QBTarget or 'qb-target') ~= 'missing' then
    QBTarget = exports[Resources.QBTarget or 'qb-target']
elseif not ignoreResourceNotFoundErrors then
    Err("No target found for %s", GetCurrentResourceName())
    Err('Did you rename a resource? Go to fmLib/init.lua:8')
end

if GetResourceState(Resources.OXInv or 'ox_inventory') ~= 'missing' then
    OXInv = exports[Resources.OXInv or 'ox_inventory']
elseif GetResourceState(Resources.QBInv or 'qb-inventory') ~= 'missing' then
    QBInv = exports[Resources.QBInv or 'qb-inventory']
elseif not ignoreResourceNotFoundErrors then
    Err("No inventory found for %s", GetCurrentResourceName())
    Err('Did you rename a resource? Go to fmLib/init.lua:8')
end