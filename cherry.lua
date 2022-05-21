cherry = {}
cherry.x = 0
cherry.y = 0

function spawnCherry(size)
    cherry.x = math.random(border.left / size, math.floor(border.right / size - 1)) * size
    cherry.y = math.random(border.top / size, math.floor(border.bottom / size - 1)) * size
end

