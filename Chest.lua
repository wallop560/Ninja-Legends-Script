local Chest = {}
Chest.__index = Chest

Chest.new = function(Model)
    if not Model:FindFirstChild('Chest') then return end
    
    local self = setmetatable({},Chest)
    
    self.Model = Model
    self.Name = Model.Name
    self.SellPoint = Model.circleInner
    
    return self
end

Chest.IsReady = function(self)
    if not self.Model or not self.Model:FindFirstChild('circleSignPart') then return end
    return self.Model.circleSignPart.signGui.timeLabel.Text == 'Ready To Collect'
end

Chest.Sell = function(self)
    if self:IsReady() then
        local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        
        firetouchinterest(self.SellPoint,HRP,0)
        firetouchinterest(self.SellPoint,HRP,1)
    end
end

Chest.GetChests = function()
    local Chests = {}
    for _,v in next,workspace:GetChildren() do
        local Chest = Chest.new(v)
        
        if Chest then
            table.insert(Chests,Chest)
        end
    end
    return Chests
end


Chest.GetReadyChests = function()
    local Chests = {}
    for _,v in next,workspace:GetChildren() do
        local ChestObject = Chest.new(v)
        if ChestObject then print(v) end
        
        if ChestObject and ChestObject:IsReady() then
            table.insert(Chests,ChestObject)
        end
    end
    return Chests
end

return Chest
