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

            vim.notify(msg:sub(1, available_width))
            vim.notify(msg)

        end
    end,
})

