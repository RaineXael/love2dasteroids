--Decorational particle object summoned when player dies, spins around in space.

ShipDebris = Object:extend()

function ShipDebris:new(x,y, lifetime)

	self.lifetime = lifetime
	self.x = x
	self.y = y
	
	self.baseRotation = (love.math.random(628)/100)-3.14
	self.currentRotation = self.baseRotation
	self.rotationSpeed = degToRad(love.math.random(30)-15)
	self.moveSpeed = love.math.random(15)+9

	self.lifetime = lifetime
	self.dead = false
	
	self.sprite = love.graphics.newImage("game/sprites/shipDebris.png")
end

function ShipDebris:Update(dt)
		self.x = self.x + (math.cos(self.baseRotation) * self.moveSpeed * dt)
		self.y = self.y + (math.sin(self.baseRotation) * self.moveSpeed * dt)
		--print(math.cos(degToRad(self.baseRotation))* self.moveSpeed)
		
		self.currentRotation = self.currentRotation + self.rotationSpeed
		self.lifetime = self.lifetime - dt
		if self.lifetime <= 0 then
			self.dead = true
		end

end


function ShipDebris:Draw()
	love.graphics.draw(self.sprite,self.x,self.y,self.currentRotation - degToRad(90), 0.15, 0.15, 32, 32)
end