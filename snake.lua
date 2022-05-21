function snakeMove(argTable)
    local snakePos = argTable
    for i = #snakePos, 1, -1 do
        if i > 1 then
            snakePos[i].x = snakePos[i-1].x
            snakePos[i].y = snakePos[i-1].y
        else
            snakePos[1].x = snakePos[1].x + snakeDirection.x
            snakePos[1].y = snakePos[1].y + snakeDirection.y
        end
    end  
end

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