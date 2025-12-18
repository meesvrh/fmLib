--[[
    fmLib - Base Adapter
    Reusable base for category adapters
]]

BaseAdapter = {}

function BaseAdapter:new(category, side)
    local instance = {}
    instance.category = category
    instance.side = side or 'client'  -- 'client' or 'server'
    instance.currentAdapter = nil
    instance.adapterName = nil

    setmetatable(instance, { __index = self })
    return instance
end

function BaseAdapter:init()
    local detected = FM.adapters.get(self.category)
    if not detected then
        return false
    end

    self.adapterName = detected.key
    local adapterGlobalName = ('FM_Adapter_%s_%s_%s'):format(self.side, self.category, self.adapterName)
    local adapter = _G[adapterGlobalName]

    if adapter then
        self.currentAdapter = adapter
        Debug(('Loaded %s adapter: %s'):format(self.category, self.adapterName))
        return true
    else
        Error(('Failed to find %s adapter: %s (looking for global %s)'):format(self.category, self.adapterName, adapterGlobalName))
        return false
    end
end

function BaseAdapter:call(funcName, ...)
    if not self.currentAdapter then
        self:init()
    end

    if not self.currentAdapter then
        Error(('No %s system available'):format(self.category))
        return
    end

    if not self.currentAdapter[funcName] then
        Debug(('%s adapter %s does not support: %s'):format(
            self.category, self.adapterName or 'unknown', funcName))
        return
    end

    return self.currentAdapter[funcName](...)
end