for k, v in pairs(Resources) do
    local name = type(v) == 'table' and v.name or v

    if GetResourceState(name) == 'started' then
        if type(v) == 'table' and v.export then
            _G[k] = exports[name][v.export]()
        else
            _G[k] = exports[name]
        end
        
        if not Settings.ignoreResourceInitializedLogs then
            FM.console.suc("Initialized "..name)
        end
    end
end