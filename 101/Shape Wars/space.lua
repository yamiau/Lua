Space = {}
Space.__index = Space
--[[
function Space:load()
  self.boundaries = {nil, nil, nil, nil}
end

function Space:update(dt)
end

function Space:draw()
end]]

function Space.new(boundaries, occupied)
  local instance = setmetatable({}, Space)
  instance.boundaries = boundaries
  instance.occupied = occupied
  return instance
end