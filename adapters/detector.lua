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
            return FM.adapters.cache[category]
        end
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