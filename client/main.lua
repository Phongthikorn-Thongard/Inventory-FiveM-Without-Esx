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
    print(log)
end)