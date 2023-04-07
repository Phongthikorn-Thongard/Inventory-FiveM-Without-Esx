function CreatePlayer(player,account,inventory,name,coords)
    local self = {}

    self.player = player
    self.inventory = inventory
    self.name = name
    self.coords = coords
    self.account = account

    return self;
end