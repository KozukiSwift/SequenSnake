snakeCfg = {}
snakeCfg.size = 30
snakeCfg.speed = 600
snakeJustAte = false

snakePos = {}
for i=1, 3, 1 do
    local snakePart = {}
    snakePart.x = 300 + i * snakeCfg.size
    snakePart.y = 300
    table.insert(snakePos, snakePart)
end

snakeDirection = {}
snakeDirection.x = snakeCfg.size
snakeDirection.y = 0

function snakeMove()
    for i = #snakePos, 1, -1 do
        if i > 1 then
            snakePos[i].x = snakePos[i-1].x
            snakePos[i].y = snakePos[i-1].y
        else
            snakePos[1].x = snakePos[1].x + snakeDirection.x
            snakePos[1].y = snakePos[1].y + snakeDirection.y
        end
    end  
end
