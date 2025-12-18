local adapter = {}

function adapter.addWeapon(src, weapon, ammo)
    if not weapon then return false end

    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return false end

    xPlayer.addWeapon(weapon, ammo or 0)
    return true
end

function adapter.getWeapon(src, weapon)
    if not weapon then return end

    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local loadoutNum, weaponData = xPlayer.getWeapon(weapon)
    if not weaponData then return end

    weaponData.count = 1 -- CHEZZAInv compatibility fix
    return {
        name = weaponData.name,
        label = weaponData.label,
        amount = weaponData.count
    }
end

function adapter.removeWeapon(src, weapon)
    if not weapon then return end

    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    xPlayer.removeWeapon(weapon)
end

FM_Adapter_server_inventory_chezza = adapter