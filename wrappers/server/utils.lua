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

-- ---@param filter? { job?: string, gang?: string, count?: boolean }
-- function FM.utils.getPlayers(filter)
--     local playerSources = GetPlayers()
--     local players = {}

--     for _, src in pairs(playerSources) do
--         local p = FM.player.get(tonumber(src))
--         if not p then goto continue end

--         if not filter then
--             players[src] = p
--         else
--             if filter.job then
--                 local job = p.getJob()
--                 if job and job.name == filter.job then
--                     players[src] = p
--                 end
--             end

--             if filter.gang then
--                 local gang = p.getGang()
--                 if gang and gang.name == filter.gang then
--                     players[src] = p
--                 end
--             end
--         end

--         ::continue::
--     end

--     if filter and filter.count then
--         local count = 0
--         for _, _ in pairs(players) do count = count + 1 end
--         return count
--     end

--     return players
-- end

-- ---@param job string
-- ---@return number[] sources Array of player sources with the specified job
-- function FM.utils.getJobOnlineSources(job)
--     local sources = {}
--     local players = FM.utils.getPlayers({ job = job })

--     for src, _ in pairs(players) do
--         sources[#sources + 1] = tonumber(src)
--     end

--     return sources
-- end

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
        -- ESX stores gangs as jobs, so we get them from ESX.GetJobs()
        local esxJobs = ESX.GetJobs()
        if esxJobs then
            for jobName, jobData in pairs(esxJobs) do
                -- Typically gang jobs are prefixed or categorized differently
                -- You can filter here based on your server's naming convention
                -- For now, we'll return all jobs and let the boss menu filter them
                -- Common patterns: gang_, ballas, vagos, families, etc.

                local grades = {}
                -- Convert ESX grades to unified format
                if jobData.grades then
                    for gradeId, gradeData in pairs(jobData.grades) do
                        grades[#grades + 1] = {
                            grade = tonumber(gradeId) or 0,
                            name = gradeData.label or gradeData.name or 'Unknown',
                            label = gradeData.label or gradeData.name or 'Unknown',
                            salary = gradeData.salary or 0,
                        }
                    end
                end

                gangs[#gangs + 1] = {
                    name = jobName,
                    label = jobData.label or jobName,
                    grades = grades
                }
            end
        end
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

-- ---@param jobName string
-- ---@return { name: string, label: string, grades: table[] }|nil job Job object
-- function FM.utils.getJob(jobName)
--     local jobs = FM.utils.getJobs()
--     for _, job in pairs(jobs) do
--         if job.name == jobName then
--             return job
--         end
--     end
--     return nil
-- end

-- ---@param gangName string
-- ---@return { name: string, label: string, grades: table[] }|nil gang Gang object
-- function FM.utils.getGang(gangName)
--     local gangs = FM.utils.getGangs()
--     for _, gang in pairs(gangs) do
--         if gang.name == gangName then
--             return gang
--         end
--     end
--     return nil
-- end

-- ---@param jobName string
-- ---@return table|nil grade Boss grade
-- function FM.utils.getJobBossGrade(jobName)
--     local job = FM.utils.getJob(jobName)
--     if not job then return nil end
--     local highestGrade = nil
--     for _, grade in pairs(job.grades) do
--         if not highestGrade or grade.grade > highestGrade.grade then
--             highestGrade = grade
--         end
--     end
--     return highestGrade
-- end

-- ---@param gangName string
-- ---@return table|nil grade Boss grade
-- function FM.utils.getGangBossGrade(gangName)
--     local gang = FM.utils.getGang(gangName)
--     if not gang then return nil end
--     local highestGrade = nil
--     for _, grade in pairs(gang.grades) do
--         if not highestGrade or grade.grade > highestGrade.grade then
--             highestGrade = grade
--         end
--     end
--     return highestGrade
-- end