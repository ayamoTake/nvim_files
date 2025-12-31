local set = vim.keymap.set

local mapping = {
    -- { mode = "n", from = "j", to = "gj" },
    -- { mode = "n", from = "k", to = "gk" },
    { mode = "i", from = "uu", to = "<Esc>" },
    { mode = "i", from = "jj", to = "<Esc>" },
    { mode = "n", from = "<C-j>", to = "gj" },
    { mode = "n", from = "<C-k>", to = "gk" },
    { mode = "", from = "K", to = "{" },
    { mode = "", from = "J", to = "}" },
    { mode = "", from = "H", to = "^" },
    { mode = "", from = "L", to = "$" },
    { mode = "", from = "G", to = "G" },
    { mode = "n", from = "O", to = "O" },
    { mode = "n", from = "{", to = "{" },
    { mode = "n", from = "}", to = "}" },
    { mode = "n", from = "gh", to = "<C-w>h" },
    { mode = "n", from = "gj", to = "<C-w>j" },
    { mode = "n", from = "gk", to = "<C-w>k" },
    { mode = "n", from = "gl", to = "<C-w>l" },

    -- 連続ペースト
    { mode = "x", from = "p", to = '"_xP' },

    { mode = "n", from = "<CR>", to = "A<CR><Esc>0D" },
    { mode = "n", from = "s", to = '"_s' },
    { mode = "n", from = "<Leader>a", to = 'ggVG' },
    { mode = "v", from = "<Leader>a", to = '<Esc>ggVG' },
    { mode = "n", from = "mm", to = '`' },

    { mode = "t", from = "uu", to = "<C-\\><C-n>" },
    { mode = "t", from = "jj", to = "<C-\\><C-n>" },
    { mode = "t", from = "<Esc>", to = "<C-\\><C-n>" },
    { mode = "n", from = "gcu", to = 'vgU' },
    { mode = "v", from = "gcu", to = 'vgU' },
    { mode = "n", from = "gcl", to = 'vgu' },
    { mode = "v", from = "gcl", to = 'vgu' },
    { mode = "n", from = "dp", to = 'dap' },

    -- count character in curent line
    { mode = "v", from = "m", to = ':w !wc -m<CR>' },

    { mode = "n", from = "<Leader><Leader>t", to = ':tabnew | term<CR>' },


    { mode = "n", from = "<Leader>s", to = ':sp<CR>' },
    { mode = "n", from = "<Leader>v", to = ':vs<CR>' },
}

for _, m in pairs(mapping) do
    set(m.mode, m.from, m.to, { noremap = true, silent = true })
end

vim.api.nvim_create_user_command("Q", "q!", {})
