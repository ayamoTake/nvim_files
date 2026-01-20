local wezterm = require 'wezterm'
local config = {}

wezterm.log_info("hello wezterm")

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- 基本設定
config.automatically_reload_config = true
config.font_size = 12.0

config.font = wezterm.font {
  family = 'JetBrains Mono',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}
config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"
-- config.hide_tab_bar_if_only_one_tab = true

config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
}

config.color_scheme = "AdventureTime"

config.initial_rows = 30
config.initial_cols = 120
config.use_ime = true
config.audible_bell = "Disabled" -- これでベル音をオフに

-- WSLのUbuntuをデフォルトにする
config.default_domain = 'WSL:Ubuntu-22.04'

-- マウスの右クリックでペースト
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
}

-- アクティブなタブの色
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
   local background = "#1F1D45"
   local foreground = "#FFFFFF"
   if tab.is_active then
     background = "#7e007d"
     foreground = "#FFFFFF"
   end
   local title = "" .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. " "
   return {
     { Background = { Color = background } },
     { Foreground = { Color = foreground } },
     { Text = title },
   }
end)

-- keybinds
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 2000}

local opacity = 1.0
wezterm.on("adjust-opacity", function(window, _)
    window:set_config_overrides({
        window_background_opacity = opacity,
    })
end)

local function adjust_opacity(delta)
  return wezterm.action_callback(function(window, pane)
      opacity = math.min(
        1.0,
        math.max(0.1, opacity + delta)
      )
      window:perform_action(
        wezterm.action.EmitEvent("adjust-opacity"),
        pane
      )
  end)
end

-- local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

config.keys = {
  -- リーダーキー+ h/j/k/l でペイン移動
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = ' ', mods = 'LEADER|CTRL', action = wezterm.action.ActivatePaneDirection 'Next' },

  -- リーダーキー + - で縦分割、+ \ で横分割
  { key = 's', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = 'v', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },

  -- ペインを閉じる（leader+q）
  { key = 'q', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = false } },

  -- ペインのサイズ調整（Alt + Shift + hjkl）
  { key = 'h', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Left', 2 } },
  { key = 'j', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Down', 2 } },
  { key = 'k', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Up', 2 } },
  { key = 'l', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Right', 2 } },

  -- フォントサイズ変更
  { key = ';', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },

  -- 新しいタブ（leader+t）
  { key = 't', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },

  -- タブ移動（Alt + 数字）
  { key = '1', mods = 'LEADER', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = wezterm.action.ActivateTab(3) },
  { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },

  { key = 'j', mods = 'ALT', action = adjust_opacity(0.2) },
  { key = 'k', mods = 'ALT', action = adjust_opacity(-0.2) },

  -- TODO: 
  -- 一つしか workspace がないときに新しい workspace を作ってしまう
  {
    key = 'w',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs {
      flags = 'WORKSPACES',
    },
  },

  {
    -- Create new workspace
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = "(wezterm) Create new workspace:",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(
            wezterm.action.SwitchToWorkspace { name = line },
            pane
          )
        end
      end),
    },
  },

  {
    key = 'b',
    mods = 'LEADER',
    action = wezterm.action.ToggleFullScreen,
  },

  {
    key = 'f',
    mods = 'ALT',
    action = wezterm.action.ToggleAlwaysOnTop,
  },

  -- {
  --   key = "s",
  --   mods = "ALT",
  --   action = wezterm.action_callback(function(win, pane)
  --     resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
  --     resurrect.window_state.save_window_action()
  --   end),
  -- }, 
  --
  -- {
  --   key = "r",
  --   mods = "ALT",
  --   action = wezterm.action_callback(function(win, pane)
  --     resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
  --       local type = string.match(id, "^([^/]+)") -- match before '/'
  --       id = string.match(id, "([^/]+)$") -- match after '/'
  --       id = string.match(id, "(.+)%..+$") -- remove file extention
  --       local opts = {
  --         relative = true,
  --         restore_text = true,
  --         on_pane_restore = resurrect.tab_state.default_on_pane_restore,
  --       }
  --       if type == "workspace" then
  --         local state = resurrect.state_manager.load_state(id, "workspace")
  --         resurrect.workspace_state.restore_workspace(state, opts)
  --       elseif type == "window" then
  --         local state = resurrect.state_manager.load_state(id, "window")
  --         resurrect.window_state.restore_window(pane:window(), state, opts)
  --       elseif type == "tab" then
  --         local state = resurrect.state_manager.load_state(id, "tab")
  --         resurrect.tab_state.restore_tab(pane:tab(), state, opts)
  --       end
  --     end)
  --   end),
  -- },

  {
    key = "l",
    mods = "ALT",
    action = wezterm.action_callback(function(window, _)
      local workspace_name = window:active_workspace()
      wezterm.log_info("workspace! " .. workspace_name)

      local muxw = window:mux_window()

      for i, tab in pairs(muxw:tabs()) do
        wezterm.log_info(tab:tab_id())
        for j, pane in pairs(tab:panes()) do
          wezterm.log_info("  " .. pane:get_current_working_dir().path)
        end

      end

    end),
  },

}

local mux = wezterm.mux

wezterm.on('gui-startup', function()
  local tab, pane, conf_window = mux.spawn_window {
    workspace = 'conf',
    cwd = '/home/saiun/win_home/.config/wezterm',
  }

  conf_window:spawn_tab {
    cwd = '/home/saiun/.config/nvim',
  }

  local _, _, sch_win = mux.spawn_window {
    workspace = 'school',
    cwd = '/home/saiun/Docs/school/3',
  }

  sch_win:spawn_tab {
    cwd = '/home/saiun/school_tmp/',
  }

  local _, _, memo_win = mux.spawn_window {
    workspace = 'memo',
    cwd = '/home/saiun/Docs/',
  }

  memo_win:spawn_tab {
    cwd = '/home/saiun/Docs/nikki/links',
  }

end)

return config

