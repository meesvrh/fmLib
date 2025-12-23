--[[
    fmLib - QBX Vehicle Keys Adapter
]]

local adapter = {}
local resourceName  -- Store the resource name

function adapter.init(resource)
    resourceName = resource
end

function adapter.give(vehicle)
    if not vehicle then return end
    exports[resourceName]:GiveKeys(vehicle)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    exports[resourceName]:RemoveKeys(vehicle)
end

function adapter.has(vehicle)
    if not vehicle then return end
    return exports[resourceName]:HasKeys(vehicle)
end

FM_Adapter_client_keys_qbx = adapter