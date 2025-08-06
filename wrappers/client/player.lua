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

---@return { name: string, label: string, grade: number, gradeLabel: string } | nil gang
function FM.player.getGang()
    return FM.callback.sync('fm:internal:getGang')
end

---@param propertyId? string The property ID (optional unique identifier)
function FM.player.openWardrobe(propertyId)
    if FMAPP then
        FMAPP:openWardrobe()
    elseif ILA then
        TriggerEvent("illenium-appearance:client:openOutfitMenu")
    elseif QBClothing then
        TriggerEvent('qb-clothing:client:openMenu')
    elseif ESXSKIN then
        TriggerEvent('esx_skin:openSaveableMenu')
    elseif CRM then
        TriggerEvent('crm-appearance:show-outfits')
    else
        FM.console.err("No wardrobe resource found")
    end
end

--[[
    EVENT HANDLERS
--]]

local function onJobUpdate(newJob)
    local job
    if ESX then
        job = newJob and {
            name = newJob.name,
            label = newJob.label,
            grade = newJob.grade,
            gradeLabel = newJob.grade_label
        } or nil
    elseif QB then
        job = newJob and {
            name = newJob.name,
            label = newJob.label,
            grade = newJob.grade.level,
            gradeLabel = newJob.grade.name
        } or nil
    end

    TriggerEvent('fm:player:onJobUpdate', job)
end

-- We do not send player data, because for ESX its also sent when there is no character selected yet.
-- After this event gets triggered, use FM.player.isLoggedIn to check if the player is logged in & to make sure the character is selected.
local function onPlayerLoaded()
    TriggerEvent('fm:player:onPlayerLoaded')
end

RegisterNetEvent('esx:setJob', onJobUpdate)
RegisterNetEvent('QBCore:Client:OnJobUpdate', onJobUpdate)
RegisterNetEvent('esx:playerLoaded', onPlayerLoaded)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', onPlayerLoaded)
