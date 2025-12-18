--[[
    fmLib - CodeM Garage Client Adapter
]]

local adapter = {}

function adapter.open(garageId, coords)
    TriggerEvent("codem-garage:openHouseGarage", garageId)
end

function adapter.parkVehicle(garageId)
    TriggerEvent("codem-garage:storeVehicle", garageId)
end

FM_Adapter_client_garage_codem = adapter