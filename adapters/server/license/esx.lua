local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.has(src, license)
    local p = promise.new()

    TriggerEvent('esx_license:checkLicense', src, license, function(hasLicense)
        p:resolve(hasLicense)
    end)

    return Citizen.Await(p)
end

function adapter.give(src, license)
    local p = promise.new()

    TriggerEvent('esx_license:addLicense', src, license, function(rowsChanged)
        p:resolve(type(rowsChanged) == 'number' and rowsChanged > 0)
    end)

    return Citizen.Await(p)
end

function adapter.remove(src, license)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return false end

    local rowsChanged = MySQL.update.await(
        'DELETE FROM user_licenses WHERE type = ? AND owner = ?',
        { license, xPlayer.getIdentifier() }
    )
    return rowsChanged ~= nil and rowsChanged > 0
end

FM_Adapter_server_license_esx = adapter