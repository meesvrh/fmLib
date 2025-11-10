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

---@param clothingData table The clothing data to apply
function FM.player.setOutfit(clothingData)
    local playerPed = PlayerPedId()

    if FMAPP or ILA then
        local propMapping = {
            [0] = { drawable = 'helmet_1', texture = 'helmet_2' },
            [1] = { drawable = 'glasses_1', texture = 'glasses_2' },
        }

        local componentMapping = {
            [1] = { drawable = 'mask_1', texture = 'mask_2' },
            [3] = { drawable = 'arms', texture = nil },
            [4] = { drawable = 'pants_1', texture = 'pants_2' },
            [5] = { drawable = 'bag', texture = 'bag_color' },
            [6] = { drawable = 'shoes_1', texture = 'shoes_2' },
            [7] = { drawable = 'chain_1', texture = 'chain_2' },
            [8] = { drawable = 'tshirt_1', texture = 'tshirt_2' },
            [9] = { drawable = 'bproof_1', texture = 'bproof_2' },
            [10] = { drawable = 'decals_1', texture = 'decals_2' },
            [11] = { drawable = 'torso_1', texture = 'torso_2' },
        }

        local props = {}
        for id, prop in pairs(propMapping) do
            props[#props + 1] = {
                component_id = id,
                drawable = clothingData[prop.drawable] or 0,
                texture = clothingData[prop.texture] or 0
            }
        end

        local components = {}
        for id, comp in pairs(componentMapping) do
            components[#components + 1] = {
                component_id = id,
                drawable = clothingData[comp.drawable] or 0,
                texture = comp.texture and (clothingData[comp.texture] or 0) or 0
            }
        end

        exports[FMAPP and 'fivem-appearance' or 'illenium-appearance']:setPedProps(playerPed, props)
        exports[FMAPP and 'fivem-appearance' or 'illenium-appearance']:setPedComponents(playerPed, components)
    elseif ESXSKIN then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadClothes', skin, clothingData)
        end)
    elseif QBClothing then
        TriggerEvent('qb-clothing:client:loadOutfit', { outfitData = clothingData })
    else
        FM.console.err("No clothing resource found")
    end
end

function FM.player.loadSkin()
    if ILA then
        TriggerEvent("illenium-appearance:client:reloadSkin")
    elseif ESX then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
            TriggerEvent('esx:restoreLoadout')
        end)
    elseif QB then
        TriggerServerEvent('qb-clothes:loadPlayerSkin')
    else
        FM.console.err("No framework found to load player skin")
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

local function onGangUpdate(newGang)
    TriggerEvent('fm:player:onGangUpdate', FM.player.getGang())
end

-- We do not send player data, because for ESX its also sent when there is no character selected yet.
-- After this event gets triggered, use FM.player.isLoggedIn to check if the player is logged in & to make sure the character is selected.
local function onPlayerLoaded()
    TriggerEvent('fm:player:onPlayerLoaded')
end

RegisterNetEvent('esx:setJob', onJobUpdate)
RegisterNetEvent('QBCore:Client:OnJobUpdate', onJobUpdate)
RegisterNetEvent('QBCore:Client:OnGangUpdate', onGangUpdate)
RegisterNetEvent('esx:playerLoaded', onPlayerLoaded)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', onPlayerLoaded)
