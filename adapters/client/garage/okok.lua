--[[
    fmLib - okokGarage Client Adapter
]]

local adapter = {}

function adapter.open(garageId, coords)
    TriggerEvent("okokGarage:OpenPrivateGarageMenu", vector3(coords.x, coords.y, coords.z), coords.w)
end

function adapter.parkVehicle(garageId)
    TriggerEvent("okokGarage:StoreVehiclePrivate")
end

FM_Adapter_client_garage_okok = adapter