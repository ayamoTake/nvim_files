vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
        vim.opt.mouse = "nvi"
    end,
})

vim.api.nvim_create_autocmd("FocusLost", {
    callback = function()
        vim.opt.mouse = ""
    end,
})

require("mapping")

if vim.fn.has("wsl") == 1 then
    if vim.fn.executable("xsel") == 0 then
        print("xsel not found, clipboard integration won't work")
    else
        vim.g.clipboard = {
            name = 'xsel-clipboard (wsl)',
            copy = {
                ['+'] = 'xsel -bi',
                ['*'] = 'xsel -bi',
            },
            paste = {
                ['+'] = 'xsel -bo',
                ['*'] = function() return vim.fn.systemlist('xsel -bo | tr -d "\r"') end,
            },
            cache_enabled = true,
        }
    end
end
vim.opt.clipboard = "unnamedplus"

-- LSPサーバアタッチ時の処理
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ctx)
    local set = vim.keymap.set
    set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = true })
    set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = true })
    set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = true })    
    set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = true })
    set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { buffer = true })
    set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = true })
    set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = true })

  end,
})

-- vim.api.nvim_set_keymap('n', '<leader>r', ':w<CR>:belowright split term://g++ % -o %:r && ./%:r<CR>', { noremap = true, silent = true })

-- vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true

-- 検索
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = false

-- タブ
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true


-- 矩形選択
vim.opt.virtualedit="block"

-- 候補のマッチ
vim.opt.wildmenu = true
vim.opt.wildmode = "longest", "full"

-- クリップボードにヤンク
-- vim.opt.clipboard:append({ unnamedplus = true })

vim.cmd('let &t_SI .= "\\e[6 q"')
vim.cmd('let &t_EI .= "\\e[2 q"')
vim.cmd('let &t_SR .= "\\e[4 q"')

vim.opt.showmatch = true
vim.opt.splitbelow = true
vim.opt.undofile = true

