FM.utils = {}

---@param src number
---@param message string
---@param type? 'success'|'error'
function FM.utils.notify(src, message, type)
    if not src then return end
    if not message then return end

    if ESX then TriggerClientEvent('esx:showNotification', src, message, type)
    elseif QB then TriggerClientEvent('QBCore:Notify', src, message, type) end
end

function FM.utils.getPlayers()
    local playerSources = GetPlayers()

    local players = {}
    for k, src in pairs(playerSources) do
        players[src] = FM.player.get(tonumber(src))
    end
    
    return players
end