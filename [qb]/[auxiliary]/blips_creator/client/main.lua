local isInitCompleted = false
local isMapActive = false

playerBlips = {}

local hiddenBlipsKvp = GetCurrentResourceName() .. ":hidden_blips:" .. GetCurrentServerEndpoint()

local hiddenBlips = json.decode(GetResourceKvpString(hiddenBlipsKvp)) or {}

local globalsCallback = nil
local activatedNuiAdmin = false
local isAdmin = false

function saveBlip(blipId)
    TriggerServerEvent('blips_creator:saveBlip', blipId, playerBlips[blipId])
end

function hideBlip(blipId)
    local blip = playerBlips[blipId].blip

    SetBlipAlpha(blip, 0.0)
    SetBlipDisplay(blip, 0)
    SetBlipHiddenOnLegend(blip, true)

    playerBlips[blipId].isHidden = true

    hiddenBlips[blipId] = true

    SetResourceKvp(hiddenBlipsKvp, json.encode(hiddenBlips))
end

function showBlip(blipId)
    local blip = playerBlips[blipId].blip

    SetBlipAlpha(blip, playerBlips[blipId].alpha)
    SetBlipDisplay(blip, playerBlips[blipId].display)
    SetBlipHiddenOnLegend(blip, false)

    playerBlips[blipId].isHidden = false

    hiddenBlips[blipId] = false
    SetResourceKvp(hiddenBlipsKvp, json.encode(hiddenBlips))
end

local function blipFromWaypoint()
    local wBlip = GetFirstBlipInfoId(8)
    local wBlipCoords = GetBlipCoords(wBlip)
    local newBlip = AddBlipForCoord(wBlipCoords)

    SetWaypointOff()

    return newBlip
end

local function mapActive()
    SendNUIMessage({
        action = "mapActive"
    })

    local lastItemMenuId, selectedItem = GetPauseMenuSelection()

    while IsPauseMenuActive() and selectedItem ~= -1 do
        Citizen.Wait(0)

        if (IsControlJustReleased(2, 203)) then
            if(not activatedNuiAdmin and isAdmin) then
                activatedNuiAdmin = true
                SendNUIMessage({
                    action = "activateAdmin",
                })
            end

            SendNUIMessage({
                action = "openBlipsMenu",
            })
            SetNuiFocus(true, true)
        end

        lastItemMenuId, selectedItem = GetPauseMenuSelection()
    end

    SendNUIMessage({
        action = "mapClosed"
    })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(800)

        if(not config.adminsOnly or isAdmin) then
            local lastItemMenuId, selectedItem = GetPauseMenuSelection()
            if (IsPauseMenuActive() and lastItemMenuId == 0 and selectedItem == 0) then
                mapActive()
            end
        else
            Citizen.Wait(2000)
        end
    end
end)

function exit()
    SetNuiFocus(false, false)
end

function focus()
    SetNuiFocus(true, true)
end

local function addBlip(blipId, blipData)
    local blip = nil
    
    if(blipData.type == "coords") then
        blip = AddBlipForCoord(blipData.x + .0, blipData.y + .0, blipData.z + .0)
    elseif(blipData.type == "area") then
        blip = AddBlipForArea(blipData.x + .0, blipData.y + .0, blipData.z + .0, blipData.width + .0, blipData.height + .0)
    elseif(blipData.type == "radius") then
        blip = AddBlipForRadius(blipData.x + .0, blipData.y + .0, blipData.z + .0, blipData.scale + .0)
    end

    playerBlips[blipId].blip = blip

    SetBlipAlpha(blip, blipData.alpha)

    if(blipData.type ~= "area") then
        SetBlipScale(blip, blipData.scale + .0)
    end

    if(blipData.type == "coords") then
        SetBlipSprite(blip, blipData.sprite)
        ShowTickOnBlip(blip, blipData.ticked)
        ShowOutlineIndicatorOnBlip(blip, blipData.outline)
    end

    SetBlipColour(blip, blipData.color)
    SetBlipDisplay(blip, blipData.display)
    SetBlipAsShortRange(blip, true)

    AddTextEntry('blipname', blipData.name)

    BeginTextCommandSetBlipName("blipname")
    EndTextCommandSetBlipName(blip)

    if(hiddenBlips[blipId]) then
        hideBlip(blipId)
    end
end

local function addBlips()
    debugPrint("Adding all blips")
    
    for blipId, blipData in pairs(playerBlips) do
        addBlip(blipId, blipData)
    end
end

function setCustomBlipName(blipId, text)
    debugPrint("Set blip name")
    blipId = tonumber(blipId)

    if (text) then
        playerBlips[blipId].name = text

        AddTextEntry('blipname', text)

        BeginTextCommandSetBlipName("blipname")
        EndTextCommandSetBlipName(playerBlips[blipId].blip)
    end
end

function setCustomBlipColor(blipId, color)
    debugPrint("Set blip color")
    blipId = tonumber(blipId)
    color = tonumber(color)

    if (color) then
        SetBlipColour(playerBlips[blipId].blip, color)
        playerBlips[blipId].color = color
    end
end

