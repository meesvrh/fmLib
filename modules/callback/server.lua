--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
    Discord: http://discord.rxscripts.xyz/
    Store: https://store.rxscripts.xyz/
--]]

local callbacks = {}

FM.callback = {
    register = function(e, cbF)
        callbacks[e] = cbF
    end
}

RegisterNetEvent('fmLib:server:callback', function(e, reqId, ...)
    local src = source

    if not callbacks[e] then
        Err("No callback found for %s", e)
        return
    end

    TriggerClientEvent('fmLib:client:callback', src, reqId, callbacks[e](src, ...))
end)