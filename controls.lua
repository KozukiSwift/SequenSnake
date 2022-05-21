function love.keypressed(key)
    if key == 'a' and prevKeyPressed ~= 'd' then
        snakeDirection.x = -cfg.size
        snakeDirection.y = 0
        prevKeyPressed = 'a'
    elseif key == 'd' and prevKeyPressed ~= 'a' then
        snakeDirection.x = cfg.size
        snakeDirection.y = 0
        prevKeyPressed = 'd'
    elseif key == 'w' and prevKeyPressed ~= 's' then
        snakeDirection.x = 0
        snakeDirection.y = -cfg.size
        prevKeyPressed = 'w'
    elseif key == 's' and prevKeyPressed ~= 'w' then
        snakeDirection.x = 0
        snakeDirection.y = cfg.size
        prevKeyPressed = 's'
    elseif key == 'escape' then
        love.event.quit()
    elseif key == 'space' and (gameState == 0) then
        gameState = 1
    end
end