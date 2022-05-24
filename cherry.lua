local cherry = {}
cherry.x = 0
cherry.y = 0

function cherry:spawn(size, borderLeft, borderRight, borderTop, borderBottom)
    self.x = math.random(borderLeft / size, math.floor(borderRight / size - 1)) * size
    self.y = math.random(borderTop / size, math.floor(borderBottom / size - 1)) * size
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function drawCherry()
    love.graphics.setColor(colors.redDark.r, colors.redDark.g, colors.redDark.b)
    love.graphics.rectangle('fill', cherry.x, cherry.y, cfg.size, cfg.size)
end

return cherry