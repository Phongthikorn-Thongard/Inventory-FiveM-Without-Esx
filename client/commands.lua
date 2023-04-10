RegisterCommand("getinventory", function(playerSrc, args)
    local items  = {{"Id","Quantity"}}

    for _, item in pairs(UP.inventory) do
        print(item)
        table.insert(items, {item.item_id, item.quantity})
    end
    UP.PrintTable(items)
end)