function CreatePlayer(player,account,inventory,name)
    local self = {}

    self.player = player
    self.inventory = inventory
    self.name = name
    self.account = account

    self.getInventory = function()
        return self.inventory
    end
    self.getName = function()
        return self.name
    end
    return self;
end