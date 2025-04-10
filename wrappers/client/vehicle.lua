FM.vehicle = {}

---@param vehicle number
function FM.vehicle.getPlate(vehicle)
    if not vehicle then return end

    if ESX then
        return ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
    elseif QB then
        return QB.Functions.GetPlate(vehicle)
    end
end

---@param vehicle number
function FM.vehicle.giveKeys(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

    if QBVehKeys then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
    elseif CDGarage then
        TriggerEvent('cd_garage:AddKeys', plate)
    elseif okokGarage then
        TriggerServerEvent('okokGarage:GiveKeys', plate)
    elseif QSVehKeys then
        QSVehKeys:GiveKeys(plate, model, true)
    elseif RenewedVehKeys then
        RenewedVehKeys:addKey(plate)
    elseif WasabiCarlock then
        WasabiCarlock:GiveKey(plate)
    elseif ISVehicleKeys then
        ISVehicleKeys:GiveKey(plate)
    end
end

---@param vehicle number
function FM.vehicle.removeKeys(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)

    if RenewedVehKeys then
        RenewedVehKeys:removeKey(plate)
    elseif WasabiCarlock then
        WasabiCarlock:RemoveKey(plate)
    elseif ISVehicleKeys then
        ISVehicleKeys:RemoveKey(plate)
    end
end

---@param vehicle number
function FM.vehicle.hasKey(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)

    if RenewedVehKeys then
        RenewedVehKeys:hasKey(plate)
    elseif WasabiCarlock then
        WasabiCarlock:HasKey(plate)
    elseif ISVehicleKeys then
        ISVehicleKeys:HasKey(plate)
    end
end


---@param vehicle number
---@param fuelLvl number
function FM.vehicle.setFuel(vehicle, fuelLvl)
    if not vehicle or fuelLvl == nil then return end

    fuelLvl = fuelLvl + 0.0

    if OXFUEL then
        Entity(vehicle).state.fuel = fuelLvl
    elseif LEGACYFUEL then
        LEGACYFUEL:SetFuel(vehicle, fuelLvl)
    else
        SetVehicleFuelLevel(vehicle, fuelLvl)
    end
end