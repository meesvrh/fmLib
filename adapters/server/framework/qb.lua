local adapter = {}

function adapter.notify(src, message, type)
    if not src then return end
    if not message then return end
    TriggerClientEvent('QBCore:Notify', src, message, type)
end

function adapter.registerUsableItem(itemName, cb)
    QB.Functions.CreateUseableItem(itemName, function(src, item)
        cb(src, item)
    end)
end

function adapter.getItemLabel(item)
    return QB.Shared.Items[item].label
end

function adapter.getJobs()
    local jobs = {}
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
    return jobs
end

function adapter.getGangs()
    local gangs = {}
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
    return gangs
end

FM_Adapter_server_framework_qb = adapter