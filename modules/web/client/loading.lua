---@type Promise<boolean> | nil
local loadRes

FM.loading = {}

---@class LoadingProps
---@field time? number
---@field focus? boolean
---@field cursor? boolean
---@field keepInput? boolean

local function setDefaultProps(props)
    if not props then props = {} end
    props.time = props.time or nil
    props.focus = props.focus or true
    props.cursor = props.cursor or false
    props.keepInput = props.keepInput or false

    return props
end

---@async
---@param props LoadingProps | nil
---@param cb function
function FM.loading.start(props, cb)
    if loadRes then return FM.console.err('Loading already active') end
    
    props = setDefaultProps(props)
    loadRes = promise.new()
    
    SetNuiFocus(props.focus, props.cursor)
    SetNuiFocusKeepInput(props.keepInput)

    SendNUIMessage({
        action = 'startLoading',
        data = props
    })

    cb(Citizen.Await(loadRes))
end

---@param success boolean
function FM.loading.stop(success)
    if not loadRes then return FM.console.err('No loading active') end
    
    SendNUIMessage({
        action = 'stopLoading',
        data = success
    })
end

RegisterNUICallback('loadingStopped', function(success, cb)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)

    if loadRes then
        loadRes:resolve(success)
        loadRes = nil
    end

    cb(true)
end)

---@return boolean
function FM.loading.isActive()
    return loadRes ~= nil
end

--[[ EXAMPLE FOR NOW HERE ]]
RegisterCommand('startload', function (source, args, raw)
    FM.loading.start({
        focus = true,
        cursor = false,
        input = false,
    }, function(success)
        FM.console.debug(success)
    end)
end)

RegisterCommand('stopload', function (source, args, raw)
    FM.loading.stop(args[1] or false)
end)