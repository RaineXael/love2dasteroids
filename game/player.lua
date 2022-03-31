Player = Object:extend()

function Player:new(x,y)
  self.x = x
  self.y = y
  
  self.width = 16
  self.height = 16

  self.rotation = 0
  self.rotateSpeed = 130

  self.sprite = love.graphics.newImage("game/sprites/player.png")
  
  self.velocity = {
	  x = 0,
	  y = 0
  }
  
  self.maxVelocity = 150
  self.thrust = 5

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
	self.velocity.x = self.velocity.x - math.cos(self:degToRad(self.rotation))
	self.velocity.y = self.velocity.y - math.sin(self:degToRad(self.rotation))
	end
	
	if love.keyboard.isDown("r") then
	print("w pressed")
	self.x = resolution.x/2
	self.y = resolution.y/2
	end
	
	if love.keyboard.isDown("t") then
	print("w pressed")
	self.velocity.x = 0
	self.velocity.y = 0
	end
	
	--do velocity
	
	self.x = self.x + self.velocity.x * dt 
	self.y = self.y + self.velocity.y * dt
	
	
	--clamp
	self:clampPosition()
	
	self.magnitude = math.sqrt(math.pow(self.velocity.x, 2) + math.pow(self.velocity.y, 2))
	
	if self.magnitude > self.maxVelocity then
		print("Over velocity")
		--normalize
		self.velocity.x = (self.velocity.x / self.magnitude) * self.maxVelocity
		self.velocity.y = (self.velocity.y / self.magnitude) * self.maxVelocity
	end
	


end

function Player:clampPosition()
	--clamp camera
	if self.x  + 8 <= 0 then

		self.x = resolution.x - 1
		--touch left side of screen
	end
	
	if (self.x + self.width -16 ) > resolution.x then
	--touch right side of screen
		self.x = 17
	end
	
	if(self.y +8 < camera.y) then
		self.y = resolution.y - 1
	end
	
		if(self.y > ( resolution.y)) then
		self.y = 17
	end
end

function Player:degToRad(degree)
	return degree * (math.pi/180)
end



function Player:Draw()

  love.graphics.draw(self.sprite, math.floor(self.x),math.floor(self.y),self:degToRad(self.rotation - 90),1,1, 8, 8)
  love.graphics.setColor( 0, 1, 0 )
  --love.graphics.line( self.x, self.y, self.x + self.velocity.x, self.y + self.velocity.y)
  love.graphics.setColor( 1, 0, 0 )
  love.graphics.setColor( 1, 1, 1 )

end

function Player:OnKeyPress(key)

end
