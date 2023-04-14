CreateThread(function()
    -- Variables
    local prompts = {}
    local targetZoneIds = {}
    firstOpen = true
    isInZone = false
    zoneJobName = nil
    currentPreviews = {}
    CurrentJobName = nil
    IsOpen = false
    currentVehicle = nil
    PlayerData = QBCore.Functions.GetPlayerData()

    -- Failsafes
    for i, v in pairs(Config.Positions) do
        if QBCore.Shared.Jobs[i] == nil then
            Functions.ErrorPrint("The job \"" .. i .. "\" doesn't exist.")
        end
    end

    -- Events
    RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
    AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
        PlayerData = QBCore.Functions.GetPlayerData()
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerUnload")
    AddEventHandler("QBCore:Client:OnPlayerUnload",
                    function() PlayerData = nil end)

    RegisterNetEvent("QBCore:Client:OnJobUpdate")
    AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
        if PlayerData then
            PlayerData.job = job
        else
            PlayerData = QBCore.Functions.GetPlayerData()
        end
    end)

    RegisterNetEvent("QBCore:Client:SetDuty")
    RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
        if PlayerData.job then
            PlayerData.job.onduty = duty
        else
            PlayerData = QBCore.Functions.GetPlayerData()
        end
    end)

    -- NUI Callbacks
    RegisterNUICallback("close", function(data, cb)
        Functions.Close()
        cb("ok")
    end)

    RegisterNUICallback("clickOption", function(data, cb)
        Functions.HandleOptionClick(data.tab, data.option)
        cb("ok")
    end)

    RegisterNUICallback("previewOption", function(data, cb)
        Functions.Preview(data)
        cb("ok")
    end)

    RegisterNUICallback("unPreviewOption", function(data, cb)
        Functions.UnPreview(data)
        cb("ok")
    end)

    -- Main / Open handler
    if Config.OpenType == "normal" then
        local usageZones = {}

        for i, v in pairs(Config.Positions) do
            usageZones[#usageZones + 1] =
                BoxZone:Create(vector3(v.pos.x, v.pos.y, v.pos.z),
                               Config.Polyzones.Size[1],
                               Config.Polyzones.Size[2], {
                    name = "customs-" .. i,
                    job = i,
                    debugPoly = false,
                    minZ = v.pos.z - 2,
                    maxZ = v.pos.z + 2
                })
        end

        local usageCombo = ComboZone:Create(usageZones, {
            name = "customsZones",
            debugPoly = false
        })

        usageCombo:onPlayerInOut(function(isInsidePoint, position, data)
            isInZone = isInsidePoint
            if isInsidePoint then
                zoneJobName = string.sub(data.name, 9, #data.name)
                if PlayerData and PlayerData.job and PlayerData.job.name ==
                    zoneJobName then
                    exports["qb-core"]:DrawText(
                        Config.Polyzones.KeyLabel .. " - " ..
                            Lang:t("info.usageText"))
                    Functions.StartOpenListener()
                end
            end

            exports["qb-core"]:HideText()
        end)
    elseif Config.OpenType == "target" then
        if Config.Target.Script == "qb-target" then
            local targetState = Functions.AwaitResource("qb-target")
            if targetState then
                for i, v in pairs(Config.Positions) do
                    exports['qb-target']:AddBoxZone("customs-" .. i, vector3(
                                                        v.pos.x, v.pos.y,
                                                        v.pos.z),
                                                    Config.Target.Size[1],
                                                    Config.Target.Size[2], {
                        name = "customs-" .. i,
                        heading = v.pos.w,
                        minZ = v.pos.z - 2,
                        maxZ = v.pos.z + 2
                    }, {
                        distance = Config.Target.UsageDistance,
                        options = {
                            {
                                icon = Config.Target.Icon,
                                label = Lang:t("info.usageText"),
                                action = function()
                                    Functions.Open(i)
                                end,
                                job = i,
                                drawDistance = Config.Target.UsageDistance
                            }
                        }
                    })
                end
            else
                Functions.ErrorPrint(
                    "You have set Config.OpenType to \"target\" but qb-target is missing")
            end
        elseif Config.Target.Script == "ox_target" then
            local targetState = Functions.AwaitResource("ox_target")
            if targetState then
                for i, v in pairs(Config.Positions) do
                    local zoneId = exports["ox_target"]:addBoxZone({
                        coords = vector3(v.pos.x, v.pos.y, v.pos.z),
                        size = vector3(Config.Target.Size[1],
                                       Config.Target.Size[2],
                                       Config.Target.Size[3]),
                        rotation = v.pos.w,
                        debug = false,
                        interactionDistance = Config.Target.UsageDistance,
                        drawSprite = false,
                        options = {
                            {
                                name = "customs-" .. i,
                                icon = Config.Target.Icon,
                                label = Lang:t("info.usageText"),
                                onSelect = function()
                                    Functions.Open(i)
                                end,
                                canInteract = function()
                                    if PlayerData and PlayerData.job then
                                        return PlayerData.job.name == i
                                    else
                                        return false
                                    end
                                end
                            }
                        }
                    })

                    targetZoneIds[#targetZoneIds + 1] = zoneId
                end
            else
                Functions.ErrorPrint(
                    "You have set Config.OpenType to \"target\" but ox_target is missing")
            end
        else
            Functions.ErrorPrint("Invalid value for Config.TargetScript")
        end
    elseif Config.OpenType == "proximity" then
        local proximityState = Functions.AwaitResource("zerio-proximityprompt")
        if proximityState then
            for i, v in pairs(Config.Positions) do
                local prompt = exports["zerio-proximityprompt"]:AddNewPrompt({
                    name = "customs-" .. i,
                    job = i,
                    objecttext = QBCore.Shared.Jobs[i].label,
                    actiontext = Lang:t("info.usageText"),
                    holdtime = Config.Proximity.HoldTime,
                    key = Config.Proximity.Key,
                    position = v.pos,
                    usage = function() Functions.Open(i) end,
                    drawdist = Config.Proximity.DrawDistance,
                    usagedist = Config.Proximity.UsageDistance
                })
                prompts[#prompts + 1] = prompt
            end
        else
            Functions.ErrorPrint(
                "You have set Config.OpenType to \"proximity\" but zerio-proximityprompt is missing")
        end
    else
        Functions.ErrorPrint("Invalid value for Config.OpenType")
    end
end)

