function love.load()    
    cfg = require('config/config')
    snake = require('objects/snake')
    cherry = require('objects/cherry')
    colors = require('config/colors')
    game = require('game/gameVariables')
    require('game/gameFunctions')
    require('menu/debugger')
    require('menu/menu')

    -- spawning initial cherry / snake / snake direction
    -- powinno zostać przeniesione do miejsca, gdzie gra się rozpoczyna
    cherry:spawn(cfg.size, cfg.border.left, cfg.border.right, cfg.border.top, cfg.border.bottom)
    snake:setDirection(cfg.size, 0)
    snake:spawn(cfg.size, cfg.border.left, cfg.border.top)
end

function love.update(dt)
    playGame(dt)
end

function love.draw()
    drawBoarder()
    debug()
    
    if game.state == 0 then
        drawStartMenu()  
    elseif game.state == 1 then
        cherry:draw(cfg.size, colors.redDark.r, colors.redDark.g, colors.redDark.b)
        snake:draw(cfg.size, colors.blueDark.r, colors.blueDark.g, colors.blueDark.b)
    elseif game.state == 2 then
        drawGameOverMenu()
    end
end