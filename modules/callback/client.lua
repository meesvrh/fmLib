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
    if callbacks[e] then FM.console.err("Callback %s already exists", e) return end
    if type(cb) ~= 'function' then FM.console.err("Callback %s must be a function", e) return end

    callbacks[e] = cb
end

---@param e string -- event name
---@param cb function -- response function
---@param ... any -- arguments
---@async
---Perform an asynchronous callback request
function FM.callback.async(e, cb, ...)
    local reqId = getRandomReqId(e)
    requests[reqId] = cb
    TriggerServerEvent('fmLib:server:callback:request', e, reqId, ...)
end

---@param e string -- event name
---@param ... any -- arguments
---@return ... any -- response arguments
---Perform a synchronous callback request
function FM.callback.sync(e, ...)
    local reqId = getRandomReqId(e)
    local cb = promise.new()
    
    requests[reqId] = function(...)
        cb:resolve({...})
    end

    TriggerServerEvent('fmLib:server:callback:request', e, reqId, ...)

    return table.unpack(Citizen.Await(cb))
end

RegisterNetEvent('fmLib:client:callback:listener', function(reqId, ...)
    requests[reqId](...)
    requests[reqId] = nil
end)

RegisterNetEvent('fmLib:client:callback:request', function(e, reqId, ...)
    if not callbacks[e] then return FM.console.err("No callback found for "..e, false) end
    TriggerServerEvent('fmLib:server:callback:listener', reqId, callbacks[e](...))
end)

FM.cb = FM.callback