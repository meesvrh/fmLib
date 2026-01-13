local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.has(src, license)
    local p = QB.Functions.GetPlayer(src)
    return p.PlayerData.metadata.licenses[license]
end

FM_Adapter_server_license_qb = adapter