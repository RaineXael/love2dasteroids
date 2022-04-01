Asteroid = Object:extend()

function Asteroid:new(x,y,angle,speed,scoreWorth, destroyedLevel)
    self.x = x
    self.y = y

    self.speed = speed
    self.angle = angle

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
    end
end

function Asteroid:Update(dt)
--float somewhere
end

function Asteroid:Draw()
    love.graphics.circle("fill", self.x, self.y, self.size)
end