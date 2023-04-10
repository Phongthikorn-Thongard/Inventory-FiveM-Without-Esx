-- Declare variables
local display = false

print("ready")

-- Main loop
Citizen.CreateThread(function()
    while true do
        Wait(0)
        
        -- Check for key press
        if IsControlJustReleased(0, 289) then
            -- Toggle inventory display
            if not display then
                openInventory()
            else
                closeInventory()
            end
        end
    end
end)


-- Register callback for 'close' event
RegisterNUICallback('close', function(data, cb)
    -- Check if inventory is displayed
    if display then
        -- Hide inventory
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "hide",
            pause = IsPauseMenuActive()
        })
        display = false
    end
end)

-- Register callback for 'NUIFocusOff' event
RegisterNUICallback('NUIFocusOff', function()
    closeInventory()
end)

-- Display inventory
function openInventory()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "show",
        pause = IsPauseMenuActive()
    })
    display = true
end

-- Hide inventory
function closeInventory()
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "hide",
        pause = IsPauseMenuActive()
    })
    display = false
end


RegisterNetEvent("up:playerlog")
AddEventHandler("up:playerlog", function(log) 
    print(tostring(log))
end)


RegisterNetEvent("up:player_tablelog")
AddEventHandler("up:player_tablelog", function(items) 
    UP.PrintTable(items)
end)

Citizen.CreateThread(function()
    TriggerServerEvent("up:getPlayerData")
end)


-- RegisterNetEvent("up:player_loaded")
-- AddEventHandler("up:player_loaded", function(player, cb)
--     print("loaded")
--     print(player.name)
--     print(player.getName())
--     UP.inventory = player.getInventory()
--     UP.PrintTable(player.getInventory())
--     cb()
-- end)

RegisterNetEvent("up:updatePlayerData")
AddEventHandler("up:updatePlayerData", function(playerdata)
    if playerdata ~= nil then
        UP.inventory = playerdata.inventory
        UP.account = playerdata.account

        return
    end

    print("Data can't found.")
end)


-- Citizen.CreateThread(function()
--     TriggerServerEvent("up:getPlayerIdentifier")
-- end)

-- RegisterNetEvent("up:setPlayerIdentifier")
-- AddEventHandler("up:setPlayerIdentifier", function(identifier)
--     print(identifier)
-- end)



-- RegisterNetEvent("up:getplayer")
-- AddEventHandler("up:getplayer", function()
    
-- end)