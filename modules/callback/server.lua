FM.callback = {}

local callbacks = {}
local requests = {}

local function getRandomReqId(e)
    local reqId
    repeat
        reqId = ('reqId_%s_%s'):format(e, math.random(0, 100000))
    until not requests[reqId]
    return reqId
end

---@param e string -- event name
---@param cb function -- callback function
---Register a callback
function FM.callback.register(e, cb)
    callbacks[e] = cb
end

---@param e string -- event name
---@param src number -- source
---@param cb function -- response function
---@param ... any -- arguments
---@async
---Perform an asynchronous callback request
function FM.callback.async(e, src, cb, ...)
    local reqId = getRandomReqId(e)
    requests[reqId] = cb
    TriggerClientEvent('fmLib:client:callback:request', src, e, reqId, ...)
end

---@param e string -- event name
---@param src number -- source
---@param ... any -- arguments
---@return ... any -- response arguments
---Perform an synchronous callback request
function FM.callback.sync(e, src, ...)
    local reqId = getRandomReqId(e)
    local cb = promise.new()

    requests[reqId] = function(...)
        cb:resolve({...})
    end

    TriggerClientEvent('fmLib:client:callback:request', src, e, reqId, ...)

    return table.unpack(Citizen.Await(cb))
end

RegisterNetEvent('fmLib:server:callback:listener', function(reqId, ...)
    requests[reqId](...)
    requests[reqId] = nil
end)

RegisterNetEvent('fmLib:server:callback:request', function(e, reqId, ...)
    local src = source
    if not callbacks[e] then return Err("No callback found for %s", e) end
    TriggerClientEvent('fmLib:client:callback:listener', src, reqId, callbacks[e](src, ...))
end)

FM.cb = FM.callback