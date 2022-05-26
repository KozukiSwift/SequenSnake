math.randomseed(os.time())

local config = {}
config.size = 0
config.speed = 600
config.gameFont = love.graphics.newFont(20)

-- establishing the height and width of the computer screen
love.window.setMode(0, 0)
config.screenWidht = love.graphics.getWidth()
config.screenHeight = love.graphics.getHeight()
love.window.setMode(config.screenWidht, config.screenHeight)

-- setting the size of single block (plying field 40x30 + 1 on each side for boarders)
if config.screenWidht > config.screenHeight then
    config.size = config.screenHeight / 32
    -- dopisać dla else (wysokość większa od szerokości)
end

-- setting boarders
-- wariant dla ułożenia horyzontalnego (desktop)
config.border = {}
config.border.left = (config.screenWidht - 40 * config.size) / 2
config.border.right = config.border.left + 40 * config.size 
config.border.top = config.size
config.border.bottom = config.screenHeight - config.size

return config