--[[
    fmLib - Appearance Client Adapter
]]

FM = FM or {}
FM.appearance = FM.appearance or {}

local appearanceAdapter = BaseAdapter:new('appearance', 'client')

function FM.appearance.openWardrobe(propertyId)
    return appearanceAdapter:call('openWardrobe', propertyId)
end

function FM.appearance.setOutfit(clothingData)
    return appearanceAdapter:call('setOutfit', clothingData)
end

function FM.appearance.loadSkin()
    return appearanceAdapter:call('loadSkin')
end

-- Backwards compatibility
FM.player = FM.player or {}

function FM.player.openWardrobe(propertyId)
    Warning('FM.player.openWardrobe is deprecated, use FM.appearance.openWardrobe instead')
    return FM.appearance.openWardrobe(propertyId)
end

function FM.player.setOutfit(clothingData)
    Warning('FM.player.setOutfit is deprecated, use FM.appearance.setOutfit instead')
    return FM.appearance.setOutfit(clothingData)
end

function FM.player.loadSkin()
    Warning('FM.player.loadSkin is deprecated, use FM.appearance.loadSkin instead')
    return FM.appearance.loadSkin()
end