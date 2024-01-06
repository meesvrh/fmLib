local pinRes

FM.pin = {}

---@class PinProps
---@field title? string
---@field subtitle? string
---@field maxNumbers? number
---@field useSfx? boolean

local function setDefaultProps(props)
    if not props then props = {} end
    props.maxNumbers = (props.maxNumbers and props.maxNumbers <= 8 and props.maxNumbers > 0) and props.maxNumbers or 4
    if props.useSfx == nil then props.useSfx = true end

    return props
end

---@param props PinProps | nil
function FM.pin.open(props)
    if pinRes then FM.console.err('Pin already active') return end
    
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
    if not pinRes then FM.console.err('No pin active') return end

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
function FM.pin.isActive()
    return pinRes ~= nil
end

--[[ EXAMPLE FOR NOW HERE ]]
RegisterCommand('openpin', function (source, args, raw)
    local result = FM.pin.open({
        title = 'Vault Pin',
        subtitle = 'Enter the vault code.',
        maxNumbers = 4,
    })

    if result then
        FM.console.debug(result)
    else
        FM.console.error('No pin inserted!')
    end
end)