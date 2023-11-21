---@type Promise<boolean> | nil
local progressRes

FM.progress = {}

---@class ProgressProps
---@field label? string
---@field time? number
---@field type? 'linear' | 'circle'

local function setDefaultProps(props)
    if not props then props = {} end
    props.time = props.time or 3000
    props.type = props.type or 'linear'

    return props
end

---@async
---@param props ProgressProps | nil
function FM.progress.start(props)
    if progressRes then return FM.console.err('Progress already active') end
    
    props = setDefaultProps(props)
    progressRes = promise.new()

    SendNUIMessage({
        action = 'startProgress',
        data = props
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
    end

    cb(true)
end)

---@return boolean
function FM.progress.isActive()
    return progressRes ~= nil
end

--[[ EXAMPLE FOR NOW HERE ]]
RegisterCommand('startprogress', function (source, args, raw)
    if FM.progress.start({
        label = 'Testing progress',
        type = 'circle'
    }) then
        FM.console.suc('Progress success')
    else
        FM.console.err('Progress failed')
    end
end)

RegisterCommand('stopprogress', function (source, args, raw)
    FM.progress.stop(false)
end)