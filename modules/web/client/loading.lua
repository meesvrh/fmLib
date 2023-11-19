---@type Promise<boolean> | nil
local loadRes

FM.loading = {}

---@class LoadingProps
---@field linear? boolean linear animation | default: false (circle)
---@field time? number stops automaticlally after x ms | default: until stopped
---@field focus? boolean focus the NUI | default: true
---@field cursor? boolean show the cursor | default: false
---@field keepInput? boolean keep input | default: false

local function setDefaultProps(props)
    if not props then props = {} end
    props.time = props.time or nil
    props.focus = props.focus or true
    props.cursor = props.cursor or false
    props.keepInput = props.keepInput or false
    props.linear = props.linear or false

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

    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)

    SendNUIMessage({
        action = 'stopLoading',
        data = false
    })

    loadRes:resolve(success)
    loadRes = nil
end

---@return boolean
function FM.loading.isBusy()
    return loadRes ~= nil
end

RegisterNUICallback('loadingStopped', function(success, cb)
    if loadRes then
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        
        loadRes:resolve(success)
        loadRes = nil
    end

    cb(true)
end)

--[[ EXAMPLE FOR NOW HERE ]]
RegisterCommand('startload', function (source, args, raw)
    FM.loading.start({
        linear = false,
        time = 5000,
        focus = true,
        cursor = false,
        input = false,
    }, function(success)
        FM.console.debug({success})
    end)
end)

RegisterCommand('stopload', function (source, args, raw)
    FM.loading.stop(args[1] or false)
end)