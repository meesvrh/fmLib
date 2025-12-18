--[[
    fmLib - Adapter Detector
    Detects which resource is available for each category
]]

FM = FM or {}
FM.adapters = FM.adapters or {}
FM.adapters.cache = {}

function FM.adapters.detect(category)
    if FM.adapters.cache[category] then
        return FM.adapters.cache[category]
    end

    -- Special handling for player category - check framework instead
    if category == 'player' then
        local frameworkDetected = FM.adapters.detect('framework')
        if frameworkDetected then
            FM.adapters.cache[category] = frameworkDetected
            return frameworkDetected
        end
    end

    local categoryResources = AdapterResources[category]
    if not categoryResources then
        Error(string.format("Unknown category: %s", category))
        return nil
    end

    for key, resourceName in pairs(categoryResources) do
        if GetResourceState(resourceName) == 'started' then
            Debug(string.format("Detected %s (%s) for %s category", key, resourceName, category))

            FM.adapters.cache[category] = {
                key = key,
                resource = resourceName
            }

            -- Initialize framework objects when framework is detected
            if category == 'framework' then
                if key == 'esx' and not ESX then
                    ESX = exports['es_extended']:getSharedObject()
                    Debug('ESX framework object initialized')
                elseif key == 'qb' and not QB then
                    QB = exports['qb-core']:GetCoreObject()
                    Debug('QB framework object initialized')
                end
            end

            return FM.adapters.cache[category]
        end
    end

    -- Special handling for fuel - use default if no fuel system found
    if category == 'fuel' then
        Debug('No fuel system detected, using native SetVehicleFuelLevel')
        FM.adapters.cache[category] = {
            key = 'default',
            resource = 'native'
        }
        return FM.adapters.cache[category]
    end

    Error(string.format("No %s system detected! Check AdapterResources.%s in settings.lua", category, category))
    return nil
end

function FM.adapters.get(category)
    if not FM.adapters.cache[category] then
        FM.adapters.detect(category)
    end
    return FM.adapters.cache[category]
end

function FM.adapters.clearCache()
    FM.adapters.cache = {}
end