---@type Promise<boolean> | nil
local loadRes

FM.loading = {}

---@class LoadingProps
---@field time? number
---@field focus? boolean
---@field cursor? boolean
---@field keepInput? boolean
---@field canCancel? boolean

---@type LoadingProps | nil
local currProps

local function setDefaultProps(props)
    if not props then props = {} end
    props.time = props.time or nil
    props.focus = props.focus or true
    props.cursor = props.cursor or false
    props.keepInput = props.keepInput or false
    props.canCancel = props.canCancel or false

    return props
end

---@async
---@param props LoadingProps | nil
---@param cb function
function FM.loading.start(props, cb)
    if loadRes then return FM.console.err('Loading already active') end
    
    currProps = setDefaultProps(props)
    loadRes = promise.new()
    
    SetNuiFocus(currProps.focus, currProps.cursor)
    SetNuiFocusKeepInput(currProps.keepInput)

    SendNUIMessage({
        action = 'startLoading',
        data = currProps
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
        currProps = nil
    end

    cb(true)
end)

---@return boolean
function FM.loading.isActive()
    return loadRes ~= nil
end

RegisterCommand('cancelload', function (source, args, raw)
    if not loadRes or not currProps or not currProps.canCancel then return end
    FM.loading.stop(false)
end)
RegisterKeyMapping('cancelload', 'Cancel Loading', KeyMappings.CANCEL.mapper, KeyMappings.CANCEL.key)

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
