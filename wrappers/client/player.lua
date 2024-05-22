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