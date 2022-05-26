local snake = {}
snake.justAte = false

snake.direction = {}
snake.direction.x = 0
snake.direction.y = 0

snake.position = {}

function snake:spawn(size, borderLeft, borderTop)
    for i=1, 3, 1 do
        local snakePart = {}
        snakePart.x = borderLeft + (5 + i) * size
        snakePart.y = borderTop + 5 * size
        table.insert(self.position, snakePart)
    end
end

function snake:move()
    for i = #self.position, 1, -1 do
        if i > 1 then
            self.position[i].x = self.position[i-1].x
            self.position[i].y = self.position[i-1].y
        else
            self.position[1].x = self.position[1].x + snake.direction.x
            self.position[1].y = self.position[1].y + snake.direction.y
        end
    end  
end

function snake:setDirection(x, y)
    self.direction.x = x
    self.direction.y = y
end

function snake:checkBorderHit(size, border)
    if self.position[1].x == (border.left - size) or 
            self.position[1].x == border.right or 
            self.position[1].y == (border.top - size) or 
            self.position[1].y == border.bottom then
        game.state = 2
    end
end

function snake:draw(size, r, g, b)
    love.graphics.setColor(r, g, b)
    for i, s in ipairs(snake.position) do
        love.graphics.rectangle('fill', s.x, s.y, size, size)
    end
end

return snake