--[[
    fmLib - JG Advanced Garages Client Adapter
]]

local adapter = {}

function adapter.open(garageId, coords)
    TriggerEvent("jg-advancedgarages:client:open-garage", "House: "..tostring(garageId), "car", coords)
end

function adapter.parkVehicle(garageId)
    TriggerEvent("jg-advancedgarages:client:store-vehicle", "House: "..tostring(garageId), "car")
end

FM_Adapter_client_garage_jg = adapter