--[[
    fmLib - RxGarages Client Adapter
]]

local adapter = {}

function adapter.open(garageId, coords)
    exports['RxGarages']:OpenGarage("House Garage ("..tostring(garageId)..")", 'garage', 'car', coords)
end

function adapter.parkVehicle(garageId)
    exports['RxGarages']:ParkVehicle("House Garage ("..tostring(garageId)..")", 'garage', 'car')
end

FM_Adapter_client_garage_rx = adapter