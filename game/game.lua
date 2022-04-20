--game loop
function GameInitialize()

	require("game/player")
	require("game/asteroid")
	require("game/shipDebris")
	player = Player(resolution.x/2, resolution.y/2)
    score = 0
	asteroids = {} --table of asteroids
	
	currentAsteroidCount = 1;
	spawnAsteroidWave(currentAsteroidCount)
	
	scorePadding = { --padding for score display
		x = 3,
		y = 3
	}
	
	sd = ShipDebris(resolution.x/2,resolution.y/2)
	
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
   sd:Update(dt)
	for i in pairs(asteroids) do
		if asteroids[i].dead == true then
			table.remove(asteroids, i)
		else
			asteroids[i]:Update(dt)
		end
		
	end
	
	if love.keyboard.isDown("g") then
		score = score + 1
	end
	
	if asteroids[1] == nil then --detects when there are no more asteroids in play
		print("No more asteroids!!")
		--should spawn another wave of asteroids
		currentAsteroidCount = currentAsteroidCount + 1
		spawnAsteroidWave(currentAsteroidCount)
	end

end

function spawnAsteroidWave(count)
		
	for i=0,count,1 do
		table.insert(asteroids, Asteroid(randomPosition().x,randomPosition().y,15,3,5))	
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
	
	sd:Draw()
	love.graphics.print("SCORE:",camera.x + scorePadding.x, camera.y + scorePadding.y)
	love.graphics.printf(score,camera.x + scorePadding.x, camera.y + font:getHeight() + 2 + scorePadding.y, math.floor(resolution.x/6), "right")
	
	love.graphics.printf("LIVES:",camera.x - scorePadding.x, camera.y + scorePadding.y, math.floor(resolution.x), "right")
	love.graphics.printf(player.lives,camera.x - scorePadding.x, camera.y + font:getHeight() + 2 + scorePadding.y, math.floor(resolution.x), "right")
end
