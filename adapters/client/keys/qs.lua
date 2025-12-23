--[[
    fmLib - QS Vehicle Keys Adapter
]]

local adapter = {}
local resourceName  -- Store the resource name

function adapter.init(resource)
    resourceName = resource
end

function adapter.give(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    exports[resourceName]:GiveKeys(plate, model, true)
end

function adapter.remove(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    exports[resourceName]:RemoveKeys(plate, model)
end

function adapter.has(vehicle)
    if not vehicle then return end
    local plate = FM.framework.getPlate(vehicle)
    return exports[resourceName]:GetServerKey(plate)
end

FM_Adapter_client_keys_qs = adapter