--[[
    fmLib - Default Fuel Adapter (Native GTA)
]]

local adapter = {}

function adapter.set(vehicle, fuelLvl)
    if not vehicle or fuelLvl == nil then return end

    fuelLvl = fuelLvl + 0.0
    SetVehicleFuelLevel(vehicle, fuelLvl)
end

FM_Adapter_client_fuel_default = adapter