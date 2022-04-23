function love.load()
    love.window.setMode(1260, 990)
    
    -- basic variables
    timer = 0
    moveTimer = 0
    score = 0
    gameState = 0
    prevKeyPressed = 'a'
    snakeJustAte = false
    gameFont = love.graphics.newFont(20)
    math.randomseed(os.time())

    snakeCfg = {}
    snakeCfg.size = 30
    snakeCfg.speed = 600

    -- borders
    border = {}
    border.left = snakeCfg.size
    border.right = love.graphics.getWidth() - snakeCfg.size -- może być potrzebwa uwzględnienia niepodzielnych przez 30?
    border.top = snakeCfg.size * 2
    border.bottom = love.graphics.getHeight() - snakeCfg.size -- może być potrzebwa uwzględnienia niepodzielnych przez 30?
    
    cherry = {}
    cherry.radius = snakeCfg.size / 2
    cherry.x = math.random(border.left / snakeCfg.size, math.floor(border.right / snakeCfg.size - 1)) * snakeCfg.size + cherry.radius -- zmienić na funkcjęl
    cherry.y = math.random(border.top / snakeCfg.size, math.floor(border.bottom / snakeCfg.size - 1)) * snakeCfg.size + cherry.radius

    snakePos = {}
    for i=1, 3, 1 do
        local snakePart = {}
        snakePart.x = 300 + i * snakeCfg.size
        snakePart.y = 300
        table.insert(snakePos, snakePart)
    end

    snakeDirection = {}
    snakeDirection.x = snakeCfg.size
    snakeDirection.y = 0

    -- colors
    yellowLight = {}
    yellowLight.r = 255/255
    yellowLight.g = 255/255
    yellowLight.b = 191/255

    yellowDark = {}
    yellowDark.r = 255/255
    yellowDark.g = 255/255
    yellowDark.b = 191/255

    yellowDark = {}
    yellowDark.r = 255/255
    yellowDark.g = 233/255
    yellowDark.b = 113/255

    redDark = {}
    redDark.r = 208/255
    redDark.g = 79/255
    redDark.b = 50/255

    blueDark ={}
    blueDark.r = 24/255
    blueDark.g = 74/255
    blueDark.b = 146/255
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end


function snakeMove()
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
        snakeDirection.x = -snakeCfg.size
        snakeDirection.y = 0
        prevKeyPressed = 'a'
    elseif key == 'd' and prevKeyPressed ~= 'a' then
        snakeDirection.x = snakeCfg.size
        snakeDirection.y = 0
        prevKeyPressed = 'd'
    elseif key == 'w' and prevKeyPressed ~= 's' then
        snakeDirection.x = 0
        snakeDirection.y = -snakeCfg.size
        prevKeyPressed = 'w'
    elseif key == 's' and prevKeyPressed ~= 'w' then
        snakeDirection.x = 0
        snakeDirection.y = snakeCfg.size
        prevKeyPressed = 's'
    elseif key == 'escape' then
        love.event.quit()
    elseif key == 'space' and (gameState == 0) then
        gameState = 1
    end
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
    love.graphics.rectangle('fill', 0, 0, snakeCfg.size, love.graphics.getHeight()) -- naprawić wymiary
    love.graphics.rectangle('fill', love.graphics.getWidth() - snakeCfg.size, 0, snakeCfg.size, love.graphics.getHeight())
    love.graphics.rectangle('fill', 0, snakeCfg.size, love.graphics.getWidth(), snakeCfg.size)
    love.graphics.rectangle('fill', 0, love.graphics.getHeight() - 10, love.graphics.getWidth(), 10)
    
    -- start
    if gameState == 0 then
        love.graphics.setColor(redDark.r, redDark.g, redDark.b)
        love.graphics.printf('>> WELCOME TO SNAKE <<', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
        love.graphics.printf('>> PRESS SPACE BAR TO START <<', 0, love.graphics.getHeight() / 2 + 30, love.graphics.getWidth(), 'center')
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
        love.graphics.printf('>> HELL YEAH <<', 0, love.graphics.getHeight() / 2 + 30, love.graphics.getWidth(), 'center')
    end
end