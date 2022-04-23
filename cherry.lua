cherry = {}
cherry.radius = snakeCfg.size / 2
cherry.x = math.random(border.left / snakeCfg.size, math.floor(border.right / snakeCfg.size - 1)) * snakeCfg.size + cherry.radius -- zmienić na funkcjęl
cherry.y = math.random(border.top / snakeCfg.size, math.floor(border.bottom / snakeCfg.size - 1)) * snakeCfg.size + cherry.radius

