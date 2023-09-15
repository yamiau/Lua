require("math")
Opponent = {}

function Opponent:load()
  self.width = 20
  self.height = 100
  
  self.x = (love.graphics.getWidth() -self.width) - 50
  self.y = (love.graphics.getHeight() -self.height ) /2
  
  self.yVel = 0
  self.speed = 500
  
  self.difficulty = 5
  self.timer = 0
  self.rate = 0.8
    
  self.score = 0
end
function Opponent:update(dt)
  self:move(dt)
  self.timer = self.timer + dt
  if self.timer > self.rate then
    self:acquireTarget()
    self.timer = 0
  end
  self:checkBoundaries() 
end

function Opponent:move(dt)
  math.randomseed(os.time())
  self.y = self.y + self.yVel * dt --* math.random(1 - 1/self.difficulty, 1)
end

function Opponent:acquireTarget()
  if Ball.xVel > 0 then
    if Ball.y + Ball.height  < self.y then
      self.yVel = -self.speed
    elseif Ball.y > self.y + self.height then
      self.yVel = self.speed 
    else
      self.yVel = 0
    end
  end
end

function Opponent:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  scoreX = self.x + self.width / 3.5
  scoreY = self.y + self.height / 2.25
  love.graphics.print({{255, 0, 0, 1}, tostring(self.score)}, scoreX, scoreY, 0, 0.2, 0.2)
end



function Opponent:checkBoundaries()
  if self.y < 0 then
    self.y = 0
  elseif self.y + self.height > love.graphics.getHeight() then
    self.y = love.graphics.getHeight() - self.height
  end
end