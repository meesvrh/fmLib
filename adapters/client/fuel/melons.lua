--[[
    fmLib - Melons Fuel Adapter
]]

local adapter = {}
local resourceName  -- Store the resource name

function adapter.init(resource)
    resourceName = resource
end

function adapter.set(vehicle, fuelLvl)
    if not vehicle or fuelLvl == nil then return end

    fuelLvl = fuelLvl + 0.0
    exports[resourceName]:SetFuel(vehicle, fuelLvl)
end

FM_Adapter_client_fuel_melons = adapter