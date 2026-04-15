-- myxxd.lua
-- バイナリファイルをxxdで人間可読形式に変換して編集するコマンドを提供する
--
-- 使い方:
--   :Myxxd  現在のバッファをhex編集モードにする
--   :w      バイナリとして保存（hex表示は維持）
--
-- オフセットはバッファ外（行番号列）に表示される
-- バッファ内容: "4865 6c6c 6f00 ...  Hello..."（オフセットなし）
-- 行番号列:     "00000000: "（行番号の代わりに自動表示）
--
-- hex部分を編集すると右側のASCII表示がリアルタイムで更新される

-- バッファごとの状態管理
-- key: bufnr, value: { filename, augroup, win_settings }
local xxd_state = {}

-- hex セクションから ASCII 表現を生成する
-- 出力可能文字はそのまま、それ以外は '.' に変換する
local function hex_to_ascii(hex_section)
  local chars = {}
  for byte_str in hex_section:gmatch("[0-9a-fA-F][0-9a-fA-F]") do
    local byte = tonumber(byte_str, 16)
    chars[#chars + 1] = (byte >= 32 and byte <= 126) and string.char(byte) or "."
  end
  return table.concat(chars)
end

-- 行が hex 編集フォーマットかどうかを確認する
-- バッファ内フォーマット（オフセットなし）: "4865 6c6c ..."
local function is_hex_line(line)
  return line:match("^[0-9a-fA-F][0-9a-fA-F]") ~= nil
end

-- バッファ内の指定行範囲の ASCII 表示を更新する
--
-- バッファ内フォーマット（Lua 1-indexed）:
--   1-39 : hex 部分（39文字、スペースパディング含む）
--   40-41: '  '（区切り用スペース2つ）
--   42+  : ASCII 表現
--
-- @param buf    integer  バッファ番号
-- @param first  integer  0-indexed 行番号（開始、inclusive）
-- @param last   integer  0-indexed 行番号（終了、exclusive）
local function update_ascii(buf, first, last)
  if first >= last then return end

  local lines = vim.api.nvim_buf_get_lines(buf, first, last, false)
  local new_lines, changed = {}, false

  for _, line in ipairs(lines) do
    if is_hex_line(line) then
      -- hex 部分を 39 文字に揃える（パディング）
      local hex_sec = line:sub(1, 39)
      if #hex_sec < 39 then
        hex_sec = hex_sec .. string.rep(" ", 39 - #hex_sec)
      end
      local ascii    = hex_to_ascii(hex_sec)
      local new_line = hex_sec .. "  " .. ascii
      if new_line ~= line then changed = true end
      new_lines[#new_lines + 1] = new_line
    else
      new_lines[#new_lines + 1] = line
    end
  end

  if changed then
    -- ASCII 更新をユーザーの hex 編集と同じ undo ブロックに結合する
    -- これにより u 1回で hex 編集と ASCII 更新が同時にundoされる
    pcall(vim.cmd, "undojoin")
    vim.api.nvim_buf_set_lines(buf, first, last, false, new_lines)
  end
end

-- バッファの hex dump をバイナリに変換してファイルに書き込む
-- 行番号からオフセットを計算して付加し、xxd -r に渡す
-- （オフセットはバッファ内に存在しないため、書き込み時に再構築する）
--
-- @param buf      integer  バッファ番号
-- @param filepath string   書き込み先ファイルパス
-- @return boolean          成功した場合 true
local function write_binary(buf, filepath)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  -- 各行に "(行番号-1) × 16" のオフセットを付加して xxd 形式に再構築する
  local hex_lines = {}
  for i, line in ipairs(lines) do
    hex_lines[i] = string.format("%08x: %s", (i - 1) * 16, line)
  end

  local tmp = vim.fn.tempname()
  local f = io.open(tmp, "w")
  if not f then
    vim.notify("[myxxd] 一時ファイルの作成に失敗しました", vim.log.levels.ERROR)
    return false
  end
  f:write(table.concat(hex_lines, "\n") .. "\n")
  f:close()

  local result = vim.fn.system(
    string.format("xxd -r %s %s", vim.fn.shellescape(tmp), vim.fn.shellescape(filepath))
  )
  os.remove(tmp)

  if vim.v.shell_error ~= 0 then
    vim.notify("[myxxd] xxd -r に失敗しました: " .. result, vim.log.levels.ERROR)
    return false
  end
  return true
end

-- ウィンドウの行番号列にhexオフセットを表示する設定を適用し、元の設定を返す
-- statuscolumn で "(行番号-1) × 16" を16進表示する
--
-- @param win  integer  ウィンドウID
-- @return table        復元用の元の設定
local function apply_win_display(win)
  local saved = {
    statuscolumn   = vim.wo[win].statuscolumn,
    number         = vim.wo[win].number,
    relativenumber = vim.wo[win].relativenumber,
  }
  -- number = true で行番号列（= statuscolumn の表示領域）を有効にする
  vim.wo[win].number         = true
  vim.wo[win].relativenumber = false
  -- (v:lnum - 1) × 16 をオフセットとして16進表示する
  vim.wo[win].statuscolumn   = "%{printf('%08x: ', (v:lnum - 1) * 16)}"
  return saved
end

-- ウィンドウの表示設定を元に戻す
--
-- @param win   integer  ウィンドウID
-- @param saved table    apply_win_display の戻り値
local function restore_win_display(win, saved)
  if not vim.api.nvim_win_is_valid(win) then return end
  vim.wo[win].statuscolumn   = saved.statuscolumn
  vim.wo[win].number         = saved.number
  vim.wo[win].relativenumber = saved.relativenumber
end

-- カーソル下のバイトに対応する hex ↔ ASCII 位置にジャンプする
--
-- バッファ内フォーマット（0-indexed 列）:
--   0-38 : hex 部分（39文字）
--   39-40: '  ' セパレータ
--   41+  : ASCII 部分
--
-- hex 列でのバイト i（0-indexed）の位置:
--   (i // 2) * 5 + (i % 2) * 2
--   ← 2バイトごとのグループ（4chars + 1space = 5chars）+ グループ内オフセット
--
-- @param buf  integer  バッファ番号
local function jump_to_pair(buf)
  local win = vim.api.nvim_get_current_win()
  local pos = vim.api.nvim_win_get_cursor(win)  -- {行(1-indexed), 列(0-indexed)}
  local row, col = pos[1], pos[2]

  local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]
  if not line or not is_hex_line(line) then return end

  local ASCII_START = 41  -- 0-indexed: hex(39) + separator(2)
  local HEX_END     = 38  -- 0-indexed: hex 部分の最終列

  if col >= ASCII_START then
    -- ASCII 列 → 対応する hex バイトへジャンプ
    local byte_idx = col - ASCII_START
    if byte_idx >= 16 then return end  -- ASCII 部分の範囲外
    local hex_col = math.floor(byte_idx / 2) * 5 + (byte_idx % 2) * 2
    vim.api.nvim_win_set_cursor(win, { row, hex_col })

  elseif col <= HEX_END then
    -- hex 列 → 対応する ASCII 文字へジャンプ
    -- 列からバイトインデックスを逆算する:
    --   group  = col // 5（2バイトグループ番号）
    --   within = col % 5（グループ内位置: 0-1=第1バイト, 2-4=第2バイトまたはスペース）
    local group    = math.floor(col / 5)
    local within   = col % 5
    local byte_idx = group * 2 + (within >= 2 and 1 or 0)
    local ascii_col = ASCII_START + byte_idx
    -- ASCII 文字が実際に存在する範囲内かチェック
    if ascii_col < #line then
      vim.api.nvim_win_set_cursor(win, { row, ascii_col })
    end
  end
  -- 39-40 はセパレータなので何もしない
end

-- hex 編集バッファの変更リスナーをアタッチする
-- hex 部分を編集するたびに右側の ASCII 表示をリアルタイムで更新する
--
-- @param buf  integer  バッファ番号
local function attach_listener(buf)
  local is_updating = false

  vim.api.nvim_buf_attach(buf, false, {
    on_lines = function(_, b, _, firstline, _, new_lastline)
      -- xxd モードが解除されていたらリスナーを自動解除する
      if not xxd_state[b] then return true end
      if is_updating then return end

      local f, l = firstline, new_lastline
      vim.schedule(function()
        if is_updating or not xxd_state[b] then return end
        is_updating = true
        update_ascii(b, f, l)
        is_updating = false
      end)
    end,
  })
end

-- カーソル下の hex 1桁（nibble）を hex の範囲（0-f）で加減する
-- Vim 標準の <C-A>/<C-X> を置き換える
--
-- 標準動作との違い:
--   - 変化するのはカーソル直下の1桁のみ（グループ全体ではない）
--   - 加減は 16 進数（9 の次は a、f の次は 0 にラップ）
--   - カウント対応: 3<C-A> なら +3（16進）
--
-- @param buf    integer  バッファ番号
-- @param delta  integer  +1 で増加、-1 で減少
local function hex_increment(buf, delta)
  local win = vim.api.nvim_get_current_win()
  local pos = vim.api.nvim_win_get_cursor(win)
  local row, col = pos[1], pos[2]  -- row: 1-indexed, col: 0-indexed

  local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]
  if not line or not is_hex_line(line) then return end

  -- hex 部分（列 0-38）以外では何もしない
  if col > 38 then return end

  local char = line:sub(col + 1, col + 1)
  if not char:match("[0-9a-fA-F]") then return end  -- スペース上などは無視

  -- カウント付き操作に対応（例: 3<C-A> → +3）
  -- Lua の % は除数が正なら常に非負を返すため、ラップアラウンドも正しく動作する
  local val     = tonumber(char, 16)
  local new_val = (val + delta * vim.v.count1) % 16
  local new_char = string.format("%x", new_val)

  local new_line = line:sub(1, col) .. new_char .. line:sub(col + 2)
  vim.api.nvim_buf_set_lines(buf, row - 1, row, false, { new_line })
  vim.api.nvim_win_set_cursor(win, { row, col })
end

-- xxd モードの共通インフラ（statuscolumn / autocmds / listener / keymap）を設定する
-- enable_xxd・enable_xxd_new の両方から呼ばれる
--
-- @param buf       integer  バッファ番号
-- @param filename  string   関連ファイルパス
local function setup_xxd_mode(buf, filename)
  -- 現在のウィンドウにオフセット表示を設定し、元の設定を保存する
  local win_settings = {}
  local cur_win = vim.api.nvim_get_current_win()
  win_settings[cur_win] = apply_win_display(cur_win)

  local augroup = vim.api.nvim_create_augroup("myxxd_buf_" .. buf, { clear = true })

  -- このバッファがカレントバッファになった時にオフセット表示を適用する
  -- BufWinEnter より確実に「表示中のウィンドウ」を捕捉できる
  vim.api.nvim_create_autocmd("BufEnter", {
    buffer   = buf,
    group    = augroup,
    callback = function()
      local win = vim.api.nvim_get_current_win()
      if not win_settings[win] then
        win_settings[win] = apply_win_display(win)
      end
    end,
  })

  -- このバッファが非アクティブになる直前にウィンドウ設定を復元する
  -- BufLeave はバッファ切り替えの直前に発火するため、
  -- 切り替え後のバッファに xxd の statuscolumn が漏れない
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer   = buf,
    group    = augroup,
    callback = function()
      local win = vim.api.nvim_get_current_win()
      local saved = win_settings[win]
      if saved then
        restore_win_display(win, saved)
        win_settings[win] = nil
      end
    end,
  })

  -- 保存時の処理: BufWriteCmd でファイル書き込みを完全に制御する
  -- バッファは hex 表示のまま保持し、バイナリ変換はバッファ外で行う
  vim.api.nvim_create_autocmd("BufWriteCmd", {
    buffer   = buf,
    group    = augroup,
    callback = function(ev)
      local target = (ev.file ~= nil and ev.file ~= "") and ev.file or filename
      if write_binary(buf, target) then
        vim.bo[buf].modified = false
        vim.notify("[myxxd] 保存完了: " .. vim.fn.fnamemodify(target, ":~:."), vim.log.levels.INFO)
      end
    end,
  })

  -- バッファ終了時にすべてのウィンドウの表示設定を復元してクリーンアップする
  vim.api.nvim_create_autocmd({ "BufUnload", "BufDelete" }, {
    buffer   = buf,
    group    = augroup,
    once     = true,
    callback = function()
      local state = xxd_state[buf]
      if state then
        for win, saved in pairs(state.win_settings) do
          restore_win_display(win, saved)
        end
        pcall(vim.api.nvim_del_augroup_by_id, state.augroup)
        xxd_state[buf] = nil
      end
    end,
  })

  attach_listener(buf)

  -- <Tab> で hex ↔ ASCII の対応バイトにジャンプする（バッファローカル）
  -- バッファ削除時に自動で解除されるため cleanup 不要
  vim.keymap.set("n", "<Tab>", function()
    jump_to_pair(buf)
  end, { buffer = buf, desc = "[myxxd] hex ↔ ASCII 対応バイトにジャンプ" })

  -- <C-A>/<C-X>: カーソル下の hex 1桁を 16 進数の範囲で加減する
  vim.keymap.set("n", "<C-A>", function()
    hex_increment(buf, 1)
  end, { buffer = buf, desc = "[myxxd] nibble を hex で +1（カウント対応）" })

  vim.keymap.set("n", "<C-X>", function()
    hex_increment(buf, -1)
  end, { buffer = buf, desc = "[myxxd] nibble を hex で -1（カウント対応）" })

  xxd_state[buf] = {
    filename     = filename,
    augroup      = augroup,
    win_settings = win_settings,
  }

  vim.notify("[myxxd] xxdモード有効: " .. vim.fn.fnamemodify(filename, ":t"), vim.log.levels.INFO)
end

-- 既存バイナリファイルのバッファを xxd モードにする
--
-- @param buf  integer  バッファ番号
local function enable_xxd(buf)
  if xxd_state[buf] then
    vim.notify("[myxxd] このバッファはすでにxxdモードです", vim.log.levels.WARN)
    return
  end
  if vim.fn.executable("xxd") == 0 then
    vim.notify("[myxxd] xxd が見つかりません（PATH を確認してください）", vim.log.levels.ERROR)
    return
  end
  local filename = vim.api.nvim_buf_get_name(buf)
  if filename == "" then
    vim.notify("[myxxd] バッファにファイルが関連付けられていません", vim.log.levels.ERROR)
    return
  end

  -- バッファを hex 表示に変換（:%!xxd 相当）
  vim.cmd("silent! %!xxd")
  if vim.v.shell_error ~= 0 then
    vim.notify("[myxxd] xxd の実行に失敗しました", vim.log.levels.ERROR)
    return
  end

  -- オフセット部分を除去する（行番号列の statuscolumn で表示するため）
  -- "xxxxxxxx: rest" → "rest"
  do
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    for i, line in ipairs(lines) do
      lines[i] = line:match("^%x%x%x%x%x%x%x%x: (.+)$") or line
    end
    -- xxd 変換と同じ undo ブロックにまとめる（u で一括 undo できるようにする）
    pcall(vim.cmd, "undojoin")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end

  setup_xxd_mode(buf, filename)
end

-- 空のバッファに hex テンプレートを挿入して xxd モードにする（新規バイナリ作成用）
-- バッファに内容があるときはエラーとする（誤操作防止）
--
-- @param buf  integer  バッファ番号
local function enable_xxd_new(buf)
  if xxd_state[buf] then
    vim.notify("[myxxd] このバッファはすでにxxdモードです", vim.log.levels.WARN)
    return
  end
  if vim.fn.executable("xxd") == 0 then
    vim.notify("[myxxd] xxd が見つかりません（PATH を確認してください）", vim.log.levels.ERROR)
    return
  end
  local filename = vim.api.nvim_buf_get_name(buf)
  if filename == "" then
    vim.notify("[myxxd] バッファにファイルが関連付けられていません", vim.log.levels.ERROR)
    return
  end

  -- バッファが空（または空白行のみ）でなければ :Myxxd を案内してエラー終了
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line:match("%S") then
      vim.notify("[myxxd] バッファが空ではありません。既存ファイルには :Myxxd を使ってください", vim.log.levels.ERROR)
      return
    end
  end

  -- 16バイト分のゼロを1行テンプレートとして挿入する
  -- フォーマット: hex(39文字) + "  " + ASCII(16文字)
  -- ゼロバイトは非印字文字なので ASCII 側はすべて '.'
  local template = "0000 0000 0000 0000 0000 0000 0000 0000  ................"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { template })

  -- カーソルを先頭（hex 入力開始位置）へ
  vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { 1, 0 })

  setup_xxd_mode(buf, filename)
end

-- :Myxxd コマンドを登録（既存バイナリ用）
-- ※ Neovim のユーザーコマンドは大文字始まりが必須
vim.api.nvim_create_user_command("Myxxd", function()
  enable_xxd(vim.api.nvim_get_current_buf())
end, {
  desc = "現在のバッファをxxdのhex編集モードにする（オフセットは行番号列に表示）",
})

-- :MyxxdNew コマンドを登録（新規バイナリ作成用）
-- 空バッファにテンプレートを挿入してから xxd モードに入る
vim.api.nvim_create_user_command("MyxxdNew", function()
  enable_xxd_new(vim.api.nvim_get_current_buf())
end, {
  desc = "空バッファにhexテンプレートを挿入してxxdモードにする（新規バイナリ作成用）",
})
