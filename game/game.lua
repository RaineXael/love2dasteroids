--game loop
function GameInitialize()

	require("game/player")
	require("game/asteroid")
	player = Player(resolution.x/2, resolution.y/2)
    score = 0
	asteroids = {} --table of asteroids
	
	table.insert(asteroids, Asteroid(randomPosition().x,randomPosition().y,15,15,15,3))
	table.insert(asteroids, Asteroid(randomPosition().x,randomPosition().y,15,15,15,3))
	table.insert(asteroids, Asteroid(randomPosition().x,randomPosition().y,15,15,15,3))
	table.insert(asteroids, Asteroid(randomPosition().x,randomPosition().y,15,15,15,3))
	table.insert(asteroids, Asteroid(randomPosition().x,randomPosition().y,15,15,15,3))
	table.insert(asteroids, Asteroid(randomPosition().x,randomPosition().y,15,15,15,3))
	table.insert(asteroids, Asteroid(randomPosition().x,randomPosition().y,15,15,15,3))
	table.insert(asteroids, Asteroid(randomPosition().x,randomPosition().y,15,15,15,3))
	table.insert(asteroids, Asteroid(randomPosition().x,randomPosition().y,15,15,15,3))
	
end

function randomPosition()
	randomVector = {
        x = love.math.random(resolution.x),
        y = love.math.random(resolution.y)
    }

	return randomVector
end

function GameUpdate(dt)

	player:Update(dt)
   
	for i in pairs(asteroids) do
		if asteroids[i].dead == true then
			table.remove(asteroids, i)
		else
			asteroids[i]:Update(dt)
		end
		
	end

end

function getDistanceBetween(object1, object2)

	return math.sqrt(math.pow(object1.x - object2.x,2) + math.pow(object1.y - object2.y, 2))
	
end


function Gamekeypressed(key)
		
	player:OnKeyPress(key)

end

function GameDraw()
	
	player:Draw()
	for i in pairs(asteroids) do
		asteroids[i]:Draw()
	end
end
