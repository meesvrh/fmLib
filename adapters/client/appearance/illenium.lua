--[[
    fmLib - Illenium Appearance Adapter
]]

local adapter = {}
local resourceName

function adapter.init(resource)
    resourceName = resource
end

function adapter.openWardrobe(propertyId)
    TriggerEvent("illenium-appearance:client:openOutfitMenu")
end

function adapter.setOutfit(clothingData)
    local playerPed = PlayerPedId()

    local propMapping = {
        [0] = { drawable = 'helmet_1', texture = 'helmet_2' },
        [1] = { drawable = 'glasses_1', texture = 'glasses_2' },
    }

    local componentMapping = {
        [1] = { drawable = 'mask_1', texture = 'mask_2' },
        [3] = { drawable = 'arms', texture = nil },
        [4] = { drawable = 'pants_1', texture = 'pants_2' },
        [5] = { drawable = 'bag', texture = 'bag_color' },
        [6] = { drawable = 'shoes_1', texture = 'shoes_2' },
        [7] = { drawable = 'chain_1', texture = 'chain_2' },
        [8] = { drawable = 'tshirt_1', texture = 'tshirt_2' },
        [9] = { drawable = 'bproof_1', texture = 'bproof_2' },
        [10] = { drawable = 'decals_1', texture = 'decals_2' },
        [11] = { drawable = 'torso_1', texture = 'torso_2' },
    }

    local props = {}
    for id, prop in pairs(propMapping) do
        props[#props + 1] = {
            component_id = id,
            drawable = clothingData[prop.drawable] or 0,
            texture = clothingData[prop.texture] or 0
        }
    end

    local components = {}
    for id, comp in pairs(componentMapping) do
        components[#components + 1] = {
            component_id = id,
            drawable = clothingData[comp.drawable] or 0,
            texture = comp.texture and (clothingData[comp.texture] or 0) or 0
        }
    end

    exports[resourceName]:setPedProps(playerPed, props)
    exports[resourceName]:setPedComponents(playerPed, components)
end

function adapter.loadSkin()
    TriggerEvent("illenium-appearance:client:reloadSkin")
end

FM_Adapter_client_appearance_illenium = adapter