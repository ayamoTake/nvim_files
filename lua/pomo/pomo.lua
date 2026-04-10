local PrintNotifier = {}

local AUDIO_FILE_PATH =  vim.fn.stdpath('config') .. '/lua/pomo/audio'
local PLAY_AUDIO_CMD = "mpg123"

PrintNotifier.new = function(timer, opts)
  local self = setmetatable({}, { __index = PrintNotifier })
  self.timer = timer
  self.hidden = false
  self.opts = opts -- not used
  self.notification = nil
  return self
end

---@param text string
PrintNotifier.notify = function(self, text)
  local opt = {
      title = "Timer",
      replace = self.notification
  }
  self.notification = vim.notify(text, vim.log.levels.INFO, opt)
end

PrintNotifier.start = function(self)
  local remain_min = self.timer.time_limit / 60
  local remain_sec = self.timer.time_limit % 60

  if not self.timer.name then
    self.notify(self, string.format("#%d start: %02d:%02d", self.timer.id, remain_min, remain_sec))
    return
  end

  if string.match(self.timer.name, ".*1st Work.*") then
    vim.system({ PLAY_AUDIO_CMD, AUDIO_FILE_PATH .. "/" .. "pend_clock_twice.mp3" }, {})
  end

  if string.match(self.timer.name, "Work")
     or string.match(self.timer.name, "Break") then
    return
  end

  self.notify(self, string.format("%s start: %02d:%02d", self.timer.name, remain_min, remain_sec))
end

PrintNotifier.tick = function(self, time_left)
  if  self.hidden then return end
  local remain_min = time_left / 60
  local remain_sec = time_left % 60
  if self.timer.name then
    self.notify(self, string.format("%s, %02d:%02d", self.timer.name, remain_min, remain_sec))
  else
    self.notify(self, string.format("#%d, %02d:%02d", self.timer.id, remain_min, remain_sec))
  end
end

PrintNotifier.done = function(self)
  if not self.timer.name then
    self.notify(self, string.format("#%d, complete", self.timer.id))
    return
  end

  -- https://otologic.jp/free/se/pendulum-clock01.html
  if string.match(self.timer.name, ".*Break.*") then
    vim.system({ PLAY_AUDIO_CMD, AUDIO_FILE_PATH .. "/" .. "pend_clock_twice.mp3" }, {})
  elseif string.match(self.timer.name, ".*Work.*") then
    vim.system({ PLAY_AUDIO_CMD, AUDIO_FILE_PATH .. "/" .. "pend_clock.mp3" }, {})
  end
end

PrintNotifier.stop = function(self) end

PrintNotifier.show = function(self)
  self.hidden = false
end

PrintNotifier.hide = function(self)
  self.hidden = true
end


return {
  "epwalsh/pomo.nvim",
  version = "*",  -- Recommended, use latest release instead of latest commit
  lazy = true,
  event = "BufReadPost",
  cmd = { "TimerStart", "TimerRepeat", "TimerSession", "TimerShow", },
  dependencies = {
    -- Optional, but highly recommended if you want to use the "Default" timer
    "rcarriga/nvim-notify",
  },
  config = function ()
    require("pomo").setup({
      -- update_interval = 60000, -- How often the notifiers are updated.
      notifiers = {
        { init = PrintNotifier.new, opts = {} }
      },
      sessions = {
        Test = {
          { name = "1st Work", duration = "10m" },
          { name = "1st Break", duration = "5m" },
          { name = "2nd Work", duration = "10m" },
        },
        pomodoro = {
          { name = "1st Work", duration = "25m" },
          { name = "1st Break", duration = "5m" },
          { name = "2nd Work", duration = "25m" },
          { name = "2nd Break", duration = "5m" },
          { name = "3rd Work", duration = "25m" },
          { name = "3rd Break", duration = "5m" },
          { name = "4th Work", duration = "25m" },
          { name = "4th Break", duration = "5m" },
        },
      },
    })
  end
}
