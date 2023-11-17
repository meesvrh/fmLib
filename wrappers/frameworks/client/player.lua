FM.player = {}

---@return boolean
function FM.player.isPlayerLoaded(src)
    if not src then return end

    if ESX then 
        local playerData = ESX.GetPlayerData()
        return playerData ~= nil and playerData.identifier ~= nil
    elseif QB then 
        local playerData = QB.Functions.GetPlayerData()
        return playerData ~= nil and playerData ~= nil and playerData.citizenid ~= nil
    end
end