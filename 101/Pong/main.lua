require("menu")
require("ball")
require("player")
require("opponent")

gameOn = false
moeMode = false

function love.load()
    Menu:load()
    Ball:load()
    Player:load()
    Opponent:load()
end

function love.update(dt)
  if not gameOn then
    Menu:update(dt)
  else
    Ball:update(dt)
    Player:update(dt)
    Opponent:update(dt)
  end
  
    
  if love.keyboard.isDown("escape") then
    gameOn = false
    love.load()
  end
end

function love.draw()
  if gameOn then
    Player:draw()
    Ball:draw()
    Opponent:draw()
  else
    Menu:draw()
  end
end

function checkCollision(a, b)
  if a.x + a.width > b.x and 
  a.x < b.x + b.width and 
  a.y + a.height > b.y and 
  a.y < b.y + b.height then
    Ball.bounce:play()
    --Ball.width = Ball.width * Ball.distortRate
    return true
  else
    return false
  end
end

function updateScore(score)
  if score then
    Player.score = Player.score + 1
  else 
    Opponent.score = Opponent.score + 1
  end
end