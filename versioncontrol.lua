local function isVersionOlder(cVer, lVer)
    local cNums = {}
    local lNums = {}

    for num in cVer:gmatch("(%d+)") do
        cNums[#cNums + 1] = tonumber(num)
    end

    for num in lVer:gmatch("(%d+)") do
        lNums[#lNums + 1] = tonumber(num)
    end

    for i = 1, math.min(#cNums, #lNums) do
        if cNums[i] < lNums[i] then
            return true
        elseif cNums[i] > lNums[i] then
            return false
        end
    end

    return #cNums < #lNums
end

CreateThread(function()
    local resource = GetCurrentResourceName()
    local author = GetResourceMetadata(resource, 'author', 0)
    local repo = GetResourceMetadata(resource, 'repository', 0)
    local cVer = GetResourceMetadata(resource, 'version', 0)

    PerformHttpRequest(string.format('https://api.github.com/repos/%s/%s/releases/latest', author, repo), function(status, res)
        if status ~= 200 or not res then return FM.console.err('Unable to check for updates') end
        res = json.decode(res)

        if res.draft or res.prerelease or not res.tag_name then return end

        if isVersionOlder(cVer, res.tag_name) then
            FM.console.update(string.format("You're running an outdated version of %s (current version: %s)!", resource, cVer))
            FM.console.update(string.format("Download the latest version (%s) here: %s", res.tag_name, res.html_url))
            return
        else
            FM.console.suc(string.format('%s is up to date!', resource))
            return
        end
    end, 'GET')
end)