--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
    Discord: http://discord.rxscripts.xyz/
    Store: https://store.rxscripts.xyz/
--]]


local ignoreResourceNotFoundErrors = Settings.ignoreResourceNotFoundErrors

if GetResourceState(Resources.ESX or 'es_extended') ~= 'missing' then
    ESX = exports[Resources.ESX or 'es_extended']:getSharedObject()

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized ESX")
    end
elseif GetResourceState(Resources.QB or 'qb-core') ~= 'missing' then
    QB = exports[Resources.QB or 'qb-core']:GetCoreObject()

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized QB-Core")
    end
elseif not ignoreResourceNotFoundErrors then
    FM.console.err("No core found for %s", GetCurrentResourceName())
    FM.console.err('Did you rename a resource? Go to fmLib/init.lua:8')
end

if GetResourceState(Resources.OXTarget or 'ox_target') ~= 'missing' then
    OXTarget = exports[Resources.OXTarget or 'ox_target']

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized OX-Target")
    end
elseif GetResourceState(Resources.QBTarget or 'qb-target') ~= 'missing' then
    QBTarget = exports[Resources.QBTarget or 'qb-target']

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized QB-Target")
    end
elseif not ignoreResourceNotFoundErrors then
    FM.console.err("No target found for %s", GetCurrentResourceName())
    FM.console.err('Did you rename a resource? Go to fmLib/init.lua:8')
end

if GetResourceState(Resources.OXInv or 'ox_inventory') ~= 'missing' then
    OXInv = exports[Resources.OXInv or 'ox_inventory']

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized OX-Inventory")
    end
elseif GetResourceState(Resources.QBInv or 'qb-inventory') ~= 'missing' then
    QBInv = exports[Resources.QBInv or 'qb-inventory']

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized QB-Inventory")
    end
elseif not ignoreResourceNotFoundErrors then
    FM.console.err("No inventory found for %s", GetCurrentResourceName())
    FM.console.err('Did you rename a resource? Go to fmLib/init.lua:8')
end