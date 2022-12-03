local SellPoint = {}
SellPoint.__index = SellPoint

SellPoint.new = function(Model)
    local self = setmetatable({},SellPoint)
    
    self.Model = Model
    self.SellCircle = Model:FindFirstChild('circleInner')
    self.SignGui = Model.circleSignPart.signGui
    self.Multiplier = 1 
    
    for _,v in next,self.SignGui:GetChildren() do
        if v:IsA('TextLabel') and v.Text:match(' Coins') then
            local RawMulti,index = v.Text:gsub(' Coins',''):gsub('x','')
            
            self.Multiplier = tonumber(RawMulti)
        end
    end
    
    return self
end

SellPoint.Sell = function(self)
    firetouchinterest(self.SellCircle,game.Players.LocalPlayer.Character.HumanoidRootPart,0)
    firetouchinterest(self.SellCircle,game.Players.LocalPlayer.Character.HumanoidRootPart,1)
end

SellPoint.GetSellPoints = function()
    local path = game:GetService("Workspace").sellAreaCircles
    
    local Points = {}
    
    for _,v in next,path:GetChildren() do
        table.insert(Points, SellPoint.new(v))
    end
    
    return Points
end

SellPoint.GetBest = function()
    local Points = SellPoint.GetSellPoints()
    
    local Highest
    
    for _,v in next,Points do
        if not Highest or v.Multiplier > Highest.Multiplier then
            Highest = v
        end
    end
    
    return Highest
end

return SellPoint
