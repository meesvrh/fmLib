--[[
    fmLib - Appearance Client Adapter
]]

FM = FM or {}
FM.appearance = FM.appearance or {}

local appearanceAdapter = BaseAdapter:new('appearance', 'client')

---@param propertyId? string Property identifier for wardrobe location (optional, used by some systems)
---@return nil
function FM.appearance.openWardrobe(propertyId)
    return appearanceAdapter:call('openWardrobe', propertyId)
end

---@param clothingData table Outfit/clothing data structure (format varies by appearance system)
---@return nil
function FM.appearance.setOutfit(clothingData)
    return appearanceAdapter:call('setOutfit', clothingData)
end

---@return nil
function FM.appearance.loadSkin()
    return appearanceAdapter:call('loadSkin')
end

-- Backwards compatibility
FM.player = FM.player or {}

---@deprecated Use FM.appearance.openWardrobe instead
---@param propertyId? string Property identifier
---@return nil
function FM.player.openWardrobe(propertyId)
    Warning('FM.player.openWardrobe is deprecated, use FM.appearance.openWardrobe instead')
    return FM.appearance.openWardrobe(propertyId)
end

---@deprecated Use FM.appearance.setOutfit instead
---@param clothingData table Outfit data
---@return nil
function FM.player.setOutfit(clothingData)
    Warning('FM.player.setOutfit is deprecated, use FM.appearance.setOutfit instead')
    return FM.appearance.setOutfit(clothingData)
end

---@deprecated Use FM.appearance.loadSkin instead
---@return nil
function FM.player.loadSkin()
    Warning('FM.player.loadSkin is deprecated, use FM.appearance.loadSkin instead')
    return FM.appearance.loadSkin()
end