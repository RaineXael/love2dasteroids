--object for collectible, gives points to player to encourage them to move around more
Coin = Object:extend();

function Coin:new()
    self.x = 0
    self.y = 0
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
    self.animationSpeed = 0.5
    self.animationTimer = self.animationSpeed


    self.spriteIndex = 1

    --self.collectSound = love.audio.newSource("game/sound/where's the goddamn sound.wav", "static")
    --draw on the screen goddamnit
end

function Coin:randomizePosition()
        randomVector = {
            x = love.math.random(resolution.x),
            y = love.math.random(resolution.y)
        }
    
        return randomVector
end

function Coin:update(dt)
    --animate and do collision detrection
    if self.animationTimer > 0 then
        self.animationTimer = self.animationTimer - dt
    else
        --timer done change sprite
        if spriteIndex < 7 then
            --upshift sprite index
            self.spriteIndex = self.spriteIndex + 1
        else
            --set si to 1
            self.spriteIndex = 1
        end
    end
    
    --collision detection

end

function Coin:draw()
love.graphics.draw(self.sprites[self.spriteIndex], resolution.x/2, resolution.y/2) --sprite
end 