--[[
    fmLib - QB Player Client Adapter
]]

local adapter = {}

function adapter.isLoggedIn()
    local playerData = QB.Functions.GetPlayerData()
    return playerData ~= nil and playerData ~= nil and playerData.citizenid ~= nil
end

function adapter.getFullName()
    local playerData = QB.Functions.GetPlayerData()
    return playerData ~= nil and playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname or nil
end

function adapter.getIdentifier()
    local playerData = QB.Functions.GetPlayerData()
    return playerData ~= nil and playerData.citizenid or nil
end

function adapter.getJob()
    local playerData = QB.Functions.GetPlayerData()
    local job = playerData ~= nil and playerData.job or nil

    return job and {
        name = job.name,
        label = job.label,
        grade = job.grade.level,
        gradeLabel = job.grade.name
    } or nil
end

function adapter.getGang()
    return FM.callback.sync('fm:internal:getGang')
end

FM_Adapter_client_player_qb = adapter
