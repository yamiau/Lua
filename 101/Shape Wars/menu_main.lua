menu_main = {}

local buttons = {}

function menu_main:load()

  table.insert(buttons, 
    newButton(
      "Start",
      function()
        clickSound()
        currentMode = 1 
      end
    )
  )
  
  table.insert(buttons, 
    newButton(
      "Settings",
      function()
        clickSound()
        currentMode = 2
      end
    )
  )
  
  table.insert(buttons, 
    newButton(
      "Exit",
      function()
        clickSound()
        love.event.quit() 
      end
    )
  )
end

function menu_main:update(dt)
end

function menu_main:draw()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()
  
  local button_width = ww * (1/3)
  local margin = 50
  local total_height = (BUTTON_HEIGHT + margin) * #buttons
  local cursor_y = 0
  
  
  for i, button in ipairs(buttons) do
    
    button.last = button.now
    
    local bx = (ww * 0.5) - (button_width * 0.5)
    local by = (wh * 0.5) - (total_height * 0.5) + cursor_y
    local bc = buttonColor[1]
    
    local mx, my = love.mouse.getPosition()
    local hot = mx >= bx and mx < bx + button_width and 
                my >= by and my < by + BUTTON_HEIGHT
    
    if hot then
      bc = buttonColor[2]
    end
    
    button.now = love.mouse.isDown(1)
    if button.now and not button.last and hot then
      button.fn()
    end
    
    love.graphics.setColor(unpack(bc))
    
    love.graphics.rectangle(
      "fill",
      bx,
      by,
      button_width,
      BUTTON_HEIGHT
    )  
    
    love.graphics.setColor(0, 0, 0, 1)
    
    local tx = (ww * 0.5) - (font:getWidth(button.text) * 0.5)
    local ty = by + (BUTTON_HEIGHT - font:getHeight(button.text)) * 0.5
    
    love.graphics.print(
      button.text,
      font,
      tx,
      ty
    )
    
    cursor_y = cursor_y + BUTTON_HEIGHT + margin
  end
end

