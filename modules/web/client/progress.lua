local progressRes
local isStopping = false

FM.progress = {}

---@class Anim
---@field anim string
---@field dict string
---@field position? vector3
---@field rotation? vector3
---@field enterSpeed? number
---@field exitSpeed? number
---@field duration? number
---@field flag? number
---@field animTime? number

---@class Prop
---@field model string | number
---@field position vector3
---@field rotation vector3
---@field bone? number

---@class ProgressProps
---@field label? string
---@field time? number
---@field type? 'linear' | 'circle'
---@field failedLabel? string
---@field completedLabel? string
---@field canCancel? boolean
---@field anim? Anim
---@field prop? Prop
---@field scenario? { name: string, position?: vector3, heading?: number, duration?: number, sitting?: boolean, teleport?: boolean }
---@field useSfx? boolean

---@type ProgressProps | nil
local currProps

local function stopCurrentAnim()
    if currProps.anim and currProps.anim.anim and currProps.anim.dict then
        if IsEntityPlayingAnim(PlayerPedId(), currProps.anim.dict, currProps.anim.anim, 3) then
            ClearPedTasks(PlayerPedId())
        end
        RemoveAnimDict(currProps.anim.dict)
    elseif currProps.scenario and IsPedUsingScenario(PlayerPedId(), currProps.scenario.name) then
        ClearPedTasks(PlayerPedId())
    end
end

local function createProp(prop)
    if type(prop.position) ~= 'vector3' and type(prop.position) ~= 'table' then FM.console.err('Invalid position') return end
    if type(prop.rotation) ~= 'vector3' and type(prop.rotation) ~= 'table' then FM.console.err('Invalid rotation') return end
    if not tonumber(prop.model) then prop.model = joaat(prop.model) end
    if not IsModelValid(prop.model) then FM.console.err('Invalid model: '..prop.model) return end

    if not HasModelLoaded(prop.model) then
        RequestModel(prop.model)
        while not HasModelLoaded(prop.model) do Wait(200) end
    end

    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local obj = CreateObject(prop.model, pCoords, true, true, true)

    AttachEntityToEntity(obj, ped, GetPedBoneIndex(ped, prop.bone or 60309), prop.position, prop.rotation, true, true, false, true, 0, true)
    SetModelAsNoLongerNeeded(prop.model)

    return obj
end

local function setDefaultProps(props)
    if not props then props = {} end
    props.label = props.label or 'Progress'
    props.time = props.time or 3000
    props.type = props.type or 'linear'
    props.completedLabel = props.completedLabel or 'Completed'
    props.failedLabel = props.failedLabel or 'Failed'
    if props.canCancel == nil then props.canCancel = true end
    if props.useSfx == nil then props.useSfx = true end
    if not props.anim and props.scenario then
        props.scenario.position = props.scenario.position or GetEntityCoords(PlayerPedId())
        props.scenario.heading = props.scenario.heading or GetEntityHeading(PlayerPedId())
        props.scenario.duration = props.scenario.duration or -1
        if props.scenario.sitting == nil then props.scenario.sitting = false end
        if props.scenario.teleport == nil then props.scenario.teleport = false end
    end

    return props
end

---@param props ProgressProps | nil
function FM.progress.start(props)
    if progressRes then return FM.console.err('Progress already active') end
    
    currProps = setDefaultProps(props)
    progressRes = promise.new()
    isStopping = false

    SendNUIMessage({
        action = 'startProgress',
        data = currProps
    })

    if currProps.anim then FM.anim.play(currProps.anim) elseif
    currProps.scenario then TaskStartScenarioAtPosition(PlayerPedId(), currProps.scenario.name, currProps.scenario.position, currProps.scenario.heading, currProps.scenario.duration, currProps.scenario.sitting, currProps.scenario.teleport) end

    if currProps.prop then currProps.prop = createProp(currProps.prop) end
    
    return Citizen.Await(progressRes)
end

---@param success boolean
function FM.progress.stop(success)
    if not progressRes or isStopping then return FM.console.err('No progress active') end
    
    SendNUIMessage({
        action = 'stopProgress',
        data = success
    })
end

RegisterNUICallback('progressStopped', function(success, cb)
    if progressRes then
        progressRes:resolve(success)
        progressRes = nil

        if currProps.anim or currProps.scenario then stopCurrentAnim() end
        if currProps.prop then DeleteEntity(currProps.prop) end

        currProps = nil
    end

    isStopping = false
    cb(true)
end)

---@return boolean
function FM.progress.isActive()
    return progressRes ~= nil
end

RegisterCommand('cancelprogress', function(source, args, raw)
    if not progressRes or not currProps or not currProps.canCancel then return end
    FM.progress.stop(false)
end)
RegisterKeyMapping('cancelprogress', 'Cancel Progress', KeyMappings.CANCEL.mapper, KeyMappings.CANCEL.key)

--[[ EXAMPLE FOR NOW HERE ]]
RegisterCommand('startprogress', function(source, args, raw)
    if FM.progress.start({
        label = 'Testing progress',
        time = 10000,
        canCancel = true,
        type = 'linear',
        failedLabel = 'Progress Failed!',
        completedLabel = 'Progress Completed!',
        anim = { dict = "amb@world_human_gardener_plant@male@base", anim = "base" },
        prop = { model = 'prop_tool_broom', position = vector3(0.0, 0.0, 0.0), rotation = vector3(0.0, 0.0, 0.0), bone = 60309 },
    }) then
        FM.console.debug('Progress success')
    else
        FM.console.debug('Progress failed')
    end
end)

