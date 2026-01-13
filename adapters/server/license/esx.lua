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

FM_Adapter_server_license_esx = adapter