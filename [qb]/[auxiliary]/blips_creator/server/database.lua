function setupDatabase(cb)
    local resName = GetCurrentResourceName()

    if(resName ~= "blips_creator") then
        print("It would be appreciated using ^blips_creator^7 as name of the resource")
    end
    
    local scriptVersion = GetResourceMetadata(resName, 'version', 0)

    local sqlPath = "sql/%s.sql"

    local sqlContent = LoadResourceFile(resName, string.format(sqlPath, scriptVersion))

    if(sqlContent) then
        MySQL.Async.execute(sqlContent, {}, function()
            print("[" .. GetCurrentResourceName() .. "] Database ready")
            cb()
        end)
    else
        cb()
    end
end