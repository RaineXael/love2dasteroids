Player = Object:extend()

function Player:new(x,y)
  self.x = x
  self.y = y

  self.sprite = love.graphics.newImage("game/sprites/player.png")

end

function Player:Update(dt)



end

function Player:Draw()

  love.graphics.draw(self.sprite, math.floor(self.x), math.floor(self.y))

end

function Player:OnKeyPress(key)

end