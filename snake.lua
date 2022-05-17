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
