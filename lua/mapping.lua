local set = vim.keymap.set

local mapping = {
    { mode = "n", from = "j", to = "gjzz" },
    { mode = "n", from = "k", to = "gkzz" },
    { mode = "i", from = "uu", to = "<Esc>" },
    { mode = "i", from = "jj", to = "<Esc>" },
    -- { mode = "i", from = "<CR>", to = "<CR><C-o>zz" },
    { mode = "n", from = "<C-j>", to = "gj" },
    { mode = "n", from = "<C-k>", to = "gk" },
    { mode = "", from = "K", to = "{zz" },
    { mode = "", from = "J", to = "}zz" },
    { mode = "", from = "H", to = "^" },
    { mode = "", from = "L", to = "$" },
    { mode = "", from = "G", to = "Gzz" },
    { mode = "n", from = "o", to = "o<C-o>zz" },
    { mode = "n", from = "O", to = "zzO" },
    { mode = "n", from = "{", to = "{zz" },
    { mode = "n", from = "}", to = "}zz" },
    { mode = "n", from = "<Leader>h", to = "<C-w>h" },
    { mode = "n", from = "<Leader>j", to = "<C-w>j" },
    { mode = "n", from = "<Leader>k", to = "<C-w>k" },
    { mode = "n", from = "<Leader>l", to = "<C-w>l" },

    -- 連続ペースト
    { mode = "x", from = "p", to = '"_xP' },

    { mode = "n", from = "<CR>", to = "A<CR><Esc>0Dzz" },
    { mode = "n", from = "s", to = '"_s' },
    { mode = "n", from = "<Leader>a", to = 'ggVG' },
    { mode = "v", from = "<Leader>a", to = '<Esc>ggVG' },
    { mode = "n", from = "mm", to = '`' },

    { mode = "t", from = "uu", to = "<C-\\><C-n>" },
    { mode = "t", from = "jj", to = "<C-\\><C-n>" },
    { mode = "t", from = "<Esc>", to = "<C-\\><C-n>" },
    { mode = "n", from = "gu", to = 'vgU' },
    { mode = "v", from = "gu", to = 'vgU' },
    { mode = "n", from = "gl", to = 'vgu' },
    { mode = "v", from = "gl", to = 'vgu' },
    { mode = "n", from = "dp", to = 'dap' },

    -- inoremap <CR> <C-g>u<C-o>zz<CR>

    -- count character in curent line
    { mode = "v", from = "m", to = ':w !wc -m<CR>' },

    { mode = "n", from = "<Leader><>Leadert", to = ':tabnew | term<CR>' },
}

for _, m in pairs(mapping) do
    set(m.mode, m.from, m.to, { noremap = true, silent = true })
end

vim.api.nvim_create_user_command("Q", "q!", {})
