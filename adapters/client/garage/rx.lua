--[[
    fmLib - RxGarages Client Adapter
]]

local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.open(garageId, coords)
    exports[resourceName]:OpenGarage("House Garage ("..tostring(garageId)..")", 'garage', 'car', coords)
end

function adapter.parkVehicle(garageId)
    exports[resourceName]:ParkVehicle("House Garage ("..tostring(garageId)..")", 'garage', 'car')
end

FM_Adapter_client_garage_rx = adapter