vim.cmd([[
    " https://qiita.com/yahihi/items/4112ab38b2cc80c91b16
    if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal g`\"" | endif
    " end https://qiita.com/yahihi/items/4112ab38b2cc80c91b16
]])

-- status line
vim.opt.laststatus = 2

if vim.fn.winwidth(0) >= 130 then
    vim.opt.statusline = "%F"
else
    vim.opt.statusline = "%t"
end

vim.opt.statusline:append(" %y%=[%l/%L]")

require("lazy").setup({
    defaults = { lazy = false, },
    spec = {
        { import = "plugins" },
    },
})

-- 透明化 
vim.cmd([[
  highlight Normal       ctermbg=none guibg=none
  highlight NormalNC     ctermbg=none guibg=none
  highlight NormalSB     ctermbg=none guibg=none
  highlight NonText      ctermbg=none guibg=none
  highlight LineNr       ctermbg=none guibg=none
  highlight LineNrAbove  ctermbg=none guibg=none
  highlight LineNrBelow  ctermbg=none guibg=none
  highlight CursorLineNr ctermbg=none guibg=none
  highlight SignColumn   ctermbg=none guibg=none
]])

-- 、や。でWORD ジャンプをする.
-- 日本語句読点（空白はここに含めない）
local punct = '、。！？…；「」『』（）［］【】〈〉《》〔〕｛｝｡､〜'

-- 区切りを「空白 OR 句読点クラス」と明示するパターン片
local sep_group = '\\v(\\s|\\n|[' .. punct .. '])'    -- 1 個の区切り (very-magic モード)
local sep_group_plus = sep_group .. '+'          -- 1 個以上
local sep_group_star = sep_group .. '*'          -- 0 個以上

-- 次の“語”の先頭へ（W 代替）：現在の非区切り塊 + 区切りを飛び越えて次の非区切りの先頭へ
local function JP_W()
  if vim.fn.search('\\v\\S{-}'..sep_group_plus..'\\zs\\S', 'W')  == 0 then
    -- もし今が区切り上なら、その連続を飛ばして次の非区切りへ
    vim.fn.search('\\v'..sep_group_star..'\\zs\\S', 'W')
  end
end

-- 次の“語”の末尾へ（E 代替）：非区切りの連続の末尾（区切り直前 or 行末）へ
local function JP_E()
  vim.fn.search('\\v\\S+\\ze(\\s|\\n|['..punct..']|$)', 'We')
end

vim.keymap.set({'n','x','o'}, 'W', JP_W, {silent=true, desc='W: JP punctuation as separators'})
vim.keymap.set({'n','x','o'}, 'E', JP_E, {silent=true, desc='E: JP punctuation as separators'})

-- 逆方向 W 代替: 直前の非区切り塊の先頭へ
local function JP_B()
  -- 非貪欲に前の非空白塊＋区切り列をマッチさせてカーソルを先頭に
  if vim.fn.search('\\v\\S{-}' .. sep_group_plus .. '\\zs\\S', 'bW') == 0 then
    -- もしカーソルが区切り上にいる場合は区切り列を飛ばして前の非区切りへ
    vim.fn.search('\\v' .. sep_group_star .. '\\zs\\S', 'bW')
  end
end

-- 逆方向 E 代替: 直前の非区切り塊の末尾へ
local function JP_B_E()
  vim.fn.search('\\v\\S+\\ze(' .. sep_group .. '|^)', 'bWe')
end

-- マッピング
vim.keymap.set({'n','x','o'}, 'B', JP_B, {silent=true, desc='B: JP punctuation as separators'})
vim.keymap.set({'n','x','o'}, 'gE', JP_B_E, {silent=true, desc='gE: JP punctuation aware end backward'})

local function is_katakana_cp(cp)
  return cp >= 0x30A0 and cp <= 0x30FF
end

-- グローバル・キャッシュ
local cps_cache = {}
local cps_cache_row = nil

-- 行ごとのコードポイントを返す関数
local function get_cps_for_line(line, row)
  if cps_cache_row == row and cps_cache[row] then
    return cps_cache[row]
  end

  local n_chars = vim.fn.strchars(line)
  local cps = {}
  for i = 0, n_chars-1 do
    if line == nil then
        line = vim.api.nvim_get_current_line()
    end
    cps[i] = vim.fn.char2nr(vim.fn.strcharpart(line, i, 1))
  end

  cps_cache[row] = cps
  cps_cache_row = row
  return cps
end

-- キャッシュを無効化する関数
local function invalidate_cps_cache()
  cps_cache = {}
  cps_cache_row = nil
end

-- 編集されたときにキャッシュをクリア
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  pattern = "*",
  callback = invalidate_cps_cache,
})

local function right_or_left_dot_pos(cps, idx, diff)
    while idx <= #cps and idx >= 0 do
        local cp = cps[idx]
        if cp == 0x30FB then
            return idx
        elseif not is_katakana_cp(cp) then
            return 0 -- end katakana
        end
        idx = idx + diff
    end
    return 0 -- all katakana or none
end

local function right_dot_pos(cps, idx)
    return right_or_left_dot_pos(cps, idx, 1)
end

local function left_dot_pos(cps, idx)
    return right_or_left_dot_pos(cps, idx, -1)
end

local function get_current_idx(line, row, col)
  if line == "" then return -1 end

  local n_chars = vim.fn.strchars(line)
  if n_chars == 0 then return -1 end

  local cur_index = vim.str_utfindex(line, col)
  if cur_index < 0 or cur_index >= n_chars then return -1 end
  return cur_index
end

local function get_current_katakana_idx(line, row, col)
  if line == "" then return -1 end

  local n_chars = vim.fn.strchars(line)
  if n_chars == 0 then return -1 end

  local char_index = vim.str_utfindex(line, col)
  local cur_char = vim.fn.strcharpart(line, char_index, 1)
  local cur_cp = vim.fn.char2nr(cur_char)

  if not is_katakana_cp(cur_cp) then return -1 end

  local cur_index = vim.str_utfindex(line, col)
  if cur_index < 0 or cur_index >= n_chars then return -1 end
  return cur_index
end

local function jump_to_right_katakana_dot_on_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local cur_index = get_current_katakana_idx(line, row, col)
  if cur_index == -1 then -- not katakana
    return false
  end

  local cps = get_cps_for_line(line, row)
  if cur_index ==  #cps then
    return false
  end

  if cps[cur_index] == 0x30FB then
    vim.cmd("normal! l")
    return true -- done
  end

  local dotpos = right_dot_pos(cps, cur_index + 1)
  if dotpos == 0 then
    return false -- default moving
  end

  local target_byte = vim.str_byteindex(line, dotpos)
  vim.api.nvim_win_set_cursor(0, { row, target_byte })
  return true

end

-- e jump
local function jump_to_right_katakana_dot_on_line_end()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local cur_index = get_current_katakana_idx(line, row, col)
  if cur_index == -1 then -- not katakana
    return false
  end

  local cps = get_cps_for_line(line, row)
  if cur_index == #cps and row == vim.api.nvim_buf_line_count(0) then
      return false
  end

  if cur_index == #cps then -- move to next line
    line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    row = row + 1
    cur_index = -1
    vim.notify(string.format("%s", line))
    cps = get_cps_for_line(line, row)
  end

  local dbgmsg = ""
  for i = 0, #cps do
    dbgmsg = dbgmsg .. vim.fn.nr2char(cps[i])
  end
  local dotpos = right_dot_pos(cps, cur_index + 1)
    vim.notify(string.format("dotpos: %d, %s", dotpos, dbgmsg))
  if dotpos == 0 then
    return false -- default moving
  end

  local target_pos = dotpos - 1
  if cur_index == target_pos then target_pos = target_pos + 1 end

  local target_byte = vim.str_byteindex(line, target_pos)
  vim.api.nvim_win_set_cursor(0, { row, target_byte })
  return true

end

local function is_whitespace(cp)
    return cp == 0x20   -- SPACE
            or cp == 0x09 -- TAB
            or cp == 0x0A -- LF
            -- 他に必要なら Unicode 空白を追加
end

local function first_non_whitespace(cps)
    for i = 0, #cps-1 do
        local cp = cps[i]
        if not is_whitespace(cp) then
            return i
        end
    end
    return nil  -- all ws
end

local function last_non_whitespace(cps)
    for i = #cps-1, 0, -1 do
        local cp = cps[i]
        if not is_whitespace(cp) then
            return i
        end
    end
    return nil  -- all ws
end

local function jump_to_left_katakana_dot_on_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local cur_index = get_current_idx(line, row, col)
  vim.notify(string.format("cur_index: %d", cur_index))
  if cur_index == -1 then
    return false
  end

  if cur_index == 1 and row == 1  then
      return false
  end
  
  local cps = get_cps_for_line(line, row)
  -- trim indent and last spaces
  local first_nws_idx = first_non_whitespace(cps)

  if cur_index <= first_nws_idx then -- move to prev (up) line
      line = vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)[1]
      row = row - 1
      cps = get_cps_for_line(line, row)
      cur_index = #cps + 1
  end

  local last_nws_idx = last_non_whitespace(cps)
  if last_nws_idx < cur_index then
    cur_index = last_nws_idx
  end

  if cur_index <= #cps and not is_katakana_cp(cps[cur_index]) then
    return false
  end

  if cur_index > 1 and cps[cur_index-1] == 0x30FB then
    local target_byte = vim.str_byteindex(line, cur_index-1)
    vim.api.nvim_win_set_cursor(0, { row, target_byte })
    return true -- done
  end

  local dotpos = left_dot_pos(cps, cur_index - 1)
  if dotpos == 0 then -- all katakana or found boundary of katakana
    return false -- default moving
  end

  local target_byte = vim.str_byteindex(line, dotpos+1)
  vim.api.nvim_win_set_cursor(0, { row, target_byte })
  return true

end

vim.keymap.set({ "n", "v", }, "w", function()
  if not jump_to_right_katakana_dot_on_line() then
    vim.cmd("normal! w")
  end
end, { --[[expr = true, --]] noremap = true, silent = true })

vim.keymap.set({ "n", "v", }, "e", function()
  if not jump_to_right_katakana_dot_on_line_end() then
    vim.cmd("normal! e")
  end
end, { --[[expr = true, --]] noremap = true, silent = true })

vim.keymap.set({ "n", "v", }, "b", function()
  if not jump_to_left_katakana_dot_on_line() then
    vim.cmd("normal! b")
  end
end, { --[[expr = true, --]] noremap = true, silent = true })

-- 移動した文字の情報を表示
function unicode_name(cp)
    local cmd = string.format(
        [[python3 -c "import unicodedata; import sys;
print(unicodedata.name(chr(%d), '<unknown>'))" 2> /dev/null]], -- エラーを捨てる.
        cp
    )
    local result = vim.fn.systemlist(cmd)[1] or "<unknown>"

    return vim.fn.trim(result)
end

vim.o.cmdheight = 2
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    pattern = "*",
    callback = function()
        if vim.fn.mode() == 'n' then
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            local line = vim.api.nvim_get_current_line()
            local char_index = vim.str_utfindex(line, col)
            local cur_char = vim.fn.strcharpart(line, char_index, 1)
            local cur_cp = vim.fn.char2nr(cur_char)
            local name = unicode_name(cur_cp)
            local msg = string.format("(U+%04X) %s %s", cur_cp, cur_char, name)

            local max_width = vim.api.nvim_get_option("columns")
            local available_width = math.floor(max_width*0.7)

            -- vim.notify(msg:sub(1, available_width))
            vim.notify(msg)

        end
    end,
})
