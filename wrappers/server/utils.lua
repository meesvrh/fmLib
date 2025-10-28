FM.utils = {}

---@param src number
---@param message string
---@param type? 'success'|'error'
function FM.utils.notify(src, message, type)
    if not src then return end
    if not message then return end

    if ESX then TriggerClientEvent('esx:showNotification', src, message, type)
    elseif QB then TriggerClientEvent('QBCore:Notify', src, message, type) end
end

---@param filter? { job?: string, gang?: string, count?: boolean }
function FM.utils.getPlayers(filter)
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

---@param job string
---@return number[] sources Array of player sources with the specified job
function FM.utils.getJobOnlineSources(job)
    local sources = {}
    local players = FM.utils.getPlayers({ job = job })

    for src, _ in pairs(players) do
        sources[#sources + 1] = tonumber(src)
    end

    return sources
end

---@return table[] jobs Array of job objects with name, label, and grades
function FM.utils.getJobs()
    local jobs = {}

    if ESX then
        local esxJobs = ESX.GetJobs()
        if esxJobs then
            for jobName, jobData in pairs(esxJobs) do
                local grades = {}
                -- Convert ESX grades to unified format
                if jobData.grades then
                    for gradeId, gradeData in pairs(jobData.grades) do
                        grades[#grades + 1] = {
                            grade = tonumber(gradeId) or 0,
                            name = gradeData.label or gradeData.name or 'Unknown',
                            label = gradeData.label or gradeData.name or 'Unknown',
                            salary = gradeData.salary or 0,
                            isboss = gradeData.name and (string.lower(gradeData.name):find('boss') ~= nil) or false
                        }
                    end
                end

                jobs[#jobs + 1] = {
                    name = jobName,
                    label = jobData.label or jobName,
                    grades = grades
                }
            end
        end
    elseif QB then
        if QB.Shared and QB.Shared.Jobs then
            for jobName, jobData in pairs(QB.Shared.Jobs) do
                local grades = {}
                -- Convert QB grades to unified format
                if jobData.grades then
                    for gradeId, gradeData in pairs(jobData.grades) do
                        grades[#grades + 1] = {
                            grade = tonumber(gradeId) or 0,
                            name = gradeData.name or 'Unknown',
                            label = gradeData.name or 'Unknown',
                            salary = gradeData.payment or 0,
                            isboss = gradeData.isboss or false
                        }
                    end
                end

                jobs[#jobs + 1] = {
                    name = jobName,
                    label = jobData.label or jobName,
                    grades = grades
                }
            end
        end
    end

    return jobs
end

---@return table[] gangs Array of gang objects with name, label, and grades
function FM.utils.getGangs()
    local gangs = {}

    if ESX then
        -- ESX doesn't have native gangs, but check for common gang resources
        if GetResourceState('esx_gangs') == 'started' then
            -- Try to get gangs from esx_gangs export
            local success, result = pcall(function()
                return exports['esx_gangs']:GetGangs()
            end)

            if success and result then
                for gangName, gangData in pairs(result) do
                    local grades = {}
                    -- Convert gang grades to unified format
                    if gangData.grades then
                        for gradeId, gradeData in pairs(gangData.grades) do
                            grades[#grades + 1] = {
                                grade = tonumber(gradeId) or 0,
                                name = gradeData.label or gradeData.name or 'Unknown',
                                label = gradeData.label or gradeData.name or 'Unknown',
                                salary = gradeData.salary or 0,
                                isboss = gradeData.name and (string.lower(gradeData.name):find('boss') ~= nil) or false
                            }
                        end
                    end

                    gangs[#gangs + 1] = {
                        name = gangName,
                        label = gangData.label or gangName,
                        grades = grades
                    }
                end
            end
        end
        -- Could add support for other ESX gang resources here
    elseif QB then
        if QB.Shared and QB.Shared.Gangs then
            for gangName, gangData in pairs(QB.Shared.Gangs) do
                local grades = {}
                -- Convert QB gang grades to unified format
                if gangData.grades then
                    for gradeId, gradeData in pairs(gangData.grades) do
                        grades[#grades + 1] = {
                            grade = tonumber(gradeId) or 0,
                            name = gradeData.name or 'Unknown',
                            label = gradeData.name or 'Unknown',
                            isboss = gradeData.isboss or false
                            -- Note: QB gangs typically don't have salaries
                        }
                    end
                end

                gangs[#gangs + 1] = {
                    name = gangName,
                    label = gangData.label or gangName,
                    grades = grades
                }
            end
        end
    end

    return gangs
end