--[[
    fmLib - Adapter Detector
    Detects which resource is available for each category
]]

FM = FM or {}
FM.adapters = FM.adapters or {}
FM.adapters.cache = {}

-- Lazy-loading proxy objects for frameworks
if not ESX then
    ESX = setmetatable({}, {
        __index = function(self, key)
            if GetResourceState('es_extended') ~= 'started' then
                Error('Attempted to use ESX but es_extended is not running')
                return nil
            end
            local realESX = exports['es_extended']:getSharedObject()
            ESX = realESX
            Debug('ESX framework object lazy-loaded on first use')
            return realESX[key]
        end
    })
end

if not QB then
    QB = setmetatable({}, {
        __index = function(self, key)
            if GetResourceState('qb-core') ~= 'started' then
                Error('Attempted to use QB but qb-core is not running')
                return nil
            end
            local realQB = exports['qb-core']:GetCoreObject()
            QB = realQB
            Debug('QB framework object lazy-loaded on first use')
            return realQB[key]
        end
    })
end

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

    for _, entry in ipairs(categoryResources) do
        if GetResourceState(entry.resource) == 'started' then
            Debug(string.format("Detected %s (%s) for %s category", entry.key, entry.resource, category))

            FM.adapters.cache[category] = {
                key = entry.key,
                resource = entry.resource
            }
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

    Debug(string.format("No %s system detected", category))
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