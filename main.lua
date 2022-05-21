function love.load()
    require('config')
    fileTest = require('cfgtest')

    snakeCfg = {}
    snakeCfg.size = 0
    snakeCfg.speed = 600

    if screenWidht > screenHeight then
        snakeCfg.size = screenHeight / 32
        -- dopisać dla else (wysokość większa od szerokości)
    end

    -- borders // wariant dla ekranów szerszych niż wyższych (do poprawy później)
    border = {}
    border.left = (screenWidht - 40 * snakeCfg.size) / 2
    border.right = border.left + 40 * snakeCfg.size 
    border.top = snakeCfg.size
    border.bottom = screenHeight - snakeCfg.size

    snakeJustAte = false

    snakePos = {}
    for i=1, 3, 1 do
        local snakePart = {}
        snakePart.x = border.left + (5 + i) * snakeCfg.size
        snakePart.y = border.top + 5 * snakeCfg.size
        table.insert(snakePos, snakePart)
    end

    snakeDirection = {}
    snakeDirection.x = snakeCfg.size
    snakeDirection.y = 0
    
    -- basic variables
    timer = 0
    moveTimer = 0
    score = 0
    gameState = 0
    prevKeyPressed = 'a'
    gameFont = love.graphics.newFont(20)
    debugFont = love.graphics.newFont(12)
    math.randomseed(os.time())

    -- snake & controls
    require('snake')
    require('controls')
    
    -- cherry spawning & colors config
    require('cherry')
    require('colors')

    spawnCherry()
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function love.update(dt)
    timer = timer + dt
    moveTimer = moveTimer + dt * snakeCfg.speed / 60
    
    if moveTimer > 1 and gameState == 1 then
        if snakeJustAte == false then
            snakeMove()
            moveTimer = 0
        elseif snakeJustAte == true then
            local snakePart = {}
            snakePart.x = snakePos[#snakePos].x
            snakePart.y = snakePos[#snakePos].y 

            snakeMove()
            
            table.insert(snakePos, snakePart)

            moveTimer = 0
            snakeJustAte = false
        end
    end

    -- checking if snake ate the cherry (+ spawning new cherry)
    if distanceBetween(snakePos[1].x, snakePos[1].y, cherry.x, cherry.y) < snakeCfg.size / 2 then
        spawnCherry()
        score = score + 1
        snakeJustAte = true
    end

    -- checking if snake hit the boarder
    if snakePos[1].x == (border.left - snakeCfg.size) or 
                    snakePos[1].x == border.right or 
                    snakePos[1].y == (border.top - snakeCfg.size) or 
                    snakePos[1].y == border.bottom then
        gameState = 2
    end

end

function love.draw()
    love.graphics.setBackgroundColor(yellowLight.r, yellowLight.g, yellowLight.b)

    -- boarder
    love.graphics.setColor(yellowDark.r, yellowDark.g, yellowDark.b)
    love.graphics.rectangle('fill', border.left - snakeCfg.size, 0, snakeCfg.size, screenHeight)
    love.graphics.rectangle('fill', border.right, 0, snakeCfg.size, screenHeight)
    love.graphics.rectangle('fill', border.left, border.top - snakeCfg.size, snakeCfg.size * 40, snakeCfg.size)
    love.graphics.rectangle('fill', border.left, border.bottom, snakeCfg.size * 40, snakeCfg.size)

    -- timer / score / etc - TO DO
    --love.graphics.setColor(blueDark.r, blueDark.g, blueDark.b)
    --love.graphics.setFont(gameFont)
    --love.graphics.print('Snake >> Score:  ' .. score .. ' >> Timer: ' .. math.ceil(timer), 20, 8)

    -- debug
    love.graphics.setColor(redDark.r, redDark.g, redDark.b)
    love.graphics.setFont(debugFont)
    love.graphics.print('Debug measured width: ' .. screenWidht, 50, 300)
    love.graphics.print('Debug width: ' .. love.graphics.getWidth(), 50, 315)
    love.graphics.print('Debug hegight: ' .. love.graphics.getHeight(), 50, 330)
    love.graphics.print('Debug border right: ' .. border.right, 50, 345)
    love.graphics.print('Debug border left: ' .. border.left, 50, 360)
    love.graphics.print('Debug snake size: ' .. snakeCfg.size, 50, 375)
    love.graphics.print('Debug snake head X: ' .. snakePos[1].x, 50, 390)
    love.graphics.print('Debug snake head Y: ' .. snakePos[1].y, 50, 405)
    love.graphics.print('Debug file split: ' .. fileTest.x, 50, 420)
    
    -- start
    if gameState == 0 then
        love.graphics.setFont(gameFont)
        love.graphics.setColor(redDark.r, redDark.g, redDark.b)
        love.graphics.printf('>> WELCOME TO SNAKE <<', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
        love.graphics.printf('>> PRESS SPACE BAR TO START <<', 0, love.graphics.getHeight() / 2 + 40, love.graphics.getWidth(), 'center')
    end

    -- play    
    if gameState == 1 then
        love.graphics.setColor(redDark.r, redDark.g, redDark.b)
        --love.graphics.circle('fill', cherry.x, cherry.y, cherry.radius)
        love.graphics.rectangle('fill', cherry.x, cherry.y, snakeCfg.size, snakeCfg.size)
        love.graphics.setColor(blueDark.r, blueDark.g, blueDark.b)
        for i, s in ipairs(snakePos) do
            love.graphics.rectangle('fill', s.x, s.y, snakeCfg.size, snakeCfg.size)
        end
    end

    -- game over
    if gameState == 2 then
        love.graphics.setFont(gameFont)
        love.graphics.setColor(redDark.r, redDark.g, redDark.b)
        love.graphics.printf('>> GAME OVER <<', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
        love.graphics.printf('>> HELL YEAH <<', 0, love.graphics.getHeight() / 2 + 40, love.graphics.getWidth(), 'center')
    end
end