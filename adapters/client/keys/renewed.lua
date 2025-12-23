--[[
    fmLib - Renewed Vehicle Keys Adapter
]]

local adapter = {}
local resourceName  -- Store the resource name

function adapter.init(resource)
    resourceName = resource
end

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports[resourceName]:addKey(plate)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports[resourceName]:removeKey(plate)
end

function adapter.has(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    return exports[resourceName]:hasKey(plate)
end

FM_Adapter_client_keys_renewed = adapter