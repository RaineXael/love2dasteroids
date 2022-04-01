--game loop
function GameInitialize()

	require("game/player")
	player = Player(resolution.x/2, resolution.y/2)
    score = 0

	
end


function GameUpdate(dt)

	player:Update(dt)
   


end

function Gamekeypressed(key)
		
	player:OnKeyPress(key)

end

function GameDraw()
	
	player:Draw()

end
