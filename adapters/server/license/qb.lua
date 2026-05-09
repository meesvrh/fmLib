local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.has(src, license)
    local p = QB.Functions.GetPlayer(src)
    return p.PlayerData.metadata.licences[license]
end

function adapter.give(src, license)
    local p = QB.Functions.GetPlayer(src)
    if not p then return false end

    local licenses = p.PlayerData.metadata.licences or {}
    if licenses[license] then return false end

    licenses[license] = true
    p.Functions.SetMetaData('licences', licenses)
    return true
end

function adapter.remove(src, license)
    local p = QB.Functions.GetPlayer(src)
    if not p then return false end

    local licenses = p.PlayerData.metadata.licences or {}
    if not licenses[license] then return false end

    licenses[license] = false
    p.Functions.SetMetaData('licences', licenses)
    return true
end

FM_Adapter_server_license_qb = adapter
