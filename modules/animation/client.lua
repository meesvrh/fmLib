FM.animation = {}

---@class AnimationProps
---@field anim string
---@field dict string
---@field ped? number
---@field position? vector3
---@field rotation? vector3
---@field enterSpeed? number
---@field exitSpeed? number
---@field duration? number
---@field flag? number
---@field animTime? number

---@param props AnimationProps
local function validateProps(props)
    if not props or type(props) ~= 'table' or not props.anim or not props.dict then return false end
    return true
end

local function setDefaultProps(props)
    if not props then props = {} end
    props.ped = props.ped or PlayerPedId()
    props.position = props.position or GetEntityCoords(props.ped)
    props.rotation = props.rotation or vector3(0.0, 0.0, 0.0)
    props.enterSpeed = props.enterSpeed or 3.0
    props.exitSpeed = props.exitSpeed or -3.0
    props.duration = props.duration or -1
    props.flag = props.flag or 49
    props.animTime = props.animTime or 0

    return props
end

---@param dict string
function FM.animation.request(dict)
    if not dict then FM.console.err('No animation dictionary specified') return end
    if type(dict) ~= "string" then FM.console.err('Animation dictionary must be a string') return end
    if not DoesAnimDictExist(dict) then FM.console.err('Animation dictionary does not exist') return end

    if HasAnimDictLoaded(dict) then return true end
    local tries = 0

    RequestAnimDict(dict)
    repeat
        tries = tries + 1
        Wait(100)
    until HasAnimDictLoaded(dict) or tries > 200

    return HasAnimDictLoaded(dict)
end

---@param props AnimationProps | nil
function FM.animation.play(props)
    if not validateProps(props) then return end
    props = setDefaultProps(props)
    if not FM.animation.request(props.dict) then return end
    
    TaskPlayAnimAdvanced(props.ped, props.dict, props.anim, props.position, props.rotation, props.enterSpeed, props.exitSpeed, props.duration, props.flag, props.animTime)
end

FM.anim = FM.animation