function setCustomBlipAlpha(blipId, alpha)
    debugPrint("Set blip alpha")

    blipId = tonumber(blipId)
    alpha = tonumber(alpha)

    if (alpha) then
        SetBlipAlpha(playerBlips[blipId].blip, alpha)
        playerBlips[blipId].alpha = alpha
    end
end

function setCustomBlipScale(blipId, scale)
    debugPrint("Set blip scale")
    
    blipId = tonumber(blipId)
    scale = tonumber(scale) + .0

    if (scale) then
        SetBlipScale(playerBlips[blipId].blip, scale)
        playerBlips[blipId].scale = scale
    end
end

function setCustomBlipSprite(blipId, sprite)
    debugPrint("Set blip sprite")

    blipId = tonumber(blipId)
    sprite = tonumber(sprite)

    if (sprite) then
        SetBlipSprite(playerBlips[blipId].blip, sprite)
        setCustomBlipName(blipId, playerBlips[blipId].name)
        playerBlips[blipId].sprite = sprite
    end
end

function setCustomBlipTick(blipId, isTicked)
    debugPrint("Set blip tick")

    blipId = tonumber(blipId)

    ShowTickOnBlip(playerBlips[blipId].blip, isTicked)
    playerBlips[blipId].ticked = isTicked
end

function setCustomBlipOutline(blipId, isOutlined)
    debugPrint("Set blip outline")

    blipId = tonumber(blipId)

    ShowOutlineIndicatorOnBlip(playerBlips[blipId].blip, isOutlined)

    playerBlips[blipId].outline = isOutlined
end

function setCustomBlipDisplay(blipId, display)
    debugPrint("Set blip display")

    blipId = tonumber(blipId)

    if (display) then
        SetBlipDisplay(playerBlips[blipId].blip, display)
        playerBlips[blipId].display = display
    end
end

function setCustomBlipType(blipId, type)
    debugPrint("Set blip type")

    playerBlips[blipId].type = type

    if(type == "coords") then
        playerBlips[blipId].scale = 1.0
    elseif(type == "radius") then
        playerBlips[blipId].scale = 20.0
    elseif(type == "area") then
        playerBlips[blipId].width = 20.0
        playerBlips[blipId].height = 20.0
    end

    if(DoesBlipExist(playerBlips[blipId].blip)) then
        RemoveBlip(playerBlips[blipId].blip)
    end

    addBlip(blipId, playerBlips[blipId])
end

function setCustomBlipHeight(blipId, height)
    debugPrint("Set blip height")

    playerBlips[blipId].height = height

    if(DoesBlipExist(playerBlips[blipId].blip)) then
        RemoveBlip(playerBlips[blipId].blip)
    end

    addBlip(blipId, playerBlips[blipId])
end

function setCustomBlipWidth(blipId, width)
    debugPrint("Set blip width")

    playerBlips[blipId].width = width

    if(DoesBlipExist(playerBlips[blipId].blip)) then
        RemoveBlip(playerBlips[blipId].blip)
    end

    addBlip(blipId, playerBlips[blipId])
end

function placeBlip(cb)
    Citizen.CreateThread(function()
        SetCursorLocation(0.50, 0.50)

        local blipCreated = false

        while not blipCreated do
            SetCursorSprite(11)

            if (IsWaypointActive()) then
                blipCreated = true
                local blip = blipFromWaypoint()

                local blipCoords = GetBlipCoords(blip)

                cb(blip, blipCoords)
            end

            Citizen.Wait(0)
        end
    end)
end

function createBlip(cb)
    debugPrint("creating a blip")

    placeBlip(function(blip, blipCoords)
        local blipSprite = GetBlipSprite(blip)
        local blipColor = GetBlipColour(blip)
        local streetNameHash = GetStreetNameAtCoord(blipCoords.x, blipCoords.y, blipCoords.z)

        local blipData = {
            x = blipCoords.x,
            y = blipCoords.y,
            z = blipCoords.z,
            type = "coords",
            streetName = GetStreetNameFromHashKey(streetNameHash),
            sprite = blipSprite,
            name = "New Blip",
            scale = 1.0,
            alpha = 255,
            color = blipColor,
            ticked = false,
            outline = false,
            display = 3
        }

        TriggerServerEvent('blips_creator:createPlayerBlip', blipData)

        RemoveBlip(blip)

        Citizen.Wait(1000)

        cb(true)
    end)
end

function createBlipFromCoords(x, y, cb)
    debugPrint("creating blip from coords")

    x = tonumber(x) + 0.0
    y = tonumber(y) + 0.0

    local blip = AddBlipForCoord(x, y, 0.0)

    local blipCoords = GetBlipCoords(blip)
    local blipSprite = GetBlipSprite(blip)
    local blipColor = GetBlipColour(blip)
    local streetNameHash = GetStreetNameAtCoord(blipCoords.x, blipCoords.y, blipCoords.z)

    local blipData = {
        x = blipCoords.x,
        y = blipCoords.y,
        z = blipCoords.z,
        type = "coords",
        streetName = GetStreetNameFromHashKey(streetNameHash),
        sprite = blipSprite,
        name = "New Blip",
        scale = 1.0,
        alpha = 255,
        color = blipColor,
        ticked = false,
        outline = false,
        display = 3
    }

    RemoveBlip(blip)

    TriggerServerEvent('blips_creator:createPlayerBlip', blipData)

    Citizen.Wait(1000)

    cb(true)
