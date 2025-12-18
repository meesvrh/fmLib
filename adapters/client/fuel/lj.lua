--[[
    fmLib - LJ Fuel Adapter
]]

local adapter = {}

function adapter.set(vehicle, fuelLvl)
    if not vehicle or fuelLvl == nil then return end

    fuelLvl = fuelLvl + 0.0
    exports['lj-fuel']:SetFuel(vehicle, fuelLvl)
end

FM_Adapter_client_fuel_lj = adapter