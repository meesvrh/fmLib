local ignoreResourceNotFoundErrors = Settings.ignoreResourceNotFoundErrors
local anyNotFound = false

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
    FM.console.err("No core found for "..GetCurrentResourceName(), true)
    anyNotFound = true
end

if anyNotFound then
    FM.console.err('It looks like you have not installed fmLib correctly.')
    FM.console.err('Did you rename a resource? Go to fmLib/settings.lua:Resources')
    FM.console.err('Make sure to ensure fmLib after ensuring all used dependencies that can be found in fmLib/settings.lua:Resources')
end

-- if GetResourceState(Resources.OXTarget or 'ox_target') == 'started' then
--     OXTarget = exports[Resources.OXTarget or 'ox_target']

--     if not ignoreResourceInitializedLogs then
--         FM.console.suc("Initialized OX-Target")
--     end
-- elseif GetResourceState(Resources.QBTarget or 'qb-target') == 'started' then
--     QBTarget = exports[Resources.QBTarget or 'qb-target']

--     if not ignoreResourceInitializedLogs then
--         FM.console.suc("Initialized QB-Target")
--     end
-- elseif not ignoreResourceNotFoundErrors then
--     FM.console.err("No target found for "..GetCurrentResourceName(), true)
--     FM.console.err('Did you rename a resource? Go to fmLib/settings.lua:Resources')
-- end

-- if GetResourceState(Resources.OXInv or 'ox_inventory') == 'started' then
--     OXInv = exports[Resources.OXInv or 'ox_inventory']

--     if not ignoreResourceInitializedLogs then
--         FM.console.suc("Initialized OX-Inventory")
--     end
-- elseif GetResourceState(Resources.QBInv or 'qb-inventory') == 'started' then
--     QBInv = exports[Resources.QBInv or 'qb-inventory']

--     if not ignoreResourceInitializedLogs then
--         FM.console.suc("Initialized QB-Inventory")
--     end
-- elseif not ignoreResourceNotFoundErrors then
--     FM.console.err("No inventory found for "..GetCurrentResourceName(), true)
--     FM.console.err('Did you rename a resource? Go to fmLib/settings.lua:Resources')
-- end