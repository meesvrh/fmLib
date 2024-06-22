FM.player = {}

---@return boolean
function FM.player.isLoggedIn()
    if ESX then 
        local playerData = ESX.GetPlayerData()
        return playerData ~= nil and playerData.identifier ~= nil
    elseif QB then 
        local playerData = QB.Functions.GetPlayerData()
        return playerData ~= nil and playerData ~= nil and playerData.citizenid ~= nil
    end
end

---@return string | nil
function FM.player.getFullName()
    if ESX then 
        local playerData = ESX.GetPlayerData()
        return playerData ~= nil and tostring(playerData.firstName) .. " " .. tostring(playerData.lastName) or nil
    elseif QB then 
        local playerData = QB.Functions.GetPlayerData()
        return playerData ~= nil and playerData.charinfo.firstname .. " " .. playerData.charinfo.lastname or nil
    end
end

---@return string | nil
function FM.player.getIdentifier()
    if ESX then 
        local playerData = ESX.GetPlayerData()
        return playerData ~= nil and playerData.identifier or nil
    elseif QB then 
        local playerData = QB.Functions.GetPlayerData()
        return playerData ~= nil and playerData.citizenid or nil
    end
end

---@return { name: string, label: string, grade: number, gradeLabel: string } | nil
function FM.player.getJob()
    if ESX then
        local playerData = ESX.GetPlayerData()
        local job = playerData ~= nil and playerData.job or nil

        return job and {
            name = job.name,
            label = job.label,
            grade = job.grade,
            gradeLabel = job.grade_label
        } or nil
    elseif QB then
        local playerData = QB.Functions.GetPlayerData()
        local job = playerData ~= nil and playerData.job or nil

        return job and {
            name = job.name,
            label = job.label,
            grade = job.grade.level,
            gradeLabel = job.grade.name
        } or nil
    end
end