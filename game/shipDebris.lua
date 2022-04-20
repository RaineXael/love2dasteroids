--Decorational particle object summoned when player dies, spins around in space.

ShipDebris = Object:extend()

function ShipDebris:new(x,y)

	self.x = x
	self.y = y
	
	self.baseRotation = degToRad(love.math.random(720)-360)
	self.currentRotation = self.baseRotation
	self.rotationSpeed = degToRad(love.math.random(30)-15)
	self.moveSpeed = love.math.random(7)+3
	
	self.sprite = love.graphics.newImage("game/sprites/shipDebris.png")
end

function ShipDebris:Update(dt)
		self.x = self.x + (math.cos(degToRad(self.baseRotation)) * self.moveSpeed * dt)
		self.y = self.y + (math.sin(degToRad(self.baseRotation)) * self.moveSpeed * dt)
		
		self.currentRotation = self.currentRotation + self.rotationSpeed
end



function ShipDebris:Draw()
	love.graphics.draw(self.sprite,self.x,self.y,self.currentRotation - degToRad(90), 0.15, 0.15, 32, 32)

end