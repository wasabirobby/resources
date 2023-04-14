-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if GetResourceState('ox_core') ~= 'started' or not Ox then return end
Framework = 'ox'

function HasGroup(filter)
    return player.hasGroup(filter)
end