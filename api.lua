--[[
    fmLib - API Export System
    Handles exports and proxy creation for external scripts
]]

local function registerExports()
    -- Register exports for adapter categories
    for category, _ in pairs(AdapterResources) do
        if FM[category] then
            for funcName, func in pairs(FM[category]) do
                if type(func) == 'function' then
                    local exportName = category .. '_' .. funcName
                    exports(exportName, function(...)
                        return FM[category][funcName](...)
                    end)
                    Debug(string.format("Registered export: %s", exportName))
                end
            end
        end
    end

    -- Register exports for modules (manual list)
    local modules = {'callback', 'console', 'animation', 'dialog', 'pin', 'loading', 'progress' }
    for _, module in ipairs(modules) do
        if FM[module] then
            for funcName, func in pairs(FM[module]) do
                if type(func) == 'function' then
                    local exportName = module .. '_' .. funcName
                    exports(exportName, function(...)
                        return FM[module][funcName](...)
                    end)
                    Debug(string.format("Registered export: %s", exportName))
                end
            end
        end
    end

    -- Register exports for backwards compatibility categories (not in AdapterResources)
    local backwardsCompatCategories = {'vehicle', 'utils', 'player'}
    for _, category in ipairs(backwardsCompatCategories) do
        if FM[category] then
            for funcName, func in pairs(FM[category]) do
                if type(func) == 'function' then
                    local exportName = category .. '_' .. funcName
                    exports(exportName, function(...)
                        return FM[category][funcName](...)
                    end)
                    Debug(string.format("Registered export (backwards compat): %s", exportName))
                end
            end
        end
    end

    Debug("All exports registered successfully")
end

local function createProxy()
    local proxy = {}

    -- Create proxy for adapter categories
    for category, _ in pairs(AdapterResources) do
        if FM[category] then
            proxy[category] = {}
            for funcName, func in pairs(FM[category]) do
                if type(func) == 'function' then
                    proxy[category][funcName] = function(...)
                        return exports.fmLib[category .. '_' .. funcName](exports.fmLib, ...)
                    end
                end
            end
        end
    end

    -- Create proxy for modules
    local modules = {'callback', 'console', 'animation', 'dialog', 'pin', 'loading', 'progress' }
    for _, module in ipairs(modules) do
        if FM[module] then
            proxy[module] = {}
            for funcName, func in pairs(FM[module]) do
                if type(func) == 'function' then
                    proxy[module][funcName] = function(...)
                        return exports.fmLib[module .. '_' .. funcName](exports.fmLib, ...)
                    end
                end
            end
        end
    end

    -- Create proxy for backwards compatibility categories
    local backwardsCompatCategories = {'vehicle', 'utils', 'player'}
    for _, category in ipairs(backwardsCompatCategories) do
        if FM[category] then
            proxy[category] = {}
            for funcName, func in pairs(FM[category]) do
                if type(func) == 'function' then
                    proxy[category][funcName] = function(...)
                        return exports.fmLib[category .. '_' .. funcName](exports.fmLib, ...)
                    end
                end
            end
        end
    end

    return proxy
end

CreateThread(function()
    registerExports()
    exports('new', createProxy)
    Success("fmLib API system initialized")
end)