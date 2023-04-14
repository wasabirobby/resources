-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
-- Customize the way it pulls user identification info?
lib.callback.register('wasabi_police:checkPlayerId', function(source, target)
    local data = GetPlayerIdentity(target)
    return data
end)