UP = {}

UP.inventory = {}
UP.account = {}

UP.GetClientPlayer = function(source)

    local identifier = GetPlayerIdentifier(source)

    if UP.players[identifier] ~= nil then
        return UP.players[identifier]
    end
    print("Player not found")
end