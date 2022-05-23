debugFont = love.graphics.newFont(12)

function debug()
    love.graphics.setColor(colors.redDark.r, colors.redDark.g, colors.redDark.b)
    love.graphics.setFont(debugFont)
    love.graphics.print('Debug measured width: ' .. cfg.screenWidht, 10, 300)
    love.graphics.print('Debug width: ' .. love.graphics.getWidth(), 10, 315)
    love.graphics.print('Debug hegight: ' .. love.graphics.getHeight(), 10, 330)
    love.graphics.print('Debug border right: ' .. cfg.border.right, 10, 345)
    love.graphics.print('Debug border left: ' .. cfg.border.left, 10, 360)
    love.graphics.print('Debug snake size: ' .. cfg.size, 10, 375)
    love.graphics.print('Debug snake head X: ' .. snake.position[1].x, 10, 390)
    love.graphics.print('Debug snake head Y: ' .. snake.position[1].y, 10, 405)
end
