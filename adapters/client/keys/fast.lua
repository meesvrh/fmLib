--[[
    fmLib - Fast Vehicle Keys Adapter
]]

local adapter = {}
local resourceName  -- Store the resource name

function adapter.init(resource)
    resourceName = resource
end

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    exports[resourceName]:GiveKey(plate)
end

FM_Adapter_client_keys_fast = adapter