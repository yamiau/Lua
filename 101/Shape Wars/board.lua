require("space")

Board = {}

function Board:load()
  self.squareSize = love.graphics.getHeight() / 6
  self.offset = ((love.graphics.getHeight() / self.squareSize) - 6) / 2
  
  self.spaces = {}
end

function Board:update(dt)
end

function Board:draw()
  for i = 5, 0, -1
  do
    for j = 5, 0, -1
    do
      if (i+j) % 2 ~= 0 then
        love.graphics.setColor(love.math.colorFromBytes(220, 156, 114))
      else 
        love.graphics.setColor(love.math.colorFromBytes(170, 201, 209))
      end
      minX = self.squareSize * (i + self.offset)
      minY = self.squareSize * (j + self.offset)
      love.graphics.rectangle("fill", minX, minY, self.squareSize, self.squareSize)
      
      love.graphics.print({{0, 0, 0, 1}, tostring(j+1).."x"..tostring(i+1)}, minX, minY)
      
      if i == 1 and j == 1 then
        newspace = Space.new({i, j}, true)
      else 
        newspace = Space.new({i, j}, false)
      end
      table.insert(self.spaces, newspace)
    end
  end
  
  for i, v in ipairs(self.spaces) do
    if v.occupied then
      love.graphics.setColor(0, 0, 0)
      love.graphics.circle("fill", v.boundaries[1] + self.squareSize / 2, v.boundaries[2] + self.squareSize / 2, 40)
    end
  end
end