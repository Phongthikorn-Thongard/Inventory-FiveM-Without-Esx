RegisterNetEvent("up:playerload")
AddEventHandler("up:playerload", function() 

end)



AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    print('Player is connecting to the server!')
end)


MySQL.ready(function ()
   
end)