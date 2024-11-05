FM.vehicle = {}

---@param vehicle string
function FM.vehicle.getPlate(vehicle)
    if not vehicle then return end

    if ESX then
        return ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
    elseif QB then
        return QB.Functions.GetPlate(vehicle)
    end
end

---@param vehicle string
function FM.vehicle.giveKeys(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)

    if QBVehKeys then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
    elseif CDGarage then
        TriggerEvent('cd_garage:AddKeys', plate)
    elseif okokGarage then
        TriggerServerEvent('okokGarage:GiveKeys', plate)
    elseif QSVehKeys then
        local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
        QSVehKeys:GiveKeys(plate, model, true)
    end
end

---@param vehicle string
---@param fuelLvl number
function FM.vehicle.setFuel(vehicle, fuelLvl)
    if not vehicle or fuel == nil then return end

    if LEGACYFUEL then
        LEGACYFUEL:SetFuel(vehicle, fuelLvl)
    elseif OXFUEL then
        Entity(vehicle).state.fuel = fuelLvl
    else
        SetVehicleFuelLevel(vehicle, fuelLvl)
    end
end