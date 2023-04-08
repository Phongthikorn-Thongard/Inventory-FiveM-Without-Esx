RegisterCommand("giveitem", function(playerSrc, args)
    local itemQuantity = tonumber(args[2])
    print("Running giveitem command for item ".. itemQuantity)

    MySQL.Async.execute('INSERT INTO player_inventory (player_id, item_id, quantity) VALUES (@playerId, @itemId, @quantity)',
        { ['playerId'] = GetPlayerIdentifierByType(playerSrc, 'license'), ['itemId'] = args[1], ['quantity'] = itemQuantity},
        function(rowsAffected)
            print(rowsAffected)
        end)
end)

RegisterCommand("additem", function(playerSrc, args)
    print("Trying to add item...")
    if #args < 2 then
        local message = 'You must provide a name and weight for the item. Usage: /additem <name> <weight>'
        TriggerClientEvent("up:playerlog", tonumber(playerSrc), message)
        print(message)
        return
    end
    local itemName = args[1]
    local itemWeight = tonumber(args[2])
    local playerId = tonumber(playerSrc)

    -- Insert the new item into the database
    MySQL.Async.execute('INSERT INTO items (name, weight) VALUES (@itemName, @itemWeight)',
        { ['itemName'] = itemName, ['itemWeight'] = itemWeight },
        function(rowsAffected)
            if rowsAffected > 0 then
                -- Retrieve the ID of the new item
                MySQL.Async.fetchScalar('SELECT id FROM items WHERE name = @itemName AND weight = @itemWeight', {['itemName'] = itemName, ['itemWeight'] = itemWeight}, function(newItemId)
                    local message = 'Added ' ..  itemName .. ' (Weight = ' .. itemWeight .. ') with ID ' .. newItemId
                    TriggerClientEvent("up:playerlog", playerId, message)
                    print(message)
                end)
            end
        end)
end)

RegisterCommand("replaceitem", function(playerSrc, args)
    if #args < 3 or tonumber(args[1]) == nil then
        local message = 'You must provide an ID, name, and weight for the item. Usage: /replaceitem <id> <name> <weight>'
        TriggerClientEvent("up:playerlog", tonumber(playerSrc), message)
        print(message)
        return
    end

    local itemId = tonumber(args[1])
    local itemName = args[2]
    local itemWeight = tonumber(args[3])
    local playerId = tonumber(playerSrc)

    MySQL.Async.execute('UPDATE items SET name = @itemName, weight = @itemWeight WHERE id = @itemId',
        { ['itemName'] = itemName, ['itemWeight'] = itemWeight, ['itemId'] = itemId },
        function(rowsAffected)
            local message = 'Replaced item with ID ' .. itemId .. ' (Name: ' .. itemName .. ', Weight: ' .. itemWeight .. ')'
            TriggerClientEvent("up:playerlog", playerId, message)
            print(message)
        end)
end)




RegisterCommand("removeitem", function(playerSrc, args)
    -- Check if item identifier is provided
    if #args < 1 then
        local message = 'You must provide an ID or name for the item. Usage: /removeitem <id or name>'
        TriggerClientEvent("up:playerlog", tonumber(playerSrc), message)
        print(message)
    end

    local itemIdentifier = args[1] -- The identifier of the item to be removed
    local playerId = tonumber(playerSrc) -- The ID of the player who triggered the command
    local itemId = nil -- The ID of the item to be removed

    -- Check if the identifier is an ID
    if tonumber(itemIdentifier) ~= nil then 
        -- Fetch the name of the item using its ID
        MySQL.Async.fetchScalar('SELECT name FROM items WHERE id = @itemId', { ['itemId'] = tonumber(itemIdentifier) }, function(name)
            if name ~= nil then
                -- Update the name of the item with the ID to "removed"
                MySQL.Async.execute('UPDATE items SET name = @newName WHERE id = @itemId', 
                    { ['newName'] = 'removed', ['itemId'] = tonumber(itemIdentifier) }, function()
                    local message = 'Removed item with ID ' .. tonumber(itemIdentifier) .. ' (name: ' .. name .. ')'
                    TriggerClientEvent("up:playerlog", playerId, message)
                    print(message)
                end)
            end
        end)
    else
        -- Fetch the ID of the item using its name
        MySQL.Async.fetchScalar('SELECT id FROM items WHERE name = @itemName', { ['itemName'] = itemIdentifier }, function(itemId)
            if itemId ~= nil then
                -- Update the name of the item with the name to "removed"
                MySQL.Async.execute('UPDATE items SET name = @newName WHERE id = @itemId', 
                    { ['newName'] = 'removed', ['itemId'] = itemId }, function()
                    local message = 'Removed item with name ' .. itemIdentifier .. ' (ID: ' .. itemId.. ')'
                    TriggerClientEvent("up:playerlog", playerId, message)
                    print(message)
                end)
            end
        end)
    end
end)

<<<<<<< HEAD
RegisterCommand("getallitem", function(playerSrc, args)
    MySQL.Async.fetchAll('SELECT id, name, weight FROM items', {}, function(rows)
        local items = {{"ID","Name","Weight"}}
        for _, row in ipairs(rows) do
            table.insert(items, {row.id, row.name, row.weight})
        end
        TriggerClientEvent("up:player_tablelog",tonumber(playerSrc),items)
        UP.PrintTable(items)
    end)
end)
=======
>>>>>>> bfdd52121ff0b8a6164ae552e01c0da67177f494
