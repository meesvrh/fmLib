--[[
    fmLib - TGIANN Hotwire Adapter
]]

local adapter = {}
local resourceName  -- Store the resource name

function adapter.init(resource)
    resourceName = resource
end

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports[resourceName]:GiveKeyPlate(plate, true)
end

function adapter.has(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    return exports[resourceName]:HasKeyPlate(plate)
end

FM_Adapter_client_keys_tgiann = adapter