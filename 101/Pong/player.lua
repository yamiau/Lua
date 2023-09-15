Player = {}

function Player:load()
  self.width = 20
  self.height = 100
  
  self.x = 50
  self.y = (love.graphics.getHeight() -self.height ) /2
  
  self.speed = 500
  
  self.score = 0
end
function Player:update(dt)
  self:move(dt)
  self:checkBoundaries() 
end


function Player:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  scoreX = self.x + self.width / 3.5
  scoreY = self.y + self.height / 2.25
  love.graphics.print({{0, 0, 255, 1}, tostring(self.score)}, scoreX, scoreY, 0, 0.2, 0.2)
end

function Player:move(dt)
  if love.keyboard.isDown("up") then
    self.y = self.y - self.speed * dt
  elseif love.keyboard.isDown("down") then
    self.y = self.y + self.speed * dt  
  end
end

function Player:checkBoundaries()
  if self.y < 0 then
    self.y = 0
  elseif self.y + self.height> love.graphics.getHeight() then
    self.y = love.graphics.getHeight() - self.height
  end
end