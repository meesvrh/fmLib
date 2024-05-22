local ignoreResourceNotFoundErrors = Settings.ignoreResourceNotFoundErrors

-- TODO: automate the process through Resources table

--[[
    FRAMEWORKS
]]
if GetResourceState(Resources.ESX or 'es_extended') == 'started' then
    ESX = exports[Resources.ESX or 'es_extended']:getSharedObject()

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized ESX")
    end
elseif GetResourceState(Resources.QB or 'qb-core') == 'started' then
    QB = exports[Resources.QB or 'qb-core']:GetCoreObject()

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized QB-Core")
    end
elseif not ignoreResourceNotFoundErrors then
    FM.console.err("No core found for "..GetCurrentResourceName(), false)
    FM.console.err('Did you rename a resource? Go to fmLib/settings.lua:Resources')
end

--[[
    INVENTORIES
]]
if GetResourceState(Resources.OXInv or 'ox_inventory') == 'started' then
    OXInv = exports[Resources.OXInv or 'ox_inventory']

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized OX-Inventory")
    end
elseif GetResourceState(Resources.QBInv or 'qb-inventory') == 'started' then
    QBInv = exports[Resources.QBInv or 'qb-inventory']

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized QB-Inventory")
    end
elseif GetResourceState(Resources.QSInv or 'qs-inventory') == 'started' then
    QSInv = exports[Resources.QSInv or 'qs-inventory']

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized QS-Inventory")
    end
elseif GetResourceState(Resources.PSInv or 'ps-inventory') == 'started' then
    PSInv = exports[Resources.PSInv or 'ps-inventory']

    if not ignoreResourceInitializedLogs then
        FM.console.suc("Initialized QS-Inventory")
    end
elseif not ignoreResourceNotFoundErrors then
    FM.console.err("No inventory found for "..GetCurrentResourceName(), false)
    FM.console.err('Did you rename a resource? Go to fmLib/settings.lua:Resources')
end