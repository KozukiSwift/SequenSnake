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

function cherry:draw(size, r, g, b)
    love.graphics.setColor(r, g, b)
    love.graphics.rectangle('fill', self.x, self.y, size, size)
end

return cherry