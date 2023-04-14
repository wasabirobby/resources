local resource = GetCurrentResourceName()

if IsDuplicityVersion() then 
    local ClientCommand = setmetatable({},{__newindex=function(t,k,fn) RegisterCommand(k,function(source, args, raw) local source = tonumber(source) if source>=1 then fn(source,table.unpack(args)) end end) return rawset(t,k,fn) end  })
    local RconCommand = setmetatable({},{__newindex=function(t,k,fn) RegisterCommand(k,function(source, args, raw) local source = tonumber(source) if source>=1 then else fn(table.unpack(args)) end end) return rawset(t,k,fn) end   })
    local SharedCommand = setmetatable({},{__newindex=function(t,k,fn) RegisterCommand(k,function(source, args, raw) local source = tonumber(source) fn(source,table.unpack(args)) end) return rawset(t,k,fn) end  })
    local COLOR_WHITE   = "#FFFFFF"
    local COLOR_FADE1   = "#E6E6E6"
    local COLOR_FADE2   = "#C8C8C8"
    local COLOR_FADE3   = "#AAAAAA"
    local COLOR_FADE4   = "#8C8C8C"
    local COLOR_FADE5   = "#6E6E6E"
    local COLOR_PURPLE  = "#C2A2DA"
    local COLOR_DBLUE   = "#2641FE"
    local COLOR_LIGHTBLUE = "#33CCFFAA"
    local COLOR_ALLDEPT = "#FF8282"
    local COLOR_NEWS    = "#FFA500"
    local COLOR_OOC     = "#E0FFFF"
    local COLOR_YELLOW  = "#FFFF00"
    
    local Chat = {}
    local _U = function(str,...)
        return string.format(Config.Locales[str],...)
    end 
    local ProxDetector = function(radius, player, message, color1, color2, color3, color4, color5)
         local message = message or ""

         local farlevel1 = radius/16
         local farlevel2 = radius/8 
         local farlevel3 = radius/4
         local farlevel4 = radius/2 
         local farlevel5 = radius 
         local targets = GetPlayers()
         local playerCoords = TriggerClientCallbackSynced("GetPosition",player)

         local routingTarget_nearPlayers   = {}
         local player        = tonumber(player)
         
         local currentLevel = 255
         local currentcolor = color5
         local currentopacity = 0.95
         for i=1, #targets, 1 do
            local target = tonumber(targets[i])
            if true or target ~= player then
            local targetCoords = TriggerClientCallbackSynced("GetPosition",target)
            local distance     = #(targetCoords-playerCoords)
            if distance < farlevel5 then 
                currentLevel = 5
                currentcolor = color5
            end 
            if distance < farlevel4 then 
                currentLevel = currentLevel - 1
                currentcolor = color4
            end 
            if distance < farlevel3 then 
                currentLevel = currentLevel - 1
                currentcolor = color3
            end 
            if distance < farlevel2 then 
                currentLevel = currentLevel - 1
                currentcolor = color2
            end 
            if distance < farlevel1 then 
                currentLevel = currentLevel - 1
                currentcolor = color1
            end 
            if currentLevel <= 5 then 
                table.insert(routingTarget_nearPlayers,target)
            end 
            end
         end
         if #routingTarget_nearPlayers > 0 then 
             local new_args = {message}
             local outMessage = {
                template = '<div style="color:'..currentcolor..';opacity : '..currentopacity..'">'..'{0}</div>',
                multiline = true,
                args = new_args
             }
             TriggerEvent('chatMessage', player, #outMessage.args > 1 and outMessage.args[1] or '', outMessage.args[#outMessage.args])
             for _, id in ipairs(routingTarget_nearPlayers) do
                 TriggerClientEvent('chat:addMessage', id, outMessage)
                 if Config.PlayTagSound then 
                    TriggerClientEvent(resource..':playchatsound_tap',id)
                end 
             end
         end 
         

    end 
    
    local OOCOff = function(color,message)
        local message = message or ""
        local new_args = {message}
        local outMessage = {
           template = '<div style="color:'..color..';">{0}</div>',
           multiline = true,
           args = new_args
        }

        TriggerClientEvent('chat:addMessage', -1, outMessage)
        if Config.PlayTagSound then 
            TriggerClientEvent(resource..':playchatsound_tap',-1)
        end 
    end 
    --Register Mapping functions 
    Chat["local"] = function(player,message)
        local message = message or ""
        local sendername = GetPlayerName(player)
		local string = _U("local", sendername, message) 
        ProxDetector(20.0,player,string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5)
    end 
    Chat["shout"] = function(player,message)
        local message = message or ""
        local sendername = GetPlayerName(player)
		local string = _U("shout", sendername, message) 
        ProxDetector(30.0,player,string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2)
    end 
    Chat["b"] = function(player,message)
        local message = message or ""
        local sendername = GetPlayerName(player)
		local string = _U("b", sendername, message) 
        ProxDetector(20.0,player,string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5)
    end 
    Chat["close"] = function(player,message)
        local message = message or ""
        local sendername = GetPlayerName(player)
		local string = _U("close", sendername, message)
        ProxDetector(3.0,player,string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5)
    end 
    Chat["whisper"] = function(player,target,message)
        local message = message or ""
        if player == target then 
            local sendername = GetPlayerName(player)
            local string = _U("whisper_self", sendername)
            ProxDetector(5.0,player,string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5)
        else 
            local sendername = GetPlayerName(player)
            local targetname = GetPlayerName(target)
            local msg = _U("whisper_target", sendername, player, message)
            local outMessage = {
               template = '<div style="color:'..COLOR_YELLOW..';">{0}</div>',
               multiline = true,
               args = {msg}
            }
            TriggerClientEvent('chat:addMessage', target, outMessage)
            
            local msg = _U("whisper_from", targetname, target)
            local outMessage = {
               template = '<div style="color:'..COLOR_YELLOW..';">{0}</div>',
               multiline = true,
               args = {msg}
            }
            TriggerClientEvent('chat:addMessage', player, outMessage)
             if Config.PlayTagSound then 
                TriggerClientEvent(resource..':playchatsound_tap',target)
            end 
        end 
    end 
    Chat["me"] = function(player,message)
        local message = message or ""
        local sendername = GetPlayerName(player)
		local string = _U("me", sendername, message) 
        ProxDetector(30.0,player,string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE)
    end 
    Chat["do"] = function(player,message)
        local message = message or ""
        local sendername = GetPlayerName(player)
		local string = _U("do", sendername, message) 
        ProxDetector(30.0,player,string,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE,COLOR_LIGHTBLUE)
    end 
    Chat["ooc"] = function(player,message)
        local message = message or ""
        local sendername = GetPlayerName(player)
		local string = _U("ooc", sendername, message)
        OOCOff(COLOR_OOC, string)
    end 
    Chat["dice"] = function(player)
        math.randomseed(GetGameTimer())
        local dice = math.random(1,6);
        local sendername = GetPlayerName(player)
		local string = _U("dice", sendername, dice)
		ProxDetector(5.0, player, string, COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
    end 
    exports["chat"]:registerMessageHook(function(player, outMessage, hookRef)
        local player = tonumber(player)
        if player>=1 then 
            local original_args = outMessage.args 
            local message = original_args[#original_args]
            local registeredCommands = GetRegisteredCommands()
            local iscommand = message:sub(1, 1) == '/'
            if iscommand then 
                message = "Unknown command"
                local outMessage = {
                    color = { 255, 255, 255 },
                    multiline = true,
                    args = {message}
                }
                --hookRef.updateMessage(outMessage)
                hookRef.cancel() 
                TriggerClientEvent('chat:addMessage', player, outMessage)
                
            else 
                hookRef.cancel() 
                Chat["local"](player,message)
            end 
        end 
        
    end) 
    -- Register Commands 
    local cmdsays = {
        {"local","l"},
        {"shout","s"},
        {"b"},
        {"close","c"},
        {"me"},
        {"do"},
        {"ooc","o"},
        {"dice"}
    }
    for i=1,#cmdsays do 
        local v = cmdsays[i]
        local m,n = v[1],v[2]
         
        ClientCommand[m] = function(player,...)
           
            Chat[m](player,table.concat({...}," "))
        end 
        if n then ClientCommand[n] = ClientCommand[m] end 
    end 
    
    ClientCommand["whisper"] = function(player,target,...)
        local player = tonumber(player)
        if GetPlayerEndpoint(target) then 
            local target = tonumber(target)
            Chat["whisper"](player,target,table.concat({...}," "))
        end 
    end 
    ClientCommand["w"] = ClientCommand["whisper"]

    exports("ProxDetector",ProxDetector)
    exports("OOCOff",OOCOff)
else 
    RegisterClientCallback("GetPosition",function(cb)
        cb(GetEntityCoords(PlayerPedId()))
    end)
end 