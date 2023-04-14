RegisterNUICallback('close', function()
    exit()
end)

RegisterNUICallback('focus', function()
    focus()
end)

RegisterNUICallback('create-blip', function(data, cb)
    local isGlobal = data.isGlobal

    exit()

    if (isGlobal) then
        createGlobalBlip(cb)
    else
        createBlip(cb)
    end
end)

RegisterNUICallback('create-blip-from-coords', function(data, cb)
    local x = data.x
    local y = data.y
    local isGlobal = data.isGlobal

    if (isGlobal) then
        createGlobalBlipFromCoords(x, y, cb)
    else
        createBlipFromCoords(x, y, cb)
    end
end)

RegisterNUICallback('duplicate-blip', function(data, cb)
    exit()

    local blipIdToDuplicate = data.blipIdToDuplicate

    placeBlip(function(blip, blipCoords)
        duplicateBlip(data.blipIdToDuplicate, blipCoords.x, blipCoords.y)
        
        RemoveBlip(blip)

        Citizen.Wait(1000)

        cb(true)
    end)
end)

RegisterNUICallback('duplicate-blip-from-coords', function(data, cb)
    local x = data.x
    local y = data.y
    local blipIdToDuplicate = data.blipIdToDuplicate

    duplicateBlip(data.blipIdToDuplicate, x, y)

    Citizen.Wait(1000)

    cb(true)
end)

RegisterNUICallback('get-saved-blips', function(data, cb)
    local blips = {}

    for blipId, blipData in pairs(playerBlips) do
        blips[tostring(blipId)] = blipData
    end

    cb(json.encode(blips))
end)

RegisterNUICallback('save-blip', function(data, cb)
    local blipId = data.blipId

    saveBlip(blipId)
    
    cb(true)
end)

RegisterNUICallback('save-global-blip', function(data, cb)
    local blipId = data.blipId
    local globalId = data.globalId

    saveGlobalBlip(blipId, globalId, cb)
end)

-- [[ Edit blips ]]

RegisterNUICallback('edit-blip-name', function(data, cb)
    local blipId = data.blipId
    local blipName = data.blipName

    setCustomBlipName(blipId, blipName)
end)

RegisterNUICallback('edit-blip-scale', function(data, cb)
    local blipId = data.blipId
    local blipScale = data.blipScale

    setCustomBlipScale(blipId, blipScale)
end)

RegisterNUICallback('edit-blip-alpha', function(data, cb)
    local blipId = data.blipId
    local blipAlpha = data.blipAlpha

    setCustomBlipAlpha(blipId, blipAlpha)
end)

RegisterNUICallback('edit-blip-color', function(data, cb)
    local blipId = data.blipId
    local blipColor = data.blipColor

    setCustomBlipColor(blipId, blipColor)
end)

RegisterNUICallback('edit-blip-sprite', function(data, cb)
    local blipId = data.blipId
    local blipSprite = data.blipSprite

    setCustomBlipSprite(blipId, blipSprite)
end)

RegisterNUICallback('edit-blip-tick', function(data, cb)
    local blipId = data.blipId
    local blipTick = data.blipTick

    setCustomBlipTick(blipId, blipTick)
end)

RegisterNUICallback('edit-blip-outline', function(data, cb)
    local blipId = data.blipId
    local blipOutline = data.blipOutline

    setCustomBlipOutline(blipId, blipOutline)
end)

RegisterNUICallback('edit-blip-display', function(data, cb)
    local blipId = data.blipId
    local blipDisplay = data.blipDisplay

    setCustomBlipDisplay(blipId, blipDisplay)
end)

RegisterNUICallback('delete-blip', function(data, cb)
    local blipId = data.blipId

    deleteBlip(blipId)
end)

RegisterNUICallback('delete-global-blip', function(data, cb)
    local blipId = data.blipId
    local globalId = data.globalId

    deleteBlip(blipId)
    TriggerServerEvent('blips_creator:deleteGlobalBlip', globalId)
end)

RegisterNUICallback('share-blip', function(data, cb)
    local playerId = data.playerId
    local blipId = data.blipId

    shareBlipToPlayerId(playerId, blipId)
end)

RegisterNUICallback('hide-blip', function(data, cb)
    local blipId = tonumber(data.blipId)

    hideBlip(blipId)

    cb(true)
end)

RegisterNUICallback('show-blip', function(data, cb)
    local blipId = tonumber(data.blipId)

    showBlip(blipId)

    cb(true)
end)

RegisterNUICallback('edit-blip-type', function(data, cb)
    local blipId = tonumber(data.blipId)
    local blipType = data.blipType

    setCustomBlipType(blipId, blipType)

    cb(true)
end)

RegisterNUICallback('edit-blip-height', function(data, cb)
    local blipId = tonumber(data.blipId)
    local blipHeight = data.blipHeight

    setCustomBlipHeight(blipId, blipHeight)

    cb(true)
end)

RegisterNUICallback('edit-blip-width', function(data, cb)
    local blipId = tonumber(data.blipId)
    local blipWidth = data.blipWidth

    setCustomBlipWidth(blipId, blipWidth)

    cb(true)
end)