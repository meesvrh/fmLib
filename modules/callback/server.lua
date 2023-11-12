--[[
    fmLib - A library for FiveM developers

    || *-> Author
    GitHub: https://github.com/meesvrh
    Discord: http://discord.rxscripts.xyz/
    Store: https://store.rxscripts.xyz/
--]]

local callbacks = {}
local requests = {}

local function getRandomReqId(e)
    local reqId
    repeat
        reqId = ('reqId_%s_%s'):format(e, math.random(0, 100000))
    until not requests[reqId]
    return reqId
end

FM.callback = {
    register = function(e, cbF)
        callbacks[e] = cbF
    end,

    async = function(e, src, f, ...)
        local reqId = getRandomReqId(e)
        requests[reqId] = f
        TriggerClientEvent('fmLib:client:callback:request', src, e, reqId, ...)
    end,

    sync = function(e, src, ...)
        local reqId = getRandomReqId(e)
        local cb = promise.new()

        requests[reqId] = function(...)
            cb:resolve({...})
        end

        TriggerClientEvent('fmLib:client:callback:request', src, e, reqId, ...)

        return table.unpack(Citizen.Await(cb))
    end,
}

RegisterNetEvent('fmLib:server:callback:listener', function(reqId, ...)
    requests[reqId](...)
    requests[reqId] = nil
end)

RegisterNetEvent('fmLib:server:callback:request', function(e, reqId, ...)
    local src = source
    if not callbacks[e] then return Err("No callback found for %s", e) end
    TriggerClientEvent('fmLib:client:callback:listener', src, reqId, callbacks[e](src, ...))
end)