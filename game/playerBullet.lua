PlayerBullet = Object:extend()

function PlayerBullet:new(x,y, rotation, parentTable)
    self.x = x
    self.y = y
    self.rotation = rotation

    self.moveSpeed = 6
    self.lifespan = 1.5

    self.width = 3
    self.height = 3

    self.dead = false
end

function PlayerBullet:Update(dt)
    self.x = self.x + math.cos(degToRad(self.rotation)) * self.moveSpeed
    self.y = self.y + math.sin(degToRad(self.rotation)) * self.moveSpeed

    if self.lifespan <= 0 then
        --die
        self.dead = true
        
    else
        self.lifespan = self.lifespan - dt
    end

    self:clampPosition()
end

function PlayerBullet:clampPosition()
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

function PlayerBullet:Draw()
    love.graphics.circle("fill", self.x, self.y, 2)
end
