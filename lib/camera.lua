local cam = {}
local cammeta = {}

function cammeta:lookAt(x, y)
  self.x = x
  self.y = y
end

function cammeta:changeZoom(zoom)
  self.zoom = zoom
end

function cammeta:changeRot(rot)
  self.rot = rot
end

function cammeta:move(x, y)
  self.x = self.x + x
  self.y = self.y + y
end

function cammeta:zoom(zoom)
  self.zoom = self.zoom + zoom
end

function cammeta:rotate(rot)
  self.rot = self.rot + rot
end

function cam.new(x, y, zoom, rot)
  --replace soon
end

return cam