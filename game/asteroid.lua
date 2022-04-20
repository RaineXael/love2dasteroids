Asteroid = Object:extend()

function Asteroid:new(x,y,speed,destroyedLevel, scoreWorth)
    self.x = x
    self.y = y

    self.speed = speed
    self.velocity = self:RandomDirection()

    self.rotation = 0
    self.rotateSpeed = love.math.random(100)/50
	
	self.dead = false

    self.sprite = love.graphics.newImage("game/sprites/asteroid.png")
  
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

    --animate rotation
    self.rotation = self.rotation + self.rotateSpeed * dt

    if getDistanceBetween(self, player) < self.size then
        print("Player collide!")
        --kill player
        player:onHit()
    end

    self:clampPosition()
end

function Asteroid:Fragment()
--give player score, mark for death, and fragment
    direction = self:RandomDirection()



	table.insert(asteroids, Asteroid(self.x, self.y, self.speed * ((love.math.random(350)/100)+ 1)/2, self.destroyedLevel - 1, self.scoreWorth + 5))
	table.insert(asteroids, Asteroid(self.x, self.y, self.speed * ((love.math.random(350)/100)+ 1)/2, self.destroyedLevel - 1, self.scoreWorth + 5))
	self.dead = true
	
	score = score + self.scoreWorth
end

function Asteroid:RandomDirection()
    --returns a table with a random vector
    randomVector = {
        x = (love.math.random(200)/100)-1,
        y = (love.math.random(200)/100)-1
    }
    magnitude = math.sqrt(math.pow(randomVector.x, 2) + math.pow(randomVector.y, 2))
    randomVector.x = randomVector.x/magnitude
    randomVector.y = randomVector.y/magnitude

    return randomVector

end 

function Asteroid:clampPosition()
	--clamp camera
	if self.x <= 0 then

		self.x = resolution.x - 1
		--touch left side of screen
	end
	
	if (self.x) > resolution.x then
	--touch right side of screen
		self.x = 17
	end
	
	if(self.y < camera.y) then
		self.y = resolution.y - 1
	end
	
	if(self.y > (resolution.y)) then
		self.y = 17
	end
end

function Asteroid:Draw()
    --love.graphics.setColor(1,0,0)
    --love.graphics.circle("fill", self.x, self.y, self.size) --hitbox
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.sprite, self.x, self.y, self.rotation, self.size/64, self.size/64, 64,64) --sprite
end