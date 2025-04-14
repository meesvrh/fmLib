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
    elseif WASABI_CARLOCK then
        WASABI_CARLOCK:GiveKey(plate)
    elseif TGIANN_HOTWIRE then
        TGIANN_HOTWIRE:GiveKeyPlate(plate, true)
    elseif MM_CARKEYS then
        MM_CARKEYS:GiveKey(plate)
    end
end

---@param vehicle number
function FM.vehicle.removeKeys(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)

    if RenewedVehKeys then
        RenewedVehKeys:removeKey(plate)
    elseif WASABIKEY then
        WASABIKEY:RemoveKey(plate)
    elseif MM_CARKEYS then
        MM_CARKEYS:RemoveKey(plate)
    end
end

---@param vehicle number
function FM.vehicle.hasKey(vehicle)
    if not vehicle then return end
    local plate = FM.vehicle.getPlate(vehicle)

    if RenewedVehKeys then
        RenewedVehKeys:hasKey(plate)
    elseif WASABI_CARLOCK then
        WASABI_CARLOCK:HasKey(plate)
    elseif TGIANNKeys then
        TGIANNKeys:HaveKeyPlate(plate)
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
    elseif CDN_FUEL then
        CDN_FUEL:SetFuel(vehicle, fuelLvl)
    elseif RENEWED_FUEL then
        RENEWED_FUEL:SetFuel(vehicle, fuelLvl)
    elseif QBFUEL then
        QBFUEL:SetFuel(vehicle, fuelLvl)
    elseif LC_FUEL then
        LC_FUEL:SetFuel(vehicle, fuelLvl)
    elseif PS_FUEL then
        PS_FUEL:SetFuel(vehicle, fuelLvl)
    elseif RCORE_FUEL then
        RCORE_FUEL:SetFuel(vehicle, fuelLvl)
    elseif QS_FUEL then
        QS_FUEL:SetFuel(vehicle, fuelLvl)
    elseif ND_FUEL then
        ND_FUEL:SetFuel(vehicle, fuelLvl)
    elseif BIGDADDY_FUEL then
        BIGDADDY_FUEL:SetFuel(vehicle, fuelLvl)
    elseif GKS_FUEL then
        GKS_FUEL:SetFuel(vehicle, fuelLvl)
    elseif RIP_FUEL then
        RIP_FUEL:SetFuel(vehicle, fuelLvl)
    elseif MYFUEL then
        MYFUEL:SetFuel(vehicle, fuelLvl)
    else
        SetVehicleFuelLevel(vehicle, fuelLvl)
    end
end
