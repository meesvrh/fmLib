--[[
    fmLib - QB Clothing Adapter
]]

local adapter = {}

-- Ensure QB framework is detected and initialized
FM.adapters.detect('framework')
print('[fmLib] QB Clothing adapter initialized.')

function adapter.openWardrobe(propertyId)
    TriggerEvent('qb-clothing:client:openMenu')
end

function adapter.setOutfit(clothingData)
    TriggerEvent('qb-clothing:client:loadOutfit', { outfitData = clothingData })
end

function adapter.loadSkin()
    TriggerServerEvent('qb-clothes:loadPlayerSkin')
end

FM_Adapter_client_appearance_qb = adapter