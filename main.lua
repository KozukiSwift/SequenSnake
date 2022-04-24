function love.load()
    love.window.setMode(0, 0)
    screenWidht = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()

    love.window.setMode(screenWidht, screenHeight)

    snakeCfg = {}
    snakeCfg.size = 0
    snakeCfg.speed = 600

    if screenWidht > screenHeight then
        snakeCfg.size = screenHeight / 32
        -- dopisać dla else (wysokość większa od szerokości)
    end
    
    -- basic variables
    timer = 0
    moveTimer = 0
    score = 0
    gameState = 0
    prevKeyPressed = 'a'
    gameFont = love.graphics.newFont(20)
    math.randomseed(os.time())

    -- snake & controls
    require('snake')
    require('controls')

    -- borders
    border = {}
    border.left = snakeCfg.size
    border.right = screenWidht - snakeCfg.size -- może być potrzebwa uwzględnienia niepodzielnych przez 30?
    border.top = snakeCfg.size * 2
    border.bottom = screenHeight - snakeCfg.size -- może być potrzebwa uwzględnienia niepodzielnych przez 30?
    
    -- cherry spawning & colors config
    require('cherry')
    require('colors')
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function love.update(dt)
    timer = timer + dt
    moveTimer = moveTimer + dt * snakeCfg.speed / 60
    
    if moveTimer > 1 then
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
    if distanceBetween(snakePos[1].x, snakePos[1].y, cherry.x - cherry.radius, cherry.y - cherry.radius) == 0 then
        cherry.x = math.random(border.left / snakeCfg.size, math.floor(border.right / snakeCfg.size - 1)) * snakeCfg.size + cherry.radius
        cherry.y = math.random(border.top / snakeCfg.size, math.floor(border.bottom / snakeCfg.size - 1)) * snakeCfg.size + cherry.radius
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

    -- boarder + timer etc.:
    love.graphics.setColor(blueDark.r, blueDark.g, blueDark.b)
    love.graphics.setFont(gameFont)
    love.graphics.print('Snake >> Score:  ' .. score .. ' >> Timer: ' .. math.ceil(timer), 20, 8)
    love.graphics.setColor(yellowDark.r, yellowDark.g, yellowDark.b)
    love.graphics.rectangle('fill', 0, 0, border.left, screenHeight)
    love.graphics.rectangle('fill', border.right, 0, snakeCfg.size, screenHeight)
    love.graphics.rectangle('fill', 0, border.top, screenWidht, snakeCfg.size)
    love.graphics.rectangle('fill', 0, border.bottom, screenWidht, snakeCfg.size)

    -- debug
    love.graphics.print('Debug measured width: ' .. screenWidht, 50, 320)
    love.graphics.print('Debug width: ' .. love.graphics.getWidth(), 50, 350)
    love.graphics.print('Debug hegight: ' .. love.graphics.getHeight(), 50, 380)
    love.graphics.print('Debug border right: ' .. border.right, 50, 410)
    love.graphics.print('Debug border left: ' .. border.left, 50, 440)
    love.graphics.print('Debug snake size: ' .. snakeCfg.size, 50, 470)
    love.graphics.print('Debug snake head X: ' .. snakePos[1].x, 50, 500)
    love.graphics.print('Debug snake head Y: ' .. snakePos[1].y, 50, 530)
    love.graphics.print('Debug cherry radius: ' .. cherry.radius, 50, 560)
    
    -- start
    if gameState == 0 then
        love.graphics.setColor(redDark.r, redDark.g, redDark.b)
        love.graphics.printf('>> WELCOME TO SNAKE <<', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
        love.graphics.printf('>> PRESS SPACE BAR TO START <<', 0, love.graphics.getHeight() / 2 + 40, love.graphics.getWidth(), 'center')
    end

    -- snake    
    if gameState == 1 then
        love.graphics.setColor(redDark.r, redDark.g, redDark.b)
        love.graphics.circle('fill', cherry.x, cherry.y, cherry.radius)
        love.graphics.setColor(blueDark.r, blueDark.g, blueDark.b)
        for i, s in ipairs(snakePos) do
            love.graphics.rectangle('fill', s.x, s.y, snakeCfg.size, snakeCfg.size)
        end
    end

    -- game over
    if gameState == 2 then
        love.graphics.setColor(redDark.r, redDark.g, redDark.b)
        love.graphics.printf('>> GAME OVER <<', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
        love.graphics.printf('>> HELL YEAH <<', 0, love.graphics.getHeight() / 2 + 40, love.graphics.getWidth(), 'center')
    end
end