end

function createGlobalBlipFromCoords(x, y, cb)
    debugPrint("Creating global blip form coords")

    x = tonumber(x) + 0.0
    y = tonumber(y) + 0.0

    local blip = AddBlipForCoord(x, y, 0.0)

    local streetNameHash = GetStreetNameAtCoord(x, y, 0.0)

    local blipData = {
        x = x,
        y = y,
        z = 0.0,
        type = "coords",
        streetName = GetStreetNameFromHashKey(streetNameHash),
        sprite = 1,
        name = "New Blip",
        scale = 1.0,
        alpha = 255,
        color = 0,
        ticked = false,
        outline = false,
        display = 3,
        isGlobal = true
    }

    SetBlipAsShortRange(blip, true)
    
    RemoveBlip(blip)

    TriggerServerEvent('blips_creator:createGlobalBlip', blipData)

    Citizen.Wait(1000)

    cb(true)
end

function createGlobalBlip(cb)
    debugPrint("Creating global blip")

    SetCursorLocation(0.50, 0.50)

    local blipCreated = false

    while not blipCreated do
        SetCursorSprite(11)

        if (IsWaypointActive()) then
            blipCreated = true
            local blip = blipFromWaypoint()

            local blipCoords = GetBlipCoords(blip)
            local blipSprite = GetBlipSprite(blip)
            local blipColor = GetBlipColour(blip)
            local streetNameHash = GetStreetNameAtCoord(blipCoords.x, blipCoords.y, blipCoords.z)

            local blipData = { 
                x = blipCoords.x,
                y = blipCoords.y,
                z = blipCoords.z,
                type = "coords",
                streetName = GetStreetNameFromHashKey(streetNameHash),
                sprite = blipSprite,
                name = "New Blip",
                scale = 1.0,
                alpha = 255,
                color = blipColor,
                ticked = false,
                outline = false,
                display = 3,
                isGlobal = true
            }

            TriggerServerEvent('blips_creator:createGlobalBlip', blipData)

            RemoveBlip(blip)

            Citizen.Wait(1000)

            cb({})
        end

        Citizen.Wait(0)
    end
end

function duplicateBlip(blipIdToDuplicate, x, y)
    local streetNameHash = GetStreetNameAtCoord(x, y, 0.0)
    local streetName = GetStreetNameFromHashKey(streetNameHash)
    
    TriggerServerEvent('blips_creator:duplicateBlip', tonumber(blipIdToDuplicate), x, y, streetName)
end

function deleteBlip(blipId)
    debugPrint("Deleting a blip")

    blipId = tonumber(blipId)

    if (DoesBlipExist(playerBlips[blipId].blip)) then
        RemoveBlip(playerBlips[blipId].blip)
    end

    playerBlips[blipId] = nil

    TriggerServerEvent('blips_creator:deleteBlip', blipId)
end

function shareBlipToPlayerId(playerId, blipId)
    debugPrint("Sharing a blip")

    blipId = tonumber(blipId)

    TriggerServerEvent('blips_creator:shareBlipToPlayerId', playerId, playerBlips[blipId])
end

local function refreshBlips()
    debugPrint("Refreshing blips")

    for blipId, blipData in pairs(playerBlips) do
        if (DoesBlipExist(blipData.blip)) then
            RemoveBlip(blipData.blip)
        end
    end

    playerBlips = {}

    TriggerServerEvent('blips_creator:getPlayerBlips')
end
RegisterNetEvent('blips_creator:refreshBlips', refreshBlips)

local function loadPlayerBlips(blips)
    playerBlips = blips

    addBlips()
end
RegisterNetEvent('blips_creator:loadPlayerBlips', loadPlayerBlips)

local function init()
    if(not isInitCompleted) then
        isInitCompleted = true
        refreshBlips()

        TriggerServerEvent('blips_creator:isAdmin')
    end
end
Citizen.CreateThread(init)

RegisterNetEvent('blips_creator:isAdmin')
AddEventHandler('blips_creator:isAdmin', function(result)
    isAdmin = result
end)

RegisterNetEvent('blips_creator:giveNewBlip')
AddEventHandler('blips_creator:giveNewBlip', function(senderName, blipData)
    debugPrint("Receiving new blip")

    local running = true

    local msg = string.format(language["confirm_blip"], senderName, blipData.name)

    AddTextEntry("blips_creator_confirm", msg)

    while running do
        Citizen.Wait(0)

        DisplayHelpTextThisFrame("blips_creator_confirm", false)

        if (IsControlJustReleased(0, 191)) then
            running = false

            TriggerServerEvent('blips_creator:createPlayerBlip', blipData)
        elseif (IsControlJustReleased(0, 194)) then
            running = false
        end
    end
end)

local function editBlip(blipId)

end
RegisterNetEvent('blips_creator:editBlip', editBlip)