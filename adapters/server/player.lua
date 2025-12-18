--[[
    fmLib - Player Server Adapter
]]

FM = FM or {}
FM.player = FM.player or {}

local playerAdapter = BaseAdapter:new('player', 'server')

function FM.player.getFullnameByIdentifier(identifier)
    return playerAdapter:call('getFullnameByIdentifier', identifier)
end

function FM.player.get(id)
    local isSource = type(id) == 'number'
    local isIdentifier = type(id) == 'string'

    if not isSource and not isIdentifier then
        return nil
    end

    if isSource then
        return playerAdapter:call('getPlayerBySrc', id)
    else
        return playerAdapter:call('getPlayerByIdentifier', id)
    end
end

-- Backwards compatibility alias
FM.p = FM.player