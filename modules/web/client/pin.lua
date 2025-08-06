local pinRes

FM.pin = {}

---@class PinProps
---@field title? string
---@field subtitle? string
---@field maxNumbers? number
---@field canClose? boolean
---@field useSfx? boolean
---@field hidden? boolean
---@field reactiveUI? { correctPin: number, closeOnWrong?: boolean }

local function setDefaultProps(props)
    if not props then props = {} end
    props.maxNumbers = (props.maxNumbers and props.maxNumbers <= 8 and props.maxNumbers > 0) and props.maxNumbers or 4
    if props.useSfx == nil then props.useSfx = true end
    if props.hidden == nil then props.hidden = false end
    if props.reactiveUI then
        props.reactiveUI = props.reactiveUI.correctPin and props.reactiveUI or nil
        if props.reactiveUI and props.reactiveUI.closeOnWrong == nil then props.reactiveUI.closeOnWrong = true end
    end
    if props.canClose == nil then props.canClose = true end

    return props
end

---@param props PinProps | nil
function FM.pin.open(props)
    if pinRes then FM.console.err('Pin already open') return end
    
    props = setDefaultProps(props)
    pinRes = promise.new()
    
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(false)

    SendNUIMessage({
        action = 'openPin',
        data = props
    })

    return Citizen.Await(pinRes)
end

function FM.pin.close()
    if not pinRes then FM.console.err('No pin open') return end

    SendNUIMessage({
        action = 'closePin',
    })
end

RegisterNUICallback('pinClosed', function(res, cb)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)

    if pinRes then
        pinRes:resolve(res)
        pinRes = nil
    end

    cb(true)
end)

---@return boolean
function FM.pin.isOpen()
    return pinRes ~= nil
end