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
    register = function(e, cbF)
        callbacks[e] = cbF
    end,

    ---@param e string -- event name
    ---@param f function -- response function
    ---@param ... any -- arguments
    async = function(e, f, ...)
        local reqId = getRandomReqId(e)
        requests[reqId] = f
        TriggerServerEvent('fmLib:server:callback:request', e, reqId, ...)
    end,

    ---@param e string -- event name
    ---@param ... any -- arguments
    ---@return ... any -- response arguments
    sync = function(e, ...)
        local reqId = getRandomReqId(e)
        local cb = promise.new()
        
        requests[reqId] = function(...)
            cb:resolve({...})
        end

        TriggerServerEvent('fmLib:server:callback:request', e, reqId, ...)

        return table.unpack(Citizen.Await(cb))
    end,
}

RegisterNetEvent('fmLib:client:callback:listener', function(reqId, ...)
    requests[reqId](...)
    requests[reqId] = nil
end)

RegisterNetEvent('fmLib:client:callback:request', function(e, reqId, ...)
    if not callbacks[e] then return Err("No callback found for %s", e) end
    TriggerServerEvent('fmLib:server:callback:listener', reqId, callbacks[e](...))
end)