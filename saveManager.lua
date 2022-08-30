function setHighScore()
    filename = "test"
    local success, message =love.filesystem.write( filename, "")
    if success then 
        print ('file created')
    else 
        print ('file not created: '..message)
    end
end

function getHighScore()
    --returns high scorevalue

end