require("menu_main")
require("menu_settings")
require("board")
require("space")
require("player")
require("shape")


BUTTON_HEIGHT = 50

font = nil
currentMode = 0
settings = {{}, true}

spaces = {}

subscreens = {false, false}

function newButton(text, fn)
  return {
    text = text,
    fn = fn,
    now = false,
    last = false
  }
end

function love:load()
  
  font = love.graphics.newFont(32)
  menu_main:load()
 --Board:load() 
end

function love:update(dt)
  --Board:update(dt)
end


function love:draw()
  if currentMode < 1 then
    menu_main:draw()
  elseif currentMode > 1 then  
    if subscreens[1] then
      menu_settings:draw()
    else 
      subscreens[1] = true
      menu_settings:load()
    end
  else
    game()
  end
  
  --Board:draw()
end