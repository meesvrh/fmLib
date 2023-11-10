--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
    Discord: http://discord.rxscripts.xyz/
    Store: https://store.rxscripts.xyz/
--]]

local callbacks = {}

local function getRandomReqId(e)
    local reqId
    repeat
        reqId = ('reqId_%s_%f'):format(e, math.random(0, 100000))
    until not callbacks[reqId]
    return reqId
end

FM.callback = {
    sync = function(e, cbF, ...)
        local reqId = getRandomReqId(e)
        callbacks[reqId] = cbF
        TriggerServerEvent('fmLib:server:callback', e, reqId, ...)
    end
}

RegisterNetEvent('fmLib:client:callback', function(reqId, ...)
    callbacks[reqId](...)
    callbacks[reqId] = nil
end)