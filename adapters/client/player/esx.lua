--[[
    fmLib - ESX Player Client Adapter
]]

local adapter = {}

function adapter.isLoggedIn()
    local playerData = ESX.GetPlayerData()
    return playerData ~= nil and playerData.identifier ~= nil
end

function adapter.getFullName()
    local playerData = ESX.GetPlayerData()
    return playerData ~= nil and tostring(playerData.firstName) .. " " .. tostring(playerData.lastName) or nil
end

function adapter.getIdentifier()
    local playerData = ESX.GetPlayerData()
    return playerData ~= nil and playerData.identifier or nil
end

function adapter.getJob()
    local playerData = ESX.GetPlayerData()
    local job = playerData ~= nil and playerData.job or nil

    return job and {
        name = job.name,
        label = job.label,
        grade = job.grade,
        gradeLabel = job.grade_label
    } or nil
end

function adapter.getGang()
    return FM.callback.sync('fm:internal:getGang')
end

-- Event handlers
function adapter.onJobUpdate(newJob)
    local job = newJob and {
        name = newJob.name,
        label = newJob.label,
        grade = newJob.grade,
        gradeLabel = newJob.grade_label
    } or nil
    TriggerEvent('fm:player:onJobUpdate', job)
end

function adapter.onPlayerLoaded()
    TriggerEvent('fm:player:onPlayerLoaded')
end

FM_Adapter_client_player_esx = adapter

-- Event registrations
RegisterNetEvent('esx:setJob', adapter.onJobUpdate)
RegisterNetEvent('esx:playerLoaded', adapter.onPlayerLoaded)
