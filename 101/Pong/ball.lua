Ball = {}

function Ball:load()
  self.width = 20
  self.height = 20
  
  self.x = love.graphics.getWidth() /2
  self.y = love.graphics.getHeight() /2
  
  self.speed = 200
  self.xVel = -self.speed
  self.yVel = 0
  
  self.collisionCounter = 1
  self.score = true
  
  --[[self.timer = 0
  self.rate = 0.22--
  self.distortRate = 0.7]]
      
  self.bounce = love.audio.newSource("bounce.wav", "static")
  
  --self.sprite = love.graphics.newImage("face.png")
end

function Ball:update(dt)
  self:move(dt)
  self:collide(dt)
end


function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  --love.graphics.draw(self.sprite, self.x, self.y)
  
  --[[if self.timer > self.rate then
    self.width = 20
    self.height = 20
    self.timer = 0
  end]]
end

function Ball:move(dt)
  self.x = self.x + self.xVel * dt
  self.y = self.y + self.yVel * dt
end

function Ball:collide(dt)
  --self.timer = self.timer + dt
  
  if checkCollision(self, Player) then
    self:speedUp()
    self.xVel = self.speed
    local middleBall = self.y + self.height /2
    local middlePlayer = Player.y + Player.height /2
    local collisionPosition = middleBall - middlePlayer
    self.yVel = collisionPosition * 5
  end
    
  if checkCollision(self, Opponent) then
    self:speedUp()
    self.xVel = -self.speed
    local middleBall = self.y + self.height /2
    local middleOpponent = Opponent.y + Opponent.height /2
    local collisionPosition = middleBall - middleOpponent
    self.yVel = collisionPosition * 5
  end
    
  if self.y < 0 then
    self.bounce:play()
    --self.height = self.height * self.distortRate
    self:speedUp()
    self.y = 0
    self.yVel = -self.yVel
  elseif self.y + self.height > love.graphics.getHeight() then
    self.bounce:play()
   -- self.height = self.height * self.distortRate
    self:speedUp()
    self.y = love.graphics.getHeight() - self.height
    self.yVel = -self.yVel
  end
  
  if self.x < 0 then
    updateScore(false)
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() /2
    self.speed = 200
    self.xVel = -self.speed
    self.yVel = 0
  elseif self.x + self.width > love.graphics.getWidth() then
    updateScore(true)
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() /2
    self.speed = 200
    self.xVel = self.speed
    self.yVel = 0
  end
end

function Ball:speedUp()
  self.speed = self.speed * 1.1
end