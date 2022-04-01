PlayerBullet = Object:extend()

function PlayerBullet:new(x,y, rotation, parentTable)
    self.x = x
    self.y = y
    self.rotation = rotation

    self.moveSpeed = 360

    self.width = 3
    self.height = 3

    self.dead = false
    self.warps = 0 --counts warps to die after a certain # of them
    self.maxWarps = 3
end

function PlayerBullet:Update(dt)
    self.x = self.x + math.cos(degToRad(self.rotation)) * self.moveSpeed * dt
    self.y = self.y + math.sin(degToRad(self.rotation)) * self.moveSpeed * dt

    self:clampPosition()

    if self.warps >= self.maxWarps then
	self.dead = true --mark for death
    end
end


function PlayerBullet:clampPosition()
    	if self.x  + 8 <= 0 then

		self.warps = self.warps + 1
		self.x = resolution.x - 1
		--touch left side of screen
	end
	
	if (self.x + self.width -16 ) > resolution.x then
	--touch right side of screen
		self.x = 17
		self.warps = self.warps + 1
	end
	
	if(self.y +8 < camera.y) then
		self.y = resolution.y - 1
		self.warps = self.warps + 1
	end
	
	if(self.y > ( resolution.y)) then
		self.y = 17
		self.warps = self.warps + 1
	end
end

function PlayerBullet:Draw()
    love.graphics.circle("fill", self.x, self.y, 2)
end
