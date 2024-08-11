---@diagnostic disable: need-check-nil
---@param props fmProgressProps | nil
function OverrideProgress(props)
    local promise = promise.new()

    if MOVHUD then
        local actions = {
            duration = props.time,
            label = props.label,
            canCancel = props.canCancel,
            controlDisables = {
                disableMovement = props.disable.move,
                disableCarMovement = props.disable.car,
                disableMouse = props.disable.mouse,
                disableCombat = props.disable.combat,
            },
        }

        if props.anim then
            actions.animation = {
                animDict = props.anim.dict,
                anim = props.anim.anim,
                flags = props.anim.flag,
            }
        elseif props.scenario then
            actions.animation = {
                task = props.scenario.name
            }
        end

        if props.prop then
            actions.prop = {
                model = props.prop.model,
                bone = props.prop.bone,
                coords = props.prop.position,
                rotation = props.prop.rotation,
            }
        end

        MOVHUD:StartProgress(actions, nil, nil, function(success)
            promise:resolve(success)
        end)

        return true, Citizen.Await(promise)
    end
end