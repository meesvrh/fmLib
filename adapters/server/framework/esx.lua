local adapter = {}

function adapter.notify(src, message, type)
    if not src then return end
    if not message then return end
    TriggerClientEvent('esx:showNotification', src, message, type)
end

function adapter.registerUsableItem(itemName, cb)
    ESX.RegisterUsableItem(itemName, function(src, item)
        cb(src, item)
    end)
end

function adapter.getItemLabel(item)
    return ESX.GetItemLabel(item)
end

function adapter.getJobs()
    local jobs = {}
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
    return jobs
end

function adapter.getGangs()
    local gangs = {}
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
    return gangs
end

FM_Adapter_server_framework_esx = adapter