--contains settings menu loop

--needed settings
--resolution change
--lives setting
--erase save data
--???

function settingsMenustart()
    mainMenuIndex = 0

    require("game/mainmenu/menuButton")
    menuButtonGroup = {}
    menuButtonGroup = {
        buttonObjects = {
            MenuButton(0, 0, "Resolution"),
            MenuButton(0, 0, "Starting Lives"),
            MenuButton(0, 0, "Erase High Score"),
            MenuButton(0, 0, "Back"),
        }, 

        globalY = resolution.y/2

    }

    menuMoveSFX = love.audio.newSource("sounds/menu/move.wav", "static")
end

function settingsMenuUpdate(dt)

    for i in pairs(menuButtonGroup.buttonObjects) do 
        if i - 1 == mainMenuIndex then --minus one for weird array thing
            menuButtonGroup.buttonObjects[i].onCursor = true
        else
            menuButtonGroup.buttonObjects[i].onCursor = false
        end
    end
end

function settingsMenuDraw()

    for i in pairs(menuButtonGroup.buttonObjects) do 
        menuButtonGroup.buttonObjects[i]:draw(-5 + camera.x, menuButtonGroup.globalY + (i * 20) + camera.y)
    end
    
end

function settingsMenukeypressed(key)

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
       --toggle resolution
    elseif mainMenuIndex == 1 then
        --toggle lives
    elseif mainMenuIndex == 2 then
        --erase savedata
    else
        --go back
        switchGameState("mainmenu", true)
    end

end
