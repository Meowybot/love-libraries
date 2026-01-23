local timer = {}
local metatimer = {}
metatimer.basic = {}
metatimer.basic.__index = metatimer

function metatimer.basic:pause()
  if not self.paused then
    self.paused = true
  end
end

function metatimer.basic:resume()
  if self.paused then
    self.paused = false
  end
end

function metatimer.basic:update(dt)
  if not self.paused then
    self.iti = self.iti + dt
    if self.iti >= self.timeset then
      self.paused = true
      self.onEnd()
    end
  end
end

function metatimer.basic:finish()
  self.iti = self.timeset
end

function timer.newBasic(time, onEnd, startpaused)
  local newti = {}
  newti.timeset = time or 2
  newti.onEnd = onEnd or function() end
  newti.paused = startpaused or false
  newti.iti = 0
  setmetatable(newti, metatimer.basic)
  return newti
end