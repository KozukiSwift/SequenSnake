function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function love.keypressed(key)
    if key == 'a' and game.prevKeyPressed ~= 'd' then
        snake:setDirection(-cfg.size, 0)
        game.prevKeyPressed = 'a'
    elseif key == 'd' and game.prevKeyPressed ~= 'a' then
        snake:setDirection(cfg.size, 0)
        game.prevKeyPressed = 'd'
    elseif key == 'w' and game.prevKeyPressed ~= 's' then
        snake:setDirection(0, -cfg.size)
        game.prevKeyPressed = 'w'
    elseif key == 's' and game.prevKeyPressed ~= 'w' then
        snake:setDirection(0, cfg.size)
        game.prevKeyPressed = 's'
    elseif key == 'escape' then
        love.event.quit()
    elseif key == 'space' and (game.state == 0) then
        game.state = 1
    end
end

function playGame(dt)
    game.timer = game.timer + dt
    game.moveTimer = game.moveTimer + dt * cfg.speed / 60
    
    if game.moveTimer > 1 and game.state == 1 then
        if snake.justAte == false then
            snake:move(snake.position)
            game.moveTimer = 0
        elseif snake.justAte == true then
            local snakePart = {}
            snakePart.x = snake.position[#snake.position].x
            snakePart.y = snake.position[#snake.position].y 

            snake:move(snake.position)
            
            table.insert(snake.position, snakePart)

            game.moveTimer = 0
            snake.justAte = false
        end
    end

    -- checking if snake ate the cherry (+ spawning new cherry)
    if distanceBetween(snake.position[1].x, snake.position[1].y, cherry.x, cherry.y) < cfg.size / 2 then
        cherry:spawn(cfg.size, cfg.border.left, cfg.border.right, cfg.border.top, cfg.border.bottom)
        game.score = game.score + 1
        snake.justAte = true
    end

    -- checking if snake hit the boarder
    snake:checkBorderHit(cfg.size, cfg.border)
end