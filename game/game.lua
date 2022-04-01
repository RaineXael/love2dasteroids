--game loop
function GameInitialize()

	require("game/player")
	require("game/asteroid")
	player = Player(resolution.x/2, resolution.y/2)
    score = 0
	asteroid = Asteroid(70,70,0,0,100,1)
	
end


function GameUpdate(dt)

	player:Update(dt)
   


end

function Gamekeypressed(key)
		
	player:OnKeyPress(key)

end

function GameDraw()
	
	player:Draw()
	asteroid:Draw()
end
