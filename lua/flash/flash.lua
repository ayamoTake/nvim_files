---https://github.com/atusy/dotfiles/blob/edc3747b42e7765943356846555c66d69f028a5f/dot_config/nvim/lua/plugins/flash/init.lua
---https://github.com/atusy/dotfiles/blob/edc3747b42e7765943356846555c66d69f028a5f/dot_config/nvim/lua/plugins/flash/matchers.lua
---https://github.com/atusy/dotfiles/blob/edc3747b42e7765943356846555c66d69f028a5f/dot_config/nvim/lua/plugins/flash/query.lua


---@param pat string pattern to be converted to migemo
---@return string
local function kensaku(pat)
  if pat:match("[0-9A-Z]") then return pat end
  local str = pat
  local query = ""
  for _ = 1, #str do
    local left, right = string.find(str, " +", 0, false)
    if left == nil then 
      return query .. vim.fn['kensaku#query'](str)
    end
    if left > 1 then
      query = query .. vim.fn['kensaku#query'](string.sub(str, 1, left - 1))
    end
    query = query .. string.rep([[\(\s\| \)\)]], right - left + 1)
    str = string.sub(str, right + 1)
  end
  return query
end

return {
  "folke/flash.nvim",
  dependencies = {
    'vim-denops/denops.vim',
    'lambdalisue/kensaku.vim'
  },
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = true,
      },
      char = {
        jump_labels = true,
        keys = {
          "f", "F", ";", ",", -- "t", "T",
        },
      },
    },
    jump = {
      -- add pattern to search history
      history = true,
      -- add pattern to search register
      register = true,
      -- automatically jump when there is only one match
      autojump = false,
    },
  },
  keys = {
    { "<Leader>/", mode = { "n", "x", "o" }, function() require("flash").jump({
      search = {
        mode = "fuzzy",
        incremental = true,
      },
    }) end, desc = "Flash" },
    { "<Leader><Leader>/", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "<Leader><Leader><Leader>/", mode = { "n", "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-/>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    -- { "<Leader>f", mode = { "n", "o", "x" }, function()
    --   require("flash").jump({
    --     pattern = ".", -- initialize pattern with any char
    --     search = {
    --       mode = function(pattern)
    --         -- remove leading dot
    --         if pattern:sub(1, 1) == "." then
    --           pattern = pattern:sub(2)
    --         end
    --
    --         -- Vim regex (very magic) + explicit unicode ranges
    --         local word_pat = ([[\v(%s\zs[ぁ-ゖ])|(%s\zs[ァ-ヺー])]]):format(pattern, pattern)
    --         local skip_pat = ([[\<%s]]):format(pattern)
    --
    --         return word_pat, skip_pat
    --       end,
    --     },
    --     -- jump = { pos = "range" },
    --     label = { before = true, after = false, },
    --   })
    -- end, desc = "Treesitter Search" },
    { -- 日本語検索に対応??
      'ff',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump({
					labels = [[ABCDEFGHIJKLMNOPQRSTUVWXYZ]],
          search = {
            mode = kensaku,

          },
        })
      end,
      desc = 'Flash with Kensaku',
    },
  },
}
