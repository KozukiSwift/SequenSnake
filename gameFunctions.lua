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