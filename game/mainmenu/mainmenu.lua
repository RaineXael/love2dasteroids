--contains main menu loop

function mainMenustart()
    mainMenuIndex = 0

    require("game/mainmenu/menuButton")

    titleImage = love.graphics.newImage("game/sprites/menu/logo.png")

    menuButtonGroup = {
        buttonObjects = {
            MenuButton(resolution.x/2, 0, "New Game"),
            MenuButton(resolution.x/2, 0, "High Scores"),
            MenuButton(resolution.x/2, 0, "Settings"),
            MenuButton(resolution.x/2, 0, "Credits"),
            MenuButton(resolution.x/2, 0, "Quit"),
        }, 

        globalY = resolution.y/3

    }

    menuMoveSFX = love.audio.newSource("sounds/menu/move.wav", "static")
end

function mainMenuUpdate(dt)

    for i in pairs(menuButtonGroup.buttonObjects) do 
        if i - 1 == mainMenuIndex then --minus one for weird array thing
            menuButtonGroup.buttonObjects[i].onCursor = true
        else
            menuButtonGroup.buttonObjects[i].onCursor = false
        end
    end
end

function mainMenuDraw()

	love.graphics.draw(titleImage,math.floor(camera.x + (resolution.x/2) - 32), camera.y + 20)

    for i in pairs(menuButtonGroup.buttonObjects) do 
        menuButtonGroup.buttonObjects[i]:draw(-5 + camera.x, menuButtonGroup.globalY + (i * 20) + camera.y)
    end

    
end

function mainMenukeypressed(key)

    if (key == "w" or key == "up") and mainMenuIndex > 0 then
        love.audio.play(menuMoveSFX)
        mainMenuIndex = changeMenuOption(mainMenuIndex, -1)
    end

    if (key == "s" or key == "down") and mainMenuIndex < 4 then
        mainMenuIndex = changeMenuOption(mainMenuIndex, 1)
        love.audio.play(menuMoveSFX)
    end

    if key == "z" or key == "j" then
        menuSelect()
    end
end

--change menu option function for pause and main menu, called when up or down input made.
function changeMenuOption(currentValue, increment)
    currentValue = currentValue + increment       
    return currentValue
end

--selecting a menu item
function menuSelect()
    if mainMenuIndex == 0 then
        --begin game
       switchGameState("game", true)
    elseif mainMenuIndex == 1 then
        --continue
		switchGameState("game", false)
		--should continue & load save
    elseif mainMenuIndex == 2 then
        --settings
        
    elseif mainMenuIndex == 3 then
        --credits
    else
        --quit
        love.event.quit()
    end

end
