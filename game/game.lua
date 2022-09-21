--game loop
function GameInitialize()

	require("game/player")
	require("game/asteroid")

	player = Player(resolution.x/2, resolution.y/2)
    score = 0
	asteroids = {} --table of asteroids
	
	enemyDistance = 8

	currentAsteroidCount = 1;
	spawnAsteroidWave(currentAsteroidCount)
	
	scorePadding = { --padding for score display
		x = 3,
		y = 3
	}

	bgm = love.audio.newSource("game/sound/music/bgm.wav", "static")
	
    bgm:setLooping(true)
    bgm:play()

	gameOver = false;
	displayHighScore = false;
	thisHighScore = tonumber(getHighScore())
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
		table.insert(asteroids, Asteroid(15,3,5))	
	end	
end


function getDistanceBetween(object1, object2)

	return math.sqrt(math.pow(object1.x - object2.x,2) + math.pow(object1.y - object2.y, 2))
	
end

function checkAsteroidCollision()
	--returns t/f if player touching any asteroid

	for i in pairs(asteroids) do
		if getDistanceBetween(asteroids[i], player) < asteroids[i].size and not asteroids[i].dead then
			--print("Player collide!")
			--kill player
			--player:onHit()
			return true
		end
	end
	return false
end


function Gamekeypressed(key)
	player:OnKeyPress(key)

	--switch to main menu after death and click z or j (change to
	--name input screen instead of instant boot)
	if gameOver and (key == 'z' or key == 'j') then
		switchGameState("mainmenu", true)
	end
end

function GameDraw()

	
	player:Draw()
	for i in pairs(asteroids) do
		asteroids[i]:Draw()
	end

	--enemy:draw()


	love.graphics.print("SCORE:",camera.x + scorePadding.x, camera.y + scorePadding.y)
	love.graphics.printf(score,camera.x + scorePadding.x, camera.y + font:getHeight() + 2 + scorePadding.y, math.floor(resolution.x/6), "right")
	
	love.graphics.printf("LIVES:",camera.x - scorePadding.x, camera.y + scorePadding.y, math.floor(resolution.x), "right")
	love.graphics.printf(player.lives,camera.x - scorePadding.x, camera.y + font:getHeight() + 2 + scorePadding.y, math.floor(resolution.x), "right")
	if gameOver then
		love.graphics.setColor(1,0,0,1)
		love.graphics.printf("DEAD",camera.x, resolution.y/2, math.floor(resolution.x), "center")
		love.graphics.setColor(1,1,1,1)

		if displayHighScore then
			love.graphics.printf("But you got a HIGH SCORE of:",camera.x, (resolution.y/2) + 16, math.floor(resolution.x), "center")
			love.graphics.printf(score,camera.x, (resolution.y/2) + 16+12, math.floor(resolution.x), "center")	
		else
			love.graphics.printf("HIGH SCORE:",camera.x, (resolution.y/2) + 16, math.floor(resolution.x), "center")
			love.graphics.printf(thisHighScore,camera.x, (resolution.y/2) + 16+12, math.floor(resolution.x), "center")	
		end
	end
end

function gameOverState()
	--gameover state, show highscore and highscore entry screen
	gameOver = true
	if score >= thisHighScore then
		print("High score! Your score of ", score, " is above the hs of ", thisHighScore)
		setHighScore(score)
		displayHighScore = true
	end
end
