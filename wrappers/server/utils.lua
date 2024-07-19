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

---@param filter? { job?: string, gang?: string, count?: boolean }
function FM.utils.getPlayers(filter)
    local playerSources = GetPlayers()

    local players = {}
    for _, src in pairs(playerSources) do
        local p = FM.player.get(tonumber(src))
        if not p then goto continue end

        if not filter then
            players[src] = p
        else
            if filter.job then
                local job = p.getJob()
                if job and job.name == filter.job then
                    players[src] = p
                end
            end

            if filter.gang then
                local gang = p.getGang()
                if gang and gang.name == filter.gang then
                    players[src] = p
                end
            end

            if filter.count then
                local count = 0
                for _, _ in pairs(players) do count = count + 1 end
                return count
            end
        end

        ::continue::
    end
    
    return players
end