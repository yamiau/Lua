require("opponent")

Menu = {}

function Menu:load()
  self.difficulty = 5
  
  self.width = love.graphics.getWidth() /2
  self.height = love.graphics.getHeight() /2
  self.x = self.width / 2
  self.y = self.height /  2
  
  font = love.graphics.newFont("AldotheApache.ttf", 100)
  love.graphics.setFont(font, 1)
  
  self.moeOn = love.audio.newSource("moeOn.wav", "static")
  self.moeOff = love.audio.newSource("moeOff.wav", "static")
end

function Menu:update(dt)
  self:getInput()
  love.timer.sleep(0.075)
end

function Menu:getInput()
    if love.keyboard.isDown("down") then
    if self.difficulty > 1 then
      self.difficulty = self.difficulty - 1
    else
      self.difficulty = 1
    end
  elseif love.keyboard.isDown("up") then
    if self.difficulty < 10 then
      self.difficulty = self.difficulty + 1
    else
      self.difficulty = 10
    end
  end
  
  if love.keyboard.isDown("m") then
    moeMode = not moeMode
    if moeMode then
      self.moeOn:play()
    else
      self.moeOff:play()
    end      
  end
  
  if love.keyboard.isDown("return") then
    Opponent.difficulty = self.difficulty
    Opponent.rate = Opponent.rate / self.difficulty
    gameOn = true
  end  
end

function Menu:draw()
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
  love.graphics.print({{255, 255, 255, 1}, "SET DIFFICULTY"}, self.x, self.y, 0, 1, 1, -40, -40)
  love.graphics.print({{255, 255, 255, 1}, tostring(self.difficulty)}, self.x, self.y, 0, 1, 1, -300, -200)
end