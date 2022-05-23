local snake = {}
snake.justAte = false

snake.direction = {}
snake.direction.x = 0
snake.direction.y = 0

snake.position = {}
for i=1, 3, 1 do
    local snakePart = {}
    snakePart.x = cfg.border.left + (5 + i) * cfg.size
    snakePart.y = cfg.border.top + 5 * cfg.size
    table.insert(snake.position, snakePart)
end

function snakeMove(argTable)
    local snakePos = argTable
    for i = #snakePos, 1, -1 do
        if i > 1 then
            snakePos[i].x = snakePos[i-1].x
            snakePos[i].y = snakePos[i-1].y
        else
            snakePos[1].x = snakePos[1].x + snake.direction.x
            snakePos[1].y = snakePos[1].y + snake.direction.y
        end
    end  
end

function snakeSetDirection(x, y)
    snake.direction.x = x
    snake.direction.y = y
end

function love.keypressed(key)
    if key == 'a' and game.prevKeyPressed ~= 'd' then
        snakeSetDirection(-cfg.size, 0)
        game.prevKeyPressed = 'a'
    elseif key == 'd' and game.prevKeyPressed ~= 'a' then
        snakeSetDirection(cfg.size, 0)
        game.prevKeyPressed = 'd'
    elseif key == 'w' and game.prevKeyPressed ~= 's' then
        snakeSetDirection(0, -cfg.size)
        game.prevKeyPressed = 'w'
    elseif key == 's' and game.prevKeyPressed ~= 'w' then
        snakeSetDirection(0, cfg.size)
        game.prevKeyPressed = 's'
    elseif key == 'escape' then
        love.event.quit()
    elseif key == 'space' and (game.state == 0) then
        game.state = 1
    end
end

return snake