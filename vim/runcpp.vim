
lua << EOF

local function compile_and_run_c(flag, file_op)
    -- 保存
    vim.cmd('wa')

    local current_file = vim.fn.expand('%')

    if not current_file:match('%.c$') then
        return
    end

    local executable = current_file:gsub('%.c$', '') .. file_op
    local compile_cmd = 'gcc -o ' .. executable .. ' -Wall ' .. current_file .. ' ' .. flag
    local run_cmd = './' .. executable

    local term_cmd = 'bash -c "' .. compile_cmd .. ' && ' .. run_cmd .. '"'

    -- Neovim のターミナルでコマンドを実行
    vim.cmd('split' .. '|' .. 'terminal ' .. term_cmd)
end

-- コマンドを作成する
vim.api.nvim_create_user_command('CompileAndRunC', function(opts)
    local args = vim.split(opts.args, ' ')
    compile_and_run_c(args[1] or '', args[2] or '')
end, { nargs = '*' })


-- Lua でのファイルタイプごとのキーマッピング設定

-- この関数を使用して、C ファイルタイプに特定のキーマッピングを追加します。
local function set_c_keymaps()
    -- ノーマルモードで <C-u> に :Crun コマンドをマップする
    vim.api.nvim_set_keymap('n', '<C-u>', ':CompileAndRunC<CR>', { noremap = true, silent = true })
end

-- C ファイルタイプのときに上記のキーマッピングを設定する autocmd を定義
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'c',
    callback = set_c_keymaps
})


local function compile_and_run_cpp(flag, file_op)
    -- 保存
    vim.cmd('write')

    local current_file = vim.fn.expand('%')

    if not current_file:match('%.cpp$') then
        return
    end

    local executable = current_file:gsub('%.cpp$', '') .. file_op
    local compile_cmd = 'g++ -o ' .. executable .. ' -Wall -std=c++20 ' .. current_file .. ' ' .. flag
    local run_cmd = './' .. executable

    local term_cmd = 'bash -c "' .. compile_cmd .. ' && ' .. run_cmd .. '"'

    -- Neovim のターミナルでコマンドを実行
    vim.cmd('split' .. '|' .. 'terminal ' .. term_cmd)
end

-- コマンドを作成する
vim.api.nvim_create_user_command('CompileAndRunCpp', function(opts)
    local args = vim.split(opts.args, ' ')
    compile_and_run_cpp(args[1] or '', args[2] or '')
end, { nargs = '*' })


-- Lua でのファイルタイプごとのキーマッピング設定

-- この関数を使用して、C ファイルタイプに特定のキーマッピングを追加します。
local function set_cpp_keymaps()
    -- ノーマルモードで <C-u> に :Crun コマンドをマップする
    vim.api.nvim_set_keymap('n', '<C-u>', ':CompileAndRunCpp<CR>', { noremap = true, silent = true })
end

-- C ファイルタイプのときに上記のキーマッピングを設定する autocmd を定義
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'cpp',
    callback = set_cpp_keymaps
})

EOF

