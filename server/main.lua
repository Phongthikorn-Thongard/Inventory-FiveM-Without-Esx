RegisterNetEvent("up:playerload")
AddEventHandler("up:playerload", function() 

end)

print("main_isready")

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local playerId = tonumber(source)
    local tasks = {}
    local user_data = {
        account = {},
        inventory = {},
        playerName = GetPlayerName(playerId)
    }

    table.insert(tasks, function(cb)
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', 
        {['identifier'] = GetPlayerIdentifierByType(playerId, 'license')}, function(rows)
            if #rows == 0 then
                MySQL.Async.execute('INSERT INTO users (identifier, name) VALUES (@identifier, @name) ', 
                {['identifier'] = GetPlayerIdentifierByType(playerId, 'license'), ['name'] = user_data.playerName}, function(rows)
                end)
            else
                MySQL.Async.execute('UPDATE users SET name = @name WHERE identifier = @identifier', 
                {['name'] = user_data.playerName, ['identifier'] = GetPlayerIdentifierByType(playerId, 'license')}, function(rows)
                end)
            end
            cb()
        end)
    end)

    table.insert(tasks, function(cb)
        MySQL.Async.fetchAll('SELECT identifier, item_id, quantity FROM user_inventory WHERE identifier = @identifier', 
        {['identifier'] = GetPlayerIdentifierByType(playerId, 'license')}, function(rows)
            if #rows ~= 0 then
                for _, v in pairs(rows) do
                    table.insert(user_data.inventory, v)
                end
            end
            cb()
        end)
    end)

    table.insert(tasks, function(cb)
        MySQL.Async.fetchAll('SELECT * FROM user_account WHERE identifier = @identifier', 
        {['identifier'] = GetPlayerIdentifierByType(playerId, 'license')}, function(rows)
            if #rows ~= 0 then
                for _, v in pairs(rows) do
                    table.insert(user_data.account, v)
                end
            else
                MySQL.Async.execute('INSERT INTO user_account (identifier, money) VALUES (@identifier, @money) ', 
                {['identifier'] = GetPlayerIdentifierByType(playerId, 'license'), ['money'] = 0}, function(rows)
                    MySQL.Async.fetchAll('SELECT * FROM user_account WHERE identifier = @identifier', 
                    {['identifier'] = GetPlayerIdentifierByType(playerId, 'license')}, function(rows)
                        if #rows ~= 0 then
                            for _, v in pairs(rows) do
                                table.insert(user_data.account, v)
                            end
                        end
                    end)
                end)
            end
            cb()
        end)
    end)

    Async.parallel(tasks, function(result)
        local player = CreatePlayer(playerId, user_data.account, user_data.inventory, user_data.playerName)
        UP.players[GetPlayerIdentifierByType(playerId, 'license')] = player
    end)

    -- local playerAccount = GetPlayerAccount(playerId)
    -- local playerInventory = LoadPlayerInventory(playerId)
    -- local playerCoords = GetPlayerSpawnCoords(playerId)
end)

RegisterServerEvent("up:getPlayerData")
AddEventHandler("up:getPlayerData", function(playerIdentifier)
    TriggerClientEvent("up:updatePlayerData", source, UP.players[GetPlayerIdentifierByType(tonumber(source), 'license')])
end)


MySQL.ready(function ()
    MySQL.Async.fetchAll('SELECT id, name, weight FROM items', {}, function(rows)
        UP.Items = rows
    end)
end)

AddEventHandler("onServerResourceStop", function()

end)

function SaveDB()
    MySQL.Async.execute('')
end


-- RegisterNetEvent("up:getplayer")
-- AddEventHandler("up:getplayer", function(source)
--     return UP.players[GetPlayerIdentifierByType(tonumber(source), 'license')]
-- end)