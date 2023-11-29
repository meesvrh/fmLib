---@type Promise<boolean> | nil
local progressRes

FM.progress = {}

---@class ProgressProps
---@field label? string
---@field time? number
---@field type? 'linear' | 'circle'
---@field canCancel? boolean

---@type ProgressProps | nil
local currProps

local function setDefaultProps(props)
    if not props then props = {} end
    props.time = props.time or 3000
    props.type = props.type or 'linear'
    props.canCancel = props.canCancel ~= nil and props.canCancel or true

    return props
end

---@async
---@param props ProgressProps | nil
function FM.progress.start(props)
    if progressRes then return FM.console.err('Progress already active') end
    
    currProps = setDefaultProps(props)
    progressRes = promise.new()

    SendNUIMessage({
        action = 'startProgress',
        data = currProps
    })
    
    return Citizen.Await(progressRes)
end

---@param success boolean
function FM.progress.stop(success)
    if not progressRes then return FM.console.err('No progress active') end
    
    SendNUIMessage({
        action = 'stopProgress',
        data = success
    })
end

RegisterNUICallback('progressStopped', function(success, cb)
    if progressRes then
        progressRes:resolve(success)
        progressRes = nil
        currProps = nil
    end

    cb(true)
end)

---@return boolean
function FM.progress.isActive()
    return progressRes ~= nil
end

RegisterCommand('cancelprogress', function (source, args, raw)
    if not progressRes or not currProps or not currProps.canCancel then return end
    FM.progress.stop(false)
end)
RegisterKeyMapping('cancelprogress', 'Cancel Progress', KeyMappings.CANCEL.mapper, KeyMappings.CANCEL.key)

--[[ EXAMPLE FOR NOW HERE ]]
RegisterCommand('startprogress', function (source, args, raw)
    if FM.progress.start({
        time = 10000,
        label = 'Testing progress',
        type = 'circle'
    }) then
        FM.console.suc('Progress success')
    else
        FM.console.err('Progress failed')
    end
end)

