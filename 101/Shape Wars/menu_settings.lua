menu_settings = {}

local buttons = {}

function menu_settings:load()
  pieceColor = 1
  
  table.insert(buttons, 
    newButton(
      "Piece Color",
      function()
        clickSound()
        if pieceColor == #palette then
          pieceColor = 1
        else
          pieceColor = pieceColor + 1
        end
      end
    )
  )
  
  table.insert(buttons, 
    newButton(
      "Sound: ON",
      function()
        clickSound()
        sound = not sound
      end
    )
  )
  
  table.insert(buttons, 
    newButton(
      "Main Menu",
      function()
        clickSound()
        currentMode = 0 
      end
    )
  )
  
  love.timer.sleep(0.1)
end

function menu_settings:update(dt)
end

function menu_settings:draw()
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()
  
  local button_width = ww * (1/3)
  local margin = 50
  local total_height = (BUTTON_HEIGHT + margin) * #buttons
  local cursor_y = 0
  
  love.graphics.setColor(palette[pieceColor])
  love.graphics.circle("fill", ww/2, wh/6, 20)
  
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
      if button.text == "Sound: ON" then
        button.text = "Sound: OFF"
      elseif button.text == "Sound: OFF" then
        button.text = "Sound: ON"
      end
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

