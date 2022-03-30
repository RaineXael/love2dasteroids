Player = Object:extend()

function Player:new(x,y)
  self.x = x
  self.y = y

  self.sprite = love.graphics.newImage("game/sprites/player.png")
  
  self.xVel = 0
  self.yVel = 0

end

function Player:Update(dt)

	if love.keyboard.isDown("a") then
	print("a pressed")
	end
	
	if love.keyboard.isDown("d") then
	print("d pressed")
	end
	
	if love.keyboard.isDown("w") then
	print("w pressed")
	end

end

function Player:Draw()

  love.graphics.draw(self.sprite, math.floor(self.x), math.floor(self.y))

end

function Player:OnKeyPress(key)

end