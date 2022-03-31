Player = Object:extend()

function Player:new(x,y)
  self.x = x
  self.y = y

  self.rotation = 0
  self.rotateSpeed = 5

  self.sprite = love.graphics.newImage("game/sprites/player.png")
  
  self.velocity = {
	  x = 0
	  y = 0
  }

end

function Player:Update(dt)

	if love.keyboard.isDown("a") then
	print("a pressed")
		self.rotation = self.rotation - (dt * self.rotateSpeed)
	end
	
	if love.keyboard.isDown("d") then
	print("d pressed")
		self.rotation = self.rotation + (dt * self.rotateSpeed)
	end
	
	if love.keyboard.isDown("w") then
	print("w pressed")
	end

end

function Player:degToRad(degree)
	return degree * (math.pi/180)
end

function Player:normalize(vector)
	magnitude = math.sqrt(math.pow(vector.x,2) + math.pow(vector.y,2))
	normalizedVector = {
		x = vector.x / magnitude
		y = vector.y / magnitude
	}
	return normalizedVector
end

function Player:Draw()

  love.graphics.draw(self.sprite, math.floor(self.x), math.floor(self.y), self:degToRad(self.rotation))

end

function Player:OnKeyPress(key)

end
