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

function metatimer.relseq:pause()
  self.paused = true
end

function metatimer.relseq:resume()
  self.paused = false
end

function metatimer.relseq:update(dt)
  if not self.paused then
    self.iti = self.iti + dt
    if self.iti >= self.keys[self.curkey].time then
      self.paused = true
      self.keys[self.curkey].onEnd()
      self.iti = self.iti - self.keys[self.curkey].time
      if self.curkey < #self.keys then
        self.curkey = self.curkey+1
        self.paused = false
      end
    end
  end
end

function metatimer.relseq:reset(keepKey)
  self.iti = 0
  if not keepKey then
    self.curkey = 1
  end
end

function metatimer.relseq:getTime(m)
  local mult = m or 1
  local keyp = self.curkey / #self.keys
  local timep = self.iti / self.keys[self.curkey].time
  return keyp, timep
end

function timer.newRelative(keys, startpaused)
  local newti = {}
  newti.keys = keys
  newti.curkey = 1
  newti.paused = startpaused or false
  newti.iti = 0
  setmetatable(newti, metatimer.relseq)
  return newti
end


metatimer.tween = {}
metatimer.tween.__index = metatimer.tween

local easewords = {
["linear"] = "linear",
["none"] = "linear",
["easein"] = "easein",
["easeout"] = "easeout",
["easeinout"] = "easeinout",
["step"] = "step"
}

function metatimer.tween:pause()
  self.paused = true
end

function metatimer.tween:resume()
  self.paused = false
end

function timer.newTween(a, b, time, easing, isInteger, startpaused, onEnd)
  local newti = {}
  newti.timeset = time or 2
  newti.a = a or 0
  newti.b = b or 1
  newti.value = a
  newti.onEnd = onEnd or function() end
  newti.paused = startpaused or false
  newti.iti = 0
  newti.integer = isInteger or false
  if easing then
    newti.easing = easewords[easing] or "linear"
  else
    newti.easing = "linear"
  end
  setmetatable(newti, metatimer.tween)
  return newti
end