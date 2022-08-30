function setHighScore(input)
    love.filesystem.write("hs", input)
end

function getHighScore()
    --returns high scorevalue
    result, size = love.filesystem.read("hs")
    return result
end