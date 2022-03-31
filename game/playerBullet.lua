PlayerBullet = Object:extend

function PlayerBullet:new(x,y, rotation)
    self.x = x
    self.y = y
    self.rotation = rotation

    self.moveSpeed = 8
    self.lifespan = 4
end

function PlayerBullet:Update(dt)
    self.x = self.x + math.cos(degToRad(self.rotation))
    self.y = self.y + math.sin(degToRad(self.rotation))

    self.lifespan = self.lifespan - dt

    if self.lifespan <= 0 then
        --die
    end
end
