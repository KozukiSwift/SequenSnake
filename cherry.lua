cherry = {}
cherry.x = 0
cherry.y = 0

function spawnCherry(size, borderLeft, borderRight, borderTop, borderBottom)
    cherry.x = math.random(borderLeft / size, math.floor(borderRight / size - 1)) * size
    cherry.y = math.random(borderTop / size, math.floor(borderBottom / size - 1)) * size
end

