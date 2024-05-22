--[[
    CREDITS TO: https://github.com/Demigod916/object_gizmo
    ASKED FOR PERMISSION TO COPY PASTA & MODIFY THIS CODE <3

    (so we can keep fmLib our only dependency)
--]]

local usingGizmo = false

local function toggleNuiFrame(bool)
    usingGizmo = bool
    SetNuiFocus(bool, bool)
end

---@param handle number
function FM.positionObject(handle)
    SendNUIMessage({
        action = 'setGizmoEntity',
        data = {
            handle = handle,
            position = GetEntityCoords(handle),
            rotation = GetEntityRotation(handle)
        }
    })

    toggleNuiFrame(true)

    FM.console.log(
        ('Current Mode: %s  \n'):format("translate") ..
        '[W]    - Translate Mode  \n' ..
        '[R]    - Rotate Mode  \n' ..
        '[LALT] - Place On Ground  \n' ..
        '[Esc]  - Done Editing  \n'
    )

    while usingGizmo do

        SendNUIMessage({
            action = 'setCameraPosition',
            data = {
                position = GetFinalRenderedCamCoord(),
                rotation = GetFinalRenderedCamRot()
            }
        })
        Wait(0)
    end

    return {
        handle = handle,
        position = GetEntityCoords(handle),
        rotation = GetEntityRotation(handle)
    }
end

RegisterNUICallback('moveEntity', function(data, cb)
    local entity = data.handle
    local position = data.position
    local rotation = data.rotation

    SetEntityCoords(entity, position.x, position.y, position.z)
    SetEntityRotation(entity, rotation.x, rotation.y, rotation.z)
    cb('ok')
end)

RegisterNUICallback('placeOnGround', function(data, cb)
    PlaceObjectOnGroundProperly(data.handle)
    cb('ok')
end)

RegisterNUICallback('finishEdit', function(data, cb)
    toggleNuiFrame(false)
    SendNUIMessage({
        action = 'setGizmoEntity',
        data = {
            handle = nil,
        }
    })
    cb('ok')
end)

RegisterNUICallback('swapMode', function(data, cb)
    FM.console.log(
        ('Current Mode: %s  \n'):format(data.mode) ..
        '[W]    - Translate Mode  \n' ..
        '[R]    - Rotate Mode  \n' ..
        '[LALT] - Place On Ground  \n' ..
        '[Esc]  - Done Editing  \n'
    )
    cb('ok')
end)

-- RegisterCommand('spawnobject',function(source, args, rawCommand) --example of how the gizmo could be used /spawnobject {object model name}
--     local objectName = args[1] or "prop_bench_01a"
--     local playerPed = PlayerPedId()
--     local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0, 1.0, 0)

--     local model = joaat(objectName)
--     while not HasModelLoaded(model) do
--         RequestModel(model)
--         Wait(100)
--     end

--     local object = CreateObject(model, offset.x, offset.y, offset.z, true, false, false)

--     local objectPositionData = FM.positionObject(object) --export for the gizmo. just pass an object handle to the function.
    
--     FM.console.debug(objectPositionData)
-- end)