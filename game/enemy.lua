--the enemy flies around in a random direction and shoots bullets at you.
Enemy = Object:extend()


function Enemy:new()
    self.x = love.math.random(resolution.x)
    self.y = love.math.random(resolution.y)

    self.sprite = love.graphics.newImage("game/sprites/enemyShip.png")

    self.shootSpeedMin = 0.3
    self.shootSpeedMax = 1.3
    
    self.shootTimer = love.math.random(self.shootSpeedMin*100, self.shootSpeedMax*100)/100


    self.respawnTimeMax = 30
    self.respawnTimer = 0
    self.dead = false
    

end

function Enemy:randomizePosition()

    self.x = love.math.random(resolution.x)
    self.y = love.math.random(resolution.y)
     
end

function Enemy:update(dt)


    if dead then
        if self.respawnTimeMax > 0 then
            --reduce timer
            self.respawnTimeMax = self.respawnTimeMax - dt
        else
            --timer done 
            --set to not dead
            self.dead = false
        end
    else
        if self.shootTimer > 0 then
            --reduce timer
            self.shootTimer = self.shootTimer - dt
        else
            --timer done 
            --spawn bullet (or in this case a small asteroid????)
            --reset timer
            print("enemy should shoot")
            self.shootTimer = love.math.random(self.shootSpeedMin, self.shootSpeedMax)
        end
    end
end

function Enemy:onDeath()
    self.respawnTimer = love.random(self.respawnTimeMax)+ 10 --(rng: 10 to max + 10)
    self.dead = true
end


function Enemy:draw()
    love.graphics.draw(self.sprite, self.x-8, self.y-8) --sprite
end


