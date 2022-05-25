local snake = {}
snake.justAte = false

snake.direction = {}
snake.direction.x = 0
snake.direction.y = 0

snake.position = {}

function snake:spawn(size, borderLeft, borderTop)
    for i=1, 3, 1 do
        local snakePart = {}
        snakePart.x = borderLeft + (5 + i) * size
        snakePart.y = borderTop + 5 * size
        table.insert(self.position, snakePart)
    end
end

function snake:move()
    for i = #self.position, 1, -1 do
        if i > 1 then
            self.position[i].x = self.position[i-1].x
            self.position[i].y = self.position[i-1].y
        else
            self.position[1].x = self.position[1].x + snake.direction.x
            self.position[1].y = self.position[1].y + snake.direction.y
        end
    end  
end

function snakeSetDirection(x, y)
    snake.direction.x = x
    snake.direction.y = y
end

function checkBorderHit()
    if snake.position[1].x == (cfg.border.left - cfg.size) or 
            snake.position[1].x == cfg.border.right or 
            snake.position[1].y == (cfg.border.top - cfg.size) or 
            snake.position[1].y == cfg.border.bottom then
        game.state = 2
    end
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

function drawSnake()
    love.graphics.setColor(colors.blueDark.r, colors.blueDark.g, colors.blueDark.b)
    for i, s in ipairs(snake.position) do
        love.graphics.rectangle('fill', s.x, s.y, cfg.size, cfg.size)
    end
end

return snake