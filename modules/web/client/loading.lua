local loadRes
local isStopping = false

FM.loading = {}

---@class LoadingProps
---@field time? number
---@field focus? boolean
---@field cursor? boolean
---@field keepInput? boolean
---@field canCancel? boolean
---@field useSfx? boolean

---@type LoadingProps | nil
local currProps

local function setDefaultProps(props)
    if not props then props = {} end
    if props.focus == nil then props.focus = true end
    if props.cursor == nil then props.cursor = false end
    if props.keepInput == nil then props.keepInput = false end
    if props.canCancel == nil then props.canCancel = false end
    if props.useSfx == nil then props.useSfx = true end

    return props
end

---@async
---@param props LoadingProps | nil
---@param cb function
function FM.loading.start(props, cb)
    if loadRes then FM.console.err('Loading already active') return end
    
    currProps = setDefaultProps(props)
    loadRes = promise.new()
    isStopping = false

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
    if not loadRes or isStopping then FM.console.err('No loading active') return end
    isStopping = true
    
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

    isStopping = false
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
        time = 5000,
        focus = true,
        cursor = false,
        input = false,
        useSfx = true,
    }, function(success)
        FM.console.debug(success)
    end)
end)
