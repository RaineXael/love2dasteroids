MenuButton = Object:extend()

function MenuButton:new(x, y, message)

	self.x = x
	self.y = y
	self.message = message

	
	self.onCursor = false
	self.cursorSprite = love.graphics.newImage("game/sprites/menu/cursor.png")

end

function MenuButton:draw(xOffset, yOffset)
	love.graphics.print(self.message, math.floor(resolution.x - font:getWidth(self.message) + xOffset), math.floor(self.y+ yOffset))
	
	if self.onCursor then
	--replace 16 by cursorwidth and animate cursor somehow maybe sine
	love.graphics.draw(self.cursorSprite, math.floor(resolution.x - (25 + font:getWidth(self.message)) + xOffset), math.floor(self.y + yOffset))
	end
end
