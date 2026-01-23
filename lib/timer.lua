local timer = {}
local metatimer = {}
metatimer.__index = metatimer

function metatimer:pause()
  if not self.paused then
    self.paused = true
  end
end

function metatimer:resume()
  if self.paused then
    self.paused = false
  end
end

function metatimer:update(dt)
  if not self.paused then
    self.iti = self.iti + dt
    if self.iti >= self.timeset then
      self.paused = true
      self.onEnd()
    end
  end
end

function metatimer:finish()
  self.iti = self.timeset
end