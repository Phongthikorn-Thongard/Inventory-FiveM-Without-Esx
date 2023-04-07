RegisterCommand("giveitem", function(source,args)
    print("running give item "..tonumber(args[2]))
    MySQL.Async.execute('INSERT INTO player_inventory (player_id,item_id,quantity) VALUES (@id, @item_id, @quantity)',
        { ['id'] = GetPlayerIdentifierByType(source, 'license'), ['item_id'] = args[1], ['quantity'] = tonumber(args[2])},
        function(affectedRows)
            print(affectedRows)
        end)
end)

RegisterCommand("additem", function(source, args)
    if #args < 2 then
        local message = 'You must provide a name and weight for the item'
        TriggerClientEvent("up:playerlog", source, message)
        print(message)
        return
    end
    
    local name = args[1]
    local weight = tonumber(args[2])
    local playerid = tonumber(source)
    
    -- Insert the new item into the database
    MySQL.Async.execute('INSERT INTO items (name, weight) VALUES (@name, @weight)',
        { ['name'] = name, ['weight'] = weight },
        function(affectedRows)
            if affectedRows > 0 then
                -- Get the ID of the new item
                MySQL.Async.fetchScalar('SELECT LAST_INSERT_ID()', {}, function(newItemId)
                    local message = 'Added item with ID ' .. newItemId
                    TriggerClientEvent("up:playerlog", playerid, message)
                    print(message)
                end)
            end
        end)
    --TODO: Admin can replace id and can remove item from database
end)
