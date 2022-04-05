--game loop
function GameInitialize()

	require("game/player")
	require("game/asteroid")
	player = Player(resolution.x/2, resolution.y/2)
    score = 0
	asteroids = {} --table of asteroids
	
	table.insert(asteroids, Asteroid(15,15,15,15,15,3))
	table.insert(asteroids, Asteroid(100,100,15,15,15,2))
	
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

function detectCollision(obj1, obj2)

end

function Gamekeypressed(key)
		
	player:OnKeyPress(key)

	--debug
	for i in pairs(asteroids) do
		asteroids[i]:OnKeyPress(key)
	end


end

function GameDraw()
	
	player:Draw()
	for i in pairs(asteroids) do
		asteroids[i]:Draw()
	end
end
