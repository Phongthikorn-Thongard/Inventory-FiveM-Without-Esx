UP.GetPlayerBySource = function(source)

    local identifier = GetPlayerIdentifierByType(source, 'license')

    if UP.players[identifier] ~= nil then
        return UP.players[identifier]
    end
    print("Player not found")
end

UP.UpdatePlayerData = function(source)
    TriggerClientEvent("up:updatePlayerData", source, UP.players[GetPlayerIdentifierByType(source,'license')])
end

UP.GetInventoryBySource = function(source)
    return UP.players[GetPlayerIdentifierByType(source,'license')].inventory
end

UP.AddItemToInventory = function(source,itemId, quantity)
    local license = GetPlayerIdentifierByType(source, 'license')
    local inventory = UP.GetInventoryBySource(tonumber(source))

    local newitem = {}
    newitem.identifier = license
    newitem.item_id = itemId
    newitem.quantity = quantity

    for index, item in pairs(inventory) do
        print(item.item_id, itemId)
        if tonumber(item.item_id) == tonumber(itemId) then
            newitem.quantity = item.quantity + quantity
            inventory[index].quantity = newitem.quantity
            return
        end
    end

    table.insert(inventory, newitem)
end

UP.SavePlayer = function(player,cb)
    for i, item in pairs(player.inventory) do
        MySQL.Async.execute([[UPDATE user_inventory SET quantity = @Quantity WHERE identifier = @Identifier AND item_id = @Item_id]],
        {['Identifier'] = GetPlayerIdentifierByType(player.player, 'license'), ['Item_id'] = item.item_id, ['Quantity'] = item.quantity}, 
        function(rowsAffected)
            if rowsAffected == 0 or rowsAffected == nil then
                MySQL.Async.execute("INSERT INTO user_inventory (identifier, item_id, quantity) VALUES (@Identifier, @Item_Id, @Quantity)",
                {['Identifier'] = GetPlayerIdentifierByType(player.player, 'license'), ['Item_Id'] = item.item_id, ['Quantity'] = item.quantity}, function() end)
            end
        end)
    end
    --TODO: Save other player data to database.
end