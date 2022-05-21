local config = {}
config.size = 0
config.speed = 600

love.window.setMode(0, 0)
screenWidht = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

love.window.setMode(screenWidht, screenHeight)



return config