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
    if key == 'a' and game.prevKeyPressed ~= 'd' then
        snakeDirection.x = -cfg.size
        snakeDirection.y = 0
        game.prevKeyPressed = 'a'
    elseif key == 'd' and game.prevKeyPressed ~= 'a' then
        snakeDirection.x = cfg.size
        snakeDirection.y = 0
        game.prevKeyPressed = 'd'
    elseif key == 'w' and game.prevKeyPressed ~= 's' then
        snakeDirection.x = 0
        snakeDirection.y = -cfg.size
        game.prevKeyPressed = 'w'
    elseif key == 's' and game.prevKeyPressed ~= 'w' then
        snakeDirection.x = 0
        snakeDirection.y = cfg.size
        game.prevKeyPressed = 's'
    elseif key == 'escape' then
        love.event.quit()
    elseif key == 'space' and (game.state == 0) then
        game.state = 1
    end
end

local snake = {}
snake.justAte = false

return snake