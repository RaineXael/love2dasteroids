function love.load()

	--init video settings
	love.graphics.setDefaultFilter("nearest","nearest",1)
	font = love.graphics.newFont("prstart.ttf",8)

	love.graphics.setFont(font)
	
	resolution = {
		x = 256,
		y = 192

	}

	camera = {
		x = 0,
		y = 0
	}
	
	switchScale(1)

	Object = require "classic"
	
	require("game/game")
	require("game/mainmenu/mainmenu")
	

	gameState = "mainmenu"
	switchGameState(gameState, true)
	
	escapeTimer = 0 --timer used to make the game quit after holding escape
	escapeScale = 0.75 --scale of timer speed for above
end

function love.update(dt)
	if gameState == "game" then
		GameUpdate(dt)
	elseif gameState == "mainmenu" then
		mainMenuUpdate(dt)
	end
	
	--hold escape to quit
	if love.keyboard.isDown("escape") then
		escapeTimer = escapeTimer + dt * escapeScale
	elseif escapeTimer > 0 then
		escapeTimer = escapeTimer - dt * escapeScale
	end
	
	if escapeTimer >= 1.5 then
		love.event.quit()
	end
	
end


function love.keypressed(key)
	if gameState == "game" then
		Gamekeypressed(key)
	elseif gameState == "mainmenu" then
		mainMenukeypressed(key)
	end

	
	--keys that work everywhere
	if(key == "f1") then
		switchScale(1)
	end

	if(key == "f2") then
		switchScale(2)
	end

	if(key == "f3") then
		switchScale(3)
	end

end	

function love.draw()
	
	love.graphics.scale(windowScale,windowScale) --first line
	love.graphics.translate(math.floor(-camera.x),math.floor(-camera.y))

	--print game here
	if gameState == "game" then
		GameDraw()	
	elseif gameState == "mainmenu" then
		mainMenuDraw()
	end

	--love.graphics.print(love.timer.getFPS(),camera.x, camera.y)	
	love.graphics.setColor(1,1,1,escapeTimer)
	love.graphics.print("Quitting...", camera.x, resolution.y - font:getHeight())
	love.graphics.setColor(1,1,1,1)
end


function switchScale(value)

	windowScale = value
	love.window.setMode( resolution.x * windowScale, resolution.y * windowScale, {resizable=true})
end

function switchGameState(state, reset)
	
	if state == "mainmenu" then
	--start mainmenu
		if reset then
			mainMenustart()
		else
		
		end
		gameState="mainmenu"
	elseif state == "game" then
	--start game
		if reset then
			GameInitialize()
		else
		
		end
		gameState="game"
	end
end

function degToRad(angle)
return angle * (math.pi / 180)
end
