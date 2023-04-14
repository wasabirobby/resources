lib.callback.register('wasabi_police:getIdentifier', function(source, target)
    return GetIdentifier(target)
end)


RegisterServerEvent('wasabi_police:revokeLicense')
AddEventHandler('wasabi_police:revokeLicense', function(target, license)
    RevokeLicense(source, target, license)
end)

lib.callback.register('wasabi_police:getVehicleOwner', function(source, plate)
    local owner = GetVehicleOwner(plate)
    while owner == nil do Wait() end
    return owner
end)


lib.callback.register('wasabi_police:getJobLabel', function(source, job)
    local label = GetJobLabel(source)
    while label == nil do Wait() end
    return label
end)