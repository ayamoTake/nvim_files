-- 現在のバッファの全テキストを取得する関数
local function get_buffer_text()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    return table.concat(lines, "\n")
end

-- 文書全体に品詞ハイライトを適用する関数
local function jp_apply_highlight_pos()
    local text = get_buffer_text()
    -- Rust 関数 highlight_pos を呼び出す
    vim.api.nvim_command('call jp_highlight_pos("' .. text .. '")')
end

-- TextChanged イベントに対してハイライトを適用
vim.api.nvim_create_autocmd("TextChanged", {
    pattern = "*",
    callback = function()
        jp_apply_highlight_pos()
    end,
})

