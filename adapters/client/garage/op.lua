--[[
    fmLib - OtherPlanet Client Adapter
]]

local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.open(garageId, coords)
    exports[resourceName]:OpenGarageHere(coords, true)
end

function adapter.parkVehicle(garageId)
    exports[resourceName]:OpenGarageHere(vec4(0,0,0,0), true)
end

FM_Adapter_client_garage_op = adapter