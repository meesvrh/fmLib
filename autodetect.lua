for k, v in pairs(Resources) do
    if GetResourceState(v.name) == 'started' then
        if k == 'QBTarget' and GetResourceState(Resources.OXTarget.name) == 'started' then goto continue end

        if type(v) == 'table' then
            if v.export == 'all' then
                _G[k] = exports[v.name]
            elseif v.export then
                _G[k] = exports[v.name][v.export]()
            else
                _G[k] = true
            end
        end
        
        if not Settings.ignoreResourceInitializedLogs then
            FM.console.suc("Initialized "..v.name)
        end

        ::continue::
    end
end

CreateThread(function()
    if not ESX and not QB then
        while true do
            FM.console.err(string.format("No framework found for %s", GetCurrentResourceName()))
            FM.console.err("Make sure to ensure es_extended or qb-core in your server.cfg BEFORE (ABOVE) this resource")
            Wait(3000)
        end
    else
        FM.console.suc(string.format("Successfully Initialized %s", GetCurrentResourceName()))
    end
end)