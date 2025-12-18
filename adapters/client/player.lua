--[[
    fmLib - Player Client Adapter
]]

FM = FM or {}
FM.player = FM.player or {}

local playerAdapter = BaseAdapter:new('player', 'client')

function FM.player.isLoggedIn()
    return playerAdapter:call('isLoggedIn')
end

function FM.player.getFullName()
    return playerAdapter:call('getFullName')
end

function FM.player.getIdentifier()
    return playerAdapter:call('getIdentifier')
end

function FM.player.getJob()
    return playerAdapter:call('getJob')
end

function FM.player.getGang()
    return playerAdapter:call('getGang')
end