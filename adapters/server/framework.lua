--[[
    fmLib - Framework Server Adapter
]]

FM = FM or {}
FM.framework = FM.framework or {}

local frameworkAdapter = BaseAdapter:new('framework', 'server')

function FM.framework.notify(src, message, type)
    return frameworkAdapter:call('notify', src, message, type)
end

function FM.framework.getJobs()
    return frameworkAdapter:call('getJobs')
end

function FM.framework.getGangs()
    return frameworkAdapter:call('getGangs')
end

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

function FM.framework.getJobOnlineSources(job)
    local sources = {}
    local players = FM.framework.getPlayers({ job = job })

    for src, _ in pairs(players) do
        sources[#sources + 1] = tonumber(src)
    end

    return sources
end

function FM.framework.getJob(jobName)
    local jobs = FM.framework.getJobs()
    for _, job in pairs(jobs) do
        if job.name == jobName then
            return job
        end
    end
    return nil
end

function FM.framework.getGang(gangName)
    local gangs = FM.framework.getGangs()
    for _, gang in pairs(gangs) do
        if gang.name == gangName then
            return gang
        end
    end
    return nil
end

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

function FM.utils.notify(src, message, type)
    Warning('FM.utils.notify is deprecated, use FM.framework.notify instead')
    return FM.framework.notify(src, message, type)
end

function FM.utils.getPlayers(filter)
    Warning('FM.utils.getPlayers is deprecated, use FM.framework.getPlayers instead')
    return FM.framework.getPlayers(filter)
end

function FM.utils.getJobOnlineSources(job)
    Warning('FM.utils.getJobOnlineSources is deprecated, use FM.framework.getJobOnlineSources instead')
    return FM.framework.getJobOnlineSources(job)
end

function FM.utils.getJobs()
    Warning('FM.utils.getJobs is deprecated, use FM.framework.getJobs instead')
    return FM.framework.getJobs()
end

function FM.utils.getGangs()
    Warning('FM.utils.getGangs is deprecated, use FM.framework.getGangs instead')
    return FM.framework.getGangs()
end

function FM.utils.getJob(jobName)
    Warning('FM.utils.getJob is deprecated, use FM.framework.getJob instead')
    return FM.framework.getJob(jobName)
end

function FM.utils.getGang(gangName)
    Warning('FM.utils.getGang is deprecated, use FM.framework.getGang instead')
    return FM.framework.getGang(gangName)
end

function FM.utils.getJobBossGrade(jobName)
    Warning('FM.utils.getJobBossGrade is deprecated, use FM.framework.getJobBossGrade instead')
    return FM.framework.getJobBossGrade(jobName)
end

function FM.utils.getGangBossGrade(gangName)
    Warning('FM.utils.getGangBossGrade is deprecated, use FM.framework.getGangBossGrade instead')
    return FM.framework.getGangBossGrade(gangName)
end