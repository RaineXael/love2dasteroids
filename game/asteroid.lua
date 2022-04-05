Asteroid = Object:extend()

function Asteroid:new(x,y,velocityX, velocityY,speed,destroyedLevel)
    self.x = x
    self.y = y

    self.speed = speed
    self.velocity = {
	  x = velocityX,
	  y = velocityY
	}
	
	self.dead = false
  
	--normalize vel
	self.magnitude = math.sqrt(math.pow(self.velocity.x, 2) + math.pow(self.velocity.y, 2))
	self.velocity.x = (self.velocity.x / self.magnitude)
	self.velocity.y = (self.velocity.y / self.magnitude)

    self.scoreWorth = scoreWorth
    self.destroyedLevel = destroyedLevel
    --starts at 3, when broken down goes down by 1. If 0, don't spawn.
    
    self.size = 0
    if self.destroyedLevel == 3 then
        self.size = 28
    elseif self.destroyedLevel == 2 then
        self.size = 18
    elseif self.destroyedLevel == 1 then
        self.size = 8
    else
        --no
		self.dead = true
    end
end

function Asteroid:Update(dt)
--float somewhere

	self.x = self.x + self.velocity.x * dt * self.speed
	self.y = self.y + self.velocity.y * dt * self.speed

end

function Asteroid:Fragment()
--give player score, mark for death, and fragment
	--table.insert(asteroids, Asteroid(self.x, self.y, -15, 15, 10, self.destroyedLevel - 1))
	--table.insert(asteroids, Asteroid(self.x, self.y, 15, -15, 10, self.destroyedLevel - 1))
	self.dead = true
end

function Asteroid:OnKeyPress(key)
	if key == "t" then
		self:Fragment()
	end
end

function Asteroid:Draw()
    love.graphics.circle("fill", self.x, self.y, self.size)
end