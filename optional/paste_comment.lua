-- Neovim の Lua 設定ファイル (init.lua など)

local api = require('Comment.api')

-- ペースト前にカーソル位置を記録
local paste_start = 0
local paste_end = 0

local function record_paste_start()
    paste_start = vim.fn.line('.')
end

local function record_paste_end()
    paste_end = vim.fn.line('.')
end

local function paste_and_commentout()
    record_paste_start()
    -- ペースト操作
    vim.cmd('normal! gp')

    -- ペースト後のカーソル位置を記録
    record_paste_end()

    -- コメントアウトする範囲が有効であるかを確認
    if paste_start > 0 and paste_end ~= paste_start then
        -- 範囲の開始行が終了行よりも前であるかを確認
        if paste_start > paste_end then
            paste_start, paste_end = paste_end, paste_start
        end

	-- vim.api.nvim_err_writeln(tostring(paste_start))
	-- vim.api.nvim_err_writeln(tostring(paste_end))

        -- コメントアウトする
	local motion = tostring(paste_end - paste_start + 1) .. 'k'

	-- vim.api.nvim_err_writeln(motion)
	api.toggle.linewise(motion)
    end

    -- グローバル変数をリセット
    paste_start = 0
    paste_end = 0
end

local function copy_and_paste_comment()
    -- ビジュアル選択範囲をコピー
    vim.cmd('normal! vip')  -- 選択範囲をビジュアルモードで選択
    vim.cmd('normal! y')   -- コピー

    -- 左隣のウィンドウに移動
    vim.cmd('wincmd h')

    -- :PasteAndCommentout コマンドを実行
    paste_and_commentout()
end

-- コマンドを作成する
vim.api.nvim_create_user_command('CopyAndPasteComment', function(opts)
    copy_and_paste_comment()
end, { nargs = '*' })

-- キーマッピングを設定 (例: <leader>pc で関数を呼び出す)
vim.api.nvim_set_keymap('n', '<leader>p', ':CopyAndPasteComment<CR>', { noremap = true, silent = true })
