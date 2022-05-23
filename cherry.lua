cherry = {}
cherry.x = 0
cherry.y = 0

function spawnCherry(size, borderLeft, borderRight, borderTop, borderBottom)
    cherry.x = math.random(borderLeft / size, math.floor(borderRight / size - 1)) * size
    cherry.y = math.random(borderTop / size, math.floor(borderBottom / size - 1)) * size
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

