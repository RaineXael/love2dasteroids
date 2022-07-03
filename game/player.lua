Player = Object:extend()

function Player:new(x,y)

	self.lives = 3

  self.x = x
  self.y = y
  
  self.width = 16
  self.height = 16

  self.rotation = 0
  self.rotateSpeed = 150

  self.sprite = love.graphics.newImage("game/sprites/player.png")
  
  self.velocity = {
	  x = 0,
	  y = 0
  }
   self.normalVelocity = {
		x = 0,
		y = 0
   }
  
  self.maxVelocity = 160 --default 160
  self.thrust = 160
	self.friction = 40

  require("game/playerBullet")
	require("game/shipDebris")

  self.playerBulletTable = {}
	self.playerDebrisTable = {}

	self.invincibleDuration = 2 --for respawn
	self.invincibleTimer = 0

	self.respawned = true --seccondary flag to determine if alive and spawned, for checking for asteroids on top of respawn point
	
	--sfx
	self.shootSFX = love.audio.newSource("game/sound/laserShoot.wav", "static")

end

function Player:Update(dt)
	
	if self.invincibleTimer <= 0 then
		if self.respawned then
			--if alive then
			if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
				self.rotation = self.rotation - (dt * self.rotateSpeed)
			end

			if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
				self.rotation = self.rotation + (dt * self.rotateSpeed)
			end

			if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
				self.velocity.x = self.velocity.x - math.cos(degToRad(self.rotation)) * self.thrust * dt
				self.velocity.y = self.velocity.y - math.sin(degToRad(self.rotation)) * self.thrust * dt
			end

			--do velocity

			self.x = self.x + self.velocity.x * dt 
			self.y = self.y + self.velocity.y * dt

			--clamp
			self:clampPosition()

			self.magnitude = math.sqrt(math.pow(self.velocity.x, 2) + math.pow(self.velocity.y, 2))
			--set normalized velocities
			self.normalVelocity.x = (self.velocity.x / self.magnitude)
			self.normalVelocity.y = (self.velocity.y / self.magnitude)

			if tostring(self.normalVelocity.x) == "nan" then
				self.normalVelocity.x = 0
			end
			if tostring(self.normalVelocity.y) == "nan" then
				self.normalVelocity.y = 0
			end


			if self.magnitude > self.maxVelocity then
				
				--normalize
				self.velocity.x = self.normalVelocity.x * self.maxVelocity
				self.velocity.y = self.normalVelocity.y * self.maxVelocity

				
			end
			--friction
			--apply an opposite force on the player on negative the normalized velocity.
			self.velocity.x = self.velocity.x - (dt * self.friction * self.normalVelocity.x)
			self.velocity.y = self.velocity.y - (dt * self.friction * self.normalVelocity.y)
		else
			--check if touching asteroid, and set respawned accordingly
			self.respawned = not checkAsteroidCollision()
		end

	else
		--else subtract timer
		self.invincibleTimer = self.invincibleTimer - dt

	end

	--detect asteroid collision
	if checkAsteroidCollision() then
		self:onHit()
	end
	
	for i in pairs(self.playerBulletTable) do
		self.playerBulletTable[i]:Update(dt)
		if self.playerBulletTable[i].dead then
			table.remove(self.playerBulletTable, i)
		end
	end

	for i in pairs(self.playerDebrisTable) do
		self.playerDebrisTable[i]:Update(dt)
		if self.playerDebrisTable[i].dead then
			table.remove(self.playerDebrisTable, i)
		end
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

function Player:onHit()

	--what happens when player gets hit (not actual hit detection)
	if self.invincibleTimer <= 0 and self.respawned == true then
		self.respawned = false
		self.invincibleTimer = self.invincibleDuration
		self.lives = self.lives - 1
	
		table.insert(self.playerDebrisTable, ShipDebris(self.x, self.y, 3))
		table.insert(self.playerDebrisTable, ShipDebris(self.x, self.y, 3))
		table.insert(self.playerDebrisTable, ShipDebris(self.x, self.y, 3))
	
		self.x = resolution.x / 2
		self.y = resolution.y / 2

		self.velocity.x = 0
		self.velocity.y = 0
	end

end

function Player:Draw()

 	if self.invincibleTimer <= 0 and self.respawned then
		love.graphics.draw(self.sprite,self.x,self.y,degToRad(self.rotation - 90), 0.15, 0.15, 32, 32)
		--love.graphics.line( self.x, self.y, self.x + self.velocity.x, self.y + self.velocity.y) --draw velocity vector	
	end

	for i in pairs(self.playerBulletTable) do
		self.playerBulletTable[i]:Draw()
	end

	for i in pairs(self.playerDebrisTable) do
			self.playerDebrisTable[i]:Draw()
	end

end

function Player:OnKeyPress(key)
	if (key == "j" or key == "z") and self.playerBulletTable[3] == nil and self.invincibleTimer <= 0 then 
	--summon projectile
	table.insert(self.playerBulletTable, PlayerBullet(self.x, self.y, self.rotation - 180))
	self.shootSFX:stop()
	self.shootSFX:play()
	end
end
