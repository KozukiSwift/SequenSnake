love.graphics.setBackgroundColor(colors.yellowLight.r, colors.yellowLight.g, colors.yellowLight.b)

function drawBoarder()
    love.graphics.setColor(colors.yellowDark.r, colors.yellowDark.g, colors.yellowDark.b)
    love.graphics.rectangle('fill', cfg.border.left - cfg.size, 0, cfg.size, cfg.screenHeight)
    love.graphics.rectangle('fill', cfg.border.right, 0, cfg.size, cfg.screenHeight)
    love.graphics.rectangle('fill', cfg.border.left, cfg.border.top - cfg.size, cfg.size * 40, cfg.size)
    love.graphics.rectangle('fill', cfg.border.left, cfg.border.bottom, cfg.size * 40, cfg.size)
end

function drawStartMenu()
    love.graphics.setFont(cfg.gameFont)
    love.graphics.setColor(colors.redDark.r, colors.redDark.g, colors.redDark.b)
    love.graphics.printf('>> WELCOME TO SNAKE <<', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
    love.graphics.printf('>> PRESS SPACE BAR TO START <<', 0, love.graphics.getHeight() / 2 + 40, love.graphics.getWidth(), 'center')
end

function drawGameOverMenu()
    love.graphics.setFont(cfg.gameFont)
    love.graphics.setColor(colors.redDark.r, colors.redDark.g, colors.redDark.b)
    love.graphics.printf('>> GAME OVER <<', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
    love.graphics.printf('>> HELL YEAH <<', 0, love.graphics.getHeight() / 2 + 40, love.graphics.getWidth(), 'center')
end