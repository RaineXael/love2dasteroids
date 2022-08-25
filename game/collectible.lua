--object for collectible, gives points to player to encourage them to move around more
Coin = Object:extend();

function Coin:new()
    self.randomizePosition()

    self.sprites = {
        love.graphics.newImage("game/sprites/collectible/1.png"),
        love.graphics.newImage("game/sprites/collectible/2.png"),
        love.graphics.newImage("game/sprites/collectible/3.png"),
        love.graphics.newImage("game/sprites/collectible/4.png"),
        love.graphics.newImage("game/sprites/collectible/5.png"),
        love.graphics.newImage("game/sprites/collectible/6.png"),
        love.graphics.newImage("game/sprites/collectible/7.png"),
    }

    self.spriteIndex = 1

    --self.collectSound = love.audio.newSource("game/sound/where's the goddamn sound.wav", "static")

end

function Coin:randomizePosition()
    self.x = randomPosition().x
    self.y = randomPosition().y
end

function Coin:update()
    --animate and do collision detrection
end

function Coin:draw()
love.graphics.draw(self.sprites[self.spriteIndex], self.x, self.y) --sprite
end 