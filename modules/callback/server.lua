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
    ---@param e string -- event name
    ---@param cbF function -- callback function
    ---Register a callback
    register = function(e, cbF)
        callbacks[e] = cbF
    end,

    ---@param e string -- event name
    ---@param src number -- source
    ---@param f function -- response function
    ---@param ... any -- arguments
    ---@async
    ---Perform an asynchronous callback request
    async = function(e, src, f, ...)
        local reqId = getRandomReqId(e)
        requests[reqId] = f
        TriggerClientEvent('fmLib:client:callback:request', src, e, reqId, ...)
    end,

    ---@param e string -- event name
    ---@param src number -- source
    ---@param ... any -- arguments
    ---@return ... any -- response arguments
    ---Perform an synchronous callback request
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