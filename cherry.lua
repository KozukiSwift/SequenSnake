cherry = {}
cherry.x = 0
cherry.y = 0

function spawnCherry()
    cherry.x = math.random(border.left / snakeCfg.size, math.floor(border.right / snakeCfg.size - 1)) * snakeCfg.size
    cherry.y = math.random(border.top / snakeCfg.size, math.floor(border.bottom / snakeCfg.size - 1)) * snakeCfg.size
end

