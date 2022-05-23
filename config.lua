math.randomseed(os.time())

local config = {}
config.size = 0
config.speed = 600
config.gameFont = love.graphics.newFont(20)

love.window.setMode(0, 0)
config.screenWidht = love.graphics.getWidth()
config.screenHeight = love.graphics.getHeight()

love.window.setMode(config.screenWidht, config.screenHeight)

if config.screenWidht > config.screenHeight then
    config.size = config.screenHeight / 32
    -- dopisać dla else (wysokość większa od szerokości)
end

-- borders // wariant dla ekranów szerszych niż wyższych (do poprawy później)
config.border = {}
config.border.left = (config.screenWidht - 40 * config.size) / 2
config.border.right = config.border.left + 40 * config.size 
config.border.top = config.size
config.border.bottom = config.screenHeight - config.size


return config