local timer = {}
local metatimer = {}
metatimer.basic = {}
metatimer.basic.__index = metatimer.basic

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

function metatimer.basic:reset()
  self.iti = 0
end

function metatimer.basic:getTime(multiplier)
  local mult = multiplier or 1
  return math.min(self.iti/self.timeset, 1) * mult
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

metatimer.relseq = {}
metatimer.relseq.__index=metatimer.relseq

function timer.newRelative