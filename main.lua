function love.load()    
    cfg = require('config')
    snake = require('snake')
    colors = require('colors')
    game = require('game')
    require('cherry')
    require('debugger')
    require('menu')

    -- spawning initial cherry / snake / snake direction
    -- powinno zostać przeniesione do miejsca, gdzie gra się rozpoczyna
    cherry:spawn(cfg.size, cfg.border.left, cfg.border.right, cfg.border.top, cfg.border.bottom)
    snakeSetDirection(cfg.size, 0)
    spawnSnake(cfg.size, cfg.border.left, cfg.border.top)
end

function love.update(dt)
    game.timer = game.timer + dt
    game.moveTimer = game.moveTimer + dt * cfg.speed / 60
    
    if game.moveTimer > 1 and game.state == 1 then
        if snake.justAte == false then
            snakeMove(snake.position)
            game.moveTimer = 0
        elseif snake.justAte == true then
            local snakePart = {}
            snakePart.x = snake.position[#snake.position].x
            snakePart.y = snake.position[#snake.position].y 

            snakeMove(snake.position)
            
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
    checkBorderHit()
end

function love.draw()
    drawBoarder()
    debug()
    
    if game.state == 0 then
        drawStartMenu()  
    elseif game.state == 1 then
        drawCherry()
        drawSnake()
    elseif game.state == 2 then
        drawGameOverMenu()
    end
end