--[[
    fmLib - Framework Server Adapter
]]

FM = FM or {}
FM.framework = FM.framework or {}

local frameworkAdapter = BaseAdapter:new('framework', 'server')

---@param src number Player source ID
---@param message string Notification message to display
---@param type? 'success'|'error'|'info' Notification type (optional, defaults to info)
---@return nil
function FM.framework.notify(src, message, type)
    return frameworkAdapter:call('notify', src, message, type)
end

---@return table<number, { name: string, label: string, grades: table<number, { grade: number, name: string, label: string, salary: number }> }> jobs Array of job objects with grades
function FM.framework.getJobs()
    return frameworkAdapter:call('getJobs')
end

---@return table<number, { name: string, label: string, grades: table<number, { grade: number, name: string, label: string, salary?: number }> }> gangs Array of gang objects with grades
function FM.framework.getGangs()
    return frameworkAdapter:call('getGangs')
end

---@param itemName string The name of the item to register as usable
---@param cb function Callback function(src, item) called when item is used
---@return nil
function FM.framework.registerUsableItem(itemName, cb)
    return frameworkAdapter:call('registerUsableItem', itemName, cb)
end

---@param item string The item name to get the label for
---@return string|nil label The display label for the item, or nil if not found
function FM.framework.getItemLabel(item)
    return frameworkAdapter:call('getItemLabel', item)
end

---@param filter? { job?: string, gang?: string, count?: boolean } Optional filter for players (job name, gang name, or count flag)
---@return table<string, table>|number players Table of player objects indexed by source, or count if filter.count is true
function FM.framework.getPlayers(filter)
    local playerSources = GetPlayers()
    local players = {}

    for _, src in pairs(playerSources) do
        local p = FM.player.get(tonumber(src))
        if not p then goto continue end

        if not filter then
            players[src] = p
        else
            if filter.job then
                local job = p.getJob()
                if job and job.name == filter.job then
                    players[src] = p
                end
            end

            if filter.gang then
                local gang = p.getGang()
                if gang and gang.name == filter.gang then
                    players[src] = p
                end
            end
        end

        ::continue::
    end

    if filter and filter.count then
        local count = 0
        for _, _ in pairs(players) do count = count + 1 end
        return count
    end

    return players
end

---@param job string The job name to get online sources for
---@return table<number, number> sources Array of player source IDs with the specified job
function FM.framework.getJobOnlineSources(job)
    local sources = {}
    local players = FM.framework.getPlayers({ job = job })

    for src, _ in pairs(players) do
        sources[#sources + 1] = tonumber(src)
    end

    return sources
end

---@param jobName string The job name to look up
---@return { name: string, label: string, grades: table<number, { grade: number, name: string, label: string, salary: number }> }|nil job Job object or nil if not found
function FM.framework.getJob(jobName)
    local jobs = FM.framework.getJobs()
    for _, job in pairs(jobs) do
        if job.name == jobName then
            return job
        end
    end
    return nil
end

---@param gangName string The gang name to look up
---@return { name: string, label: string, grades: table<number, { grade: number, name: string, label: string, salary?: number }> }|nil gang Gang object or nil if not found
function FM.framework.getGang(gangName)
    local gangs = FM.framework.getGangs()
    for _, gang in pairs(gangs) do
        if gang.name == gangName then
            return gang
        end
    end
    return nil
end

---@param jobName string The job name to get the boss grade for
---@return { grade: number, name: string, label: string, salary: number }|nil grade Highest grade object or nil if job not found
function FM.framework.getJobBossGrade(jobName)
    local job = FM.framework.getJob(jobName)
    if not job then return nil end
    local highestGrade = nil
    for _, grade in pairs(job.grades) do
        if not highestGrade or grade.grade > highestGrade.grade then
            highestGrade = grade
        end
    end
    return highestGrade
end

---@param gangName string The gang name to get the boss grade for
---@return { grade: number, name: string, label: string }|nil grade Highest grade object or nil if gang not found
function FM.framework.getGangBossGrade(gangName)
    local gang = FM.framework.getGang(gangName)
    if not gang then return nil end
    local highestGrade = nil
    for _, grade in pairs(gang.grades) do
        if not highestGrade or grade.grade > highestGrade.grade then
            highestGrade = grade
        end
    end
    return highestGrade
end

-- Backwards compatibility
FM.utils = FM.utils or {}

---@deprecated Use FM.framework.notify instead
---@param src number Player source ID
---@param message string Notification message
---@param type? 'success'|'error'|'info' Notification type
---@return nil
function FM.utils.notify(src, message, type)
    Warning('FM.utils.notify is deprecated, use FM.framework.notify instead')
    return FM.framework.notify(src, message, type)
end

---@deprecated Use FM.framework.getPlayers instead
---@param filter? { job?: string, gang?: string, count?: boolean } Optional filter
---@return table<string, table>|number players
function FM.utils.getPlayers(filter)
    Warning('FM.utils.getPlayers is deprecated, use FM.framework.getPlayers instead')
    return FM.framework.getPlayers(filter)
end

---@deprecated Use FM.framework.getJobOnlineSources instead
---@param job string Job name
---@return table<number, number> sources
function FM.utils.getJobOnlineSources(job)
    Warning('FM.utils.getJobOnlineSources is deprecated, use FM.framework.getJobOnlineSources instead')
    return FM.framework.getJobOnlineSources(job)
end

---@deprecated Use FM.framework.getJobs instead
---@return table<number, { name: string, label: string, grades: table }> jobs
function FM.utils.getJobs()
    Warning('FM.utils.getJobs is deprecated, use FM.framework.getJobs instead')
    return FM.framework.getJobs()
end

---@deprecated Use FM.framework.getGangs instead
---@return table<number, { name: string, label: string, grades: table }> gangs
function FM.utils.getGangs()
    Warning('FM.utils.getGangs is deprecated, use FM.framework.getGangs instead')
    return FM.framework.getGangs()
end

---@deprecated Use FM.framework.getJob instead
---@param jobName string Job name
---@return { name: string, label: string, grades: table }|nil job
function FM.utils.getJob(jobName)
    Warning('FM.utils.getJob is deprecated, use FM.framework.getJob instead')
    return FM.framework.getJob(jobName)
end

---@deprecated Use FM.framework.getGang instead
---@param gangName string Gang name
---@return { name: string, label: string, grades: table }|nil gang
function FM.utils.getGang(gangName)
    Warning('FM.utils.getGang is deprecated, use FM.framework.getGang instead')
    return FM.framework.getGang(gangName)
end

---@deprecated Use FM.framework.getJobBossGrade instead
---@param jobName string Job name
---@return { grade: number, name: string, label: string, salary: number }|nil grade
function FM.utils.getJobBossGrade(jobName)
    Warning('FM.utils.getJobBossGrade is deprecated, use FM.framework.getJobBossGrade instead')
    return FM.framework.getJobBossGrade(jobName)
end

---@deprecated Use FM.framework.getGangBossGrade instead
---@param gangName string Gang name
---@return { grade: number, name: string, label: string }|nil grade
function FM.utils.getGangBossGrade(gangName)
    Warning('FM.utils.getGangBossGrade is deprecated, use FM.framework.getGangBossGrade instead')
    return FM.framework.getGangBossGrade(gangName)
end