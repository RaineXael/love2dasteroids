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
  
  self.maxVelocity = 180
  self.thrust = 5

  require("game/playerBullet")

  self.playerBulletTable = {}

end

function Player:Update(dt)

	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		self.rotation = self.rotation - (dt * self.rotateSpeed)
	end
	
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		self.rotation = self.rotation + (dt * self.rotateSpeed)
	end
	
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		self.velocity.x = self.velocity.x - math.cos(degToRad(self.rotation))
		self.velocity.y = self.velocity.y - math.sin(degToRad(self.rotation))
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
	
	for i in pairs(self.playerBulletTable) do
		self.playerBulletTable[i]:Update(dt)
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


function Player:Draw()

  love.graphics.draw(self.sprite, math.floor(self.x),math.floor(self.y),degToRad(self.rotation - 90), 0.25, 0.25, 32, 32)
  love.graphics.line( self.x, self.y, self.x + self.velocity.x, self.y + self.velocity.y)

	--draw bullets
	for i in pairs(self.playerBulletTable) do
		self.playerBulletTable[i]:Draw()
	end

end

function Player:OnKeyPress(key)
	if key == "j" or key == "z" then 
	--summon projectile

	table.insert(self.playerBulletTable, PlayerBullet(self.x, self.y, self.rotation - 180))
	end
end
