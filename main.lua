function love.load()    
    cfg = require('config')

    snakePos = {}
    for i=1, 3, 1 do
        local snakePart = {}
        snakePart.x = cfg.border.left + (5 + i) * cfg.size
        snakePart.y = cfg.border.top + 5 * cfg.size
        table.insert(snakePos, snakePart)
    end

    -- loading files
    snake = require('snake')
    colors = require('colors')
    game = require('game')
    require('cherry')
    require('debugger')

    -- spawning initial cherry / snake direction
    -- powinno zostać przeniesione do miejsca, gdzie gra się rozpoczyna
    spawnCherry(cfg.size, cfg.border.left, cfg.border.right, cfg.border.top, cfg.border.bottom)
    snakeSetDirection(cfg.size, 0)
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function love.update(dt)
    game.timer = game.timer + dt
    game.moveTimer = game.moveTimer + dt * cfg.speed / 60
    
    if game.moveTimer > 1 and game.state == 1 then
        if snake.justAte == false then
            snakeMove(snakePos)
            game.moveTimer = 0
        elseif snake.justAte == true then
            local snakePart = {}
            snakePart.x = snakePos[#snakePos].x
            snakePart.y = snakePos[#snakePos].y 

            snakeMove(snakePos)
            
            table.insert(snakePos, snakePart)

            game.moveTimer = 0
            snake.justAte = false
        end
    end

    -- checking if snake ate the cherry (+ spawning new cherry)
    if distanceBetween(snakePos[1].x, snakePos[1].y, cherry.x, cherry.y) < cfg.size / 2 then
        spawnCherry(cfg.size, cfg.border.left, cfg.border.right, cfg.border.top, cfg.border.bottom)
        game.score = game.score + 1
        snake.justAte = true
    end

    -- checking if snake hit the boarder
    if snakePos[1].x == (cfg.border.left - cfg.size) or 
                    snakePos[1].x == cfg.border.right or 
                    snakePos[1].y == (cfg.border.top - cfg.size) or 
                    snakePos[1].y == cfg.border.bottom then
        game.state = 2
    end

end

function love.draw()
    love.graphics.setBackgroundColor(colors.yellowLight.r, colors.yellowLight.g, colors.yellowLight.b)

    -- boarder
    love.graphics.setColor(colors.yellowDark.r, colors.yellowDark.g, colors.yellowDark.b)
    love.graphics.rectangle('fill', cfg.border.left - cfg.size, 0, cfg.size, cfg.screenHeight)
    love.graphics.rectangle('fill', cfg.border.right, 0, cfg.size, cfg.screenHeight)
    love.graphics.rectangle('fill', cfg.border.left, cfg.border.top - cfg.size, cfg.size * 40, cfg.size)
    love.graphics.rectangle('fill', cfg.border.left, cfg.border.bottom, cfg.size * 40, cfg.size)

    -- debug
    debug()
    
    -- start
    if game.state == 0 then
        love.graphics.setFont(cfg.gameFont)
        love.graphics.setColor(colors.redDark.r, colors.redDark.g, colors.redDark.b)
        love.graphics.printf('>> WELCOME TO SNAKE <<', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
        love.graphics.printf('>> PRESS SPACE BAR TO START <<', 0, love.graphics.getHeight() / 2 + 40, love.graphics.getWidth(), 'center')
    end

    -- play    
    if game.state == 1 then
        love.graphics.setColor(colors.redDark.r, colors.redDark.g, colors.redDark.b)
        --love.graphics.circle('fill', cherry.x, cherry.y, cherry.radius)
        love.graphics.rectangle('fill', cherry.x, cherry.y, cfg.size, cfg.size)
        love.graphics.setColor(colors.blueDark.r, colors.blueDark.g, colors.blueDark.b)
        for i, s in ipairs(snakePos) do
            love.graphics.rectangle('fill', s.x, s.y, cfg.size, cfg.size)
        end
    end

    -- game over
    if game.state == 2 then
        love.graphics.setFont(cfg.gameFont)
        love.graphics.setColor(colors.redDark.r, colors.redDark.g, colors.redDark.b)
        love.graphics.printf('>> GAME OVER <<', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
        love.graphics.printf('>> HELL YEAH <<', 0, love.graphics.getHeight() / 2 + 40, love.graphics.getWidth(), 'center')
    end
end