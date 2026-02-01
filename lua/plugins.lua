return {

  -- 移動系
  { 
      "easymotion/vim-easymotion",
      config = function()
        vim.keymap.set('', 'ff', '<Plug>(easymotion-overwin-w)')
      end,
  },

  -- -- カラースキーム
  { 
      "Mofiqul/vscode.nvim",
      config = function()
        vim.cmd.colorscheme "vscode"
      end
  },


  { "numToStr/Comment.nvim", lazy = false },

  -- ツリー表示
  { 
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- vim.g.loaded_netrw = 1
        -- vim.g.loaded_netrwPlugin = 1

        -- optionally enable 24-bit colour
        vim.opt.termguicolors = true

        local function my_on_attach(bufnr)
          local api = require "nvim-tree.api"



          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- default mappings
         api.config.mappings.default_on_attach(bufnr)

          vim.cmd([[
          highlight NvimTreeNormal guifg=#d4d4d4 guibg=#252526 ctermbg=none guibg=none
          highlight NvimTreeCursorLine guibg=#373737 ctermbg=none guibg=none
          highlight NvimTreeNormalFloat ctermbg=none guibg=none
          highlight NvimTreeNormalNC    ctermbg=none guibg=none
          ]])

          -- custom mappings
          vim.keymap.del('n', '<CR>', { buffer = bufnr })
          vim.keymap.set('n', '<CR>',   api.node.open.tab, opts('Open: New Tab'))
          vim.keymap.del('n', '<C-v>', { buffer = bufnr })
          vim.keymap.set('n', '<C-v>',   api.node.open.vertical, opts('Open: Vertical Split'))
          vim.keymap.set('n', '<C-s>',   api.node.open.horizontal, opts('Open: Horizon Split'))
          vim.keymap.set('n', '?',     api.tree.toggle_help, opts('Help'))
          vim.keymap.del('n', 'u', { buffer = bufnr })
          vim.keymap.set('n', 'u',       api.tree.change_root_to_parent, opts('Up'))
          vim.keymap.del('n', 'd', { buffer = bufnr })
          vim.keymap.set('n', 'd',   api.tree.change_root_to_node, opts('CD'))
          vim.keymap.del('n', 'y', { buffer = bufnr })
          vim.keymap.set('n', 'y',   api.fs.copy.node, opts('Copy node'))
        end

        -- vim.keymap.del('n', '<Leader>e')
        vim.keymap.set('n', '<Leader>e', '<Cmd>NvimTreeOpen<CR>', {silent = true})

        -- pass to setup along with your other options
        require("nvim-tree").setup {
          filters = {
            dotfiles = true,
          },
          update_focused_file = {
            enable = true,
            update_root = false,
          },
          sync_root_with_cwd = true,
          view = {
            float = {
              enable = true,
              open_win_config = {
                relative = "cursor",
                border = "none",
                height = 10,
              },
            }
          },
          on_attach = my_on_attach,
          actions = {
            open_file = {
              window_picker = {
                enable = true,
              },
            },
          },
        }

      end
  },

  -- インデント可視化
  {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
            local highlight = {
                "RainbowBlue",
                "RainbowYellow",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
                "RainbowOrange",
            }

            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

          require("ibl").setup({
              indent = {
                  char = '╎',
                  highlight = highlight,
              },
              scope = { enabled = false },
          })
      end,
  },

  -- ターミナル統合
  { 
      "akinsho/toggleterm.nvim", 
      version = "*", 
      lazy = false,
      config = function() 
          vim.keymap.set('n', '<Leader>t', '<Cmd>lua require("toggleterm.terminal").Terminal:new():toggle()<CR>', {silent = true})
      end,
  },

  {
      "kassio/neoterm",
      config = function()
        vim.g.neoterm_default_mod = 'botright'
        -- c++ compile short cut.
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "cpp",
            callback = function()
                vim.keymap.set('n', '<Leader>u', function()
                    local filename = vim.fn.expand("%:p")
                    local cmd = string.format("g++ '%s' -o '%s' --std=c++20 -Wall", filename, "a.out")
                    vim.cmd("T " .. cmd)
                    vim.cmd("wincmd j")
                    vim.cmd("startinsert")
                    vim.api.nvim_feedkeys("./a.out ", "i", false)
                end)
            end
        })
      end
  },

  -- ターミナルのウィンドウ整理
  {
      "willothy/flatten.nvim",
      opt = {
        open = "alternate",
      },
  },

  -- 置換ツール
  { "tpope/vim-abolish" },

  -- スクショ
  { 
      "michaelrommel/nvim-silicon",
      lazy = true,
      cmd = "Silicon",
      main = "nvim-silicon",
      language = function()
          return vim.bo.filetype
      end,
      config = function()
          require('nvim-silicon').setup({
              theme = "Visual Studio Dark+",
              font = "Hack; Droid Sans Fallback",
              pad_horiz = 0,
              pad_vert = 0,
              shadow_blur_radius = 0,
              no_window_controls = true,
              no_round_corner = true,
              output = function(filename)
                  -- return "./" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
                  return "./" .. vim.fn.bufname() .. "_" .. os.date("!%Y%m%d%H%M%S") .. "_code.png"
              end,
          })
      end
  },

  {
    "ellisonleao/carbon-now.nvim",
    lazy = true,
    cmd = "CarbonNow",
    ---@param opts cn.ConfigSchema
    opts = { [[ your custom config here ]] }
  },

  -- Lean 向け
  {
      "Julian/lean.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      ft = "lean",
      opt = {
        mappings = true,
        lsp = {
            editDelay=10,
        },
      },
  },

  -- Lean スイッチ切替
  {
      "andrewradev/switch.vim",
      ft = "lean",
  },

  -- LSP
  { "williamboman/mason.nvim" },
  {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {"neovim/nvim-lspconfig", "williamboman/mason.nvim", },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
      end
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xL",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
    },
  },

   {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},

   -- スニペット
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
      "petertriho/cmp-git",
      -- "tzachar/cmp-fuzzy-buffer",
      -- "tzachar/fuzzy.nvim",
      -- "romgrk/fzy-lua-native",
    },
    -- event = "InsertEnter",
    config = function()
      local cmp = require'cmp'

      -- local timer = vim.loop.new_timer()
      -- vim.api.nvim_create_autocmd("TextChangedI", {
      --   callback = function()
      --     timer:stop()
      --     timer:start(400, 0, vim.schedule_wrap(function()
      --       local col = vim.fn.col('.') - 1
      --       local line = vim.fn.getline('.')
      --       if col > 0 and line:sub(col, col):match('[%w_$]') then
      --         cmp.complete()
      --       end
      --     end))
      --   end,
      -- })

      local compare = require('cmp.config.compare')

      cmp.setup({
        completion = {
          -- autocomplete = false -- { cmp.TriggerEvent.TextChanged },
          autocomplete = { cmp.TriggerEvent.TextChanged },
        },
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = function(fallback)
              if cmp.visible() then
                  cmp.confirm({ select = true })
              else
                  fallback()
              end
          end,
          ['<C-n>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ['<C-p>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          ['<TAB>'] = function(fallback)
            if vim.fn['vsnip#expandable']() == 1 then
                vim.fn['vsnip#expand']()
            elseif vim.fn['vsnip#jumpable'](1) == 1 then
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-next)", true, false, true),
                "",
                false
              )
            elseif cmp.visible() then
              cmp.select_next_item()
            else
                local col = vim.fn.col('.') - 1
                local line = vim.fn.getline('.')
                if col > 0 and line:sub(col, col):match('%S') then
                    -- C-p
                  cmp.complete()
                else
                  fallback()
                end
            end
          end,
        }),
        sources = cmp.config.sources({
            -- { name = 'fuzzy_buffer' },
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
          }, {
            { name = 'buffer' },
            { name = "path" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = function(entry, vim_item)
            -- ソース名のプレフィックスを追加
            vim_item.menu = ({
              -- fuzzy_buffer = "[Fuzzy]",
              nvim_lsp = "[LSP]",
              vsnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            vim_item.abbr = string.sub(vim_item.abbr, 1, 20) -- 文字数制限
            return vim_item
          end
        },
      })

      cmp.setup.filetype("markdown", {
        sources = cmp.config.sources({
          { name = "obsidian", keyword_length = 0 },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        }),
      })

      require("cmp_git").setup()

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- cmp.setup.cmdline('/', {
      --   sources = cmp.config.sources({
      --     { name = 'fuzzy_buffer' }
      --   })
      -- })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

    end
  },

  -- スニペット
  {
      "hrsh7th/vim-vsnip",
      config = function()
        vim.g.vsnip_snippet_dir = vim.fn.expand('$HOME/.config/nvim/plugin/vsnip')
      end
  },
  { "hrsh7th/vim-vsnip-integ" },

  -- コメント操作
  { "tomtom/tcomment_vim" },

  -- 検索
{
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.opt.hidden = true

    local fzf = require("fzf-lua")
    local actions = fzf.actions

    local function tabedit_or_jump(selected, opts)
      for _, sel in ipairs(selected) do
        local entry = require("fzf-lua.path")
          .entry_to_file(sel, opts, opts._uri)
        if not entry or not entry.path then return end
        vim.cmd(("tab drop %s"):format(
          vim.fn.fnameescape(entry.path)
        ))
      end
    end

    local function toggle_preview_and_resize()
      local win = require("fzf-lua.win")
      local utils = require("fzf-lua.utils")

      -- preview toggle
      win.toggle_preview()

      -- toggle 後にサイズを変える
      vim.schedule(function()
        local winid = utils.get_winid()
        if not winid then return end

        local cfg = vim.api.nvim_win_get_config(winid)

        -- preview が有効かどうか
        local preview_on = win.has_preview and win.has_preview() or false

        cfg.width = preview_on and 1.0 or 0.4
        vim.api.nvim_win_set_config(winid, cfg)
      end)
    end

    fzf.setup({
      winopts = {
        height = 0.5,
        width  = 0.4,

        relative = "cursor",
        border = "none",
        row = 1,
        col = 0,
        anchor = "NW",

        preview = {
          default = "bat",
          hidden = true,
          border = "none",
          layout = "horizontal",
          -- horizontal = "right:99%",
          scrollbar = false,
        },
      },

      fzf_opts = {
        ["--layout"] = "reverse",
      },

      keymap = {
        builtin = {
          ["esc"]    =  "close",
          ["ctrl-q"]    =  "close",
          ["ctrl-o"] = "toggle-preview", -- toggle_preview_and_resize, -- 
        },
        fzf = {
          ["esc"]    =  "close",
          ["ctrl-q"]    =  "close",
        },
      },

      buffers = {
        actions = {
          ["enter"] = tabedit_or_jump,
          ["ctrl-g"]  = actions.file_edit,
        },
      },

      files = {
        actions = {
          ["enter"] = tabedit_or_jump,
          ["ctrl-g"]  = actions.file_edit,
          ["ctrl-o"] = toggle_preview_and_resize, -- "toggle-preview",
        },
      },

      oldfiles = {
        actions = {
          ["enter"] = tabedit_or_jump,
          ["ctrl-g"]  = actions.file_edit,
        },
      },

      grep = {
        prompt = "Grep❯ ",
        actions = {
          ["enter"] = tabedit_or_jump,
          ["ctrl-g"]  = actions.file_edit,
        },
        winopts = {
          preview = {
            hidden = false,
          },
        }
      },

      jumps = {
        winopts = {
          preview = {
            hidden = false,
          },
        },
      },

      helptags = {
        actions = {
          ["enter"] = tabedit_or_jump,
          ["ctrl-g"]  = actions.file_edit,
        },
      },

      registers = {},
      marks = {},
      complete_path = {},
    })

    vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>",
      function() fzf.complete_path() end,
      { silent = true, desc = "Fuzzy complete path" })

    vim.keymap.set("n", "<Leader>ll", fzf.buffers)
    vim.keymap.set("n", "<Leader><Leader>l", fzf.buffers)
    vim.keymap.set("n", "<Leader>lh", fzf.helptags)
    vim.keymap.set("n", "<Leader>lf", fzf.files)

    vim.keymap.set({ "n", "v" }, "<Leader>lr", fzf.registers)

    vim.keymap.set("n", "<Leader>lj", fzf.jumps)
    vim.keymap.set("n", "<Leader>lm", fzf.marks)

    vim.keymap.set("n", "<Leader>lg", function()
      fzf.live_grep({ resume = false })
    end)

    vim.keymap.set("n", "<Leader>lo", fzf.oldfiles)
  end,
},

  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --      vim.opt.hidden = true -- 未保存でも閉じてよい
  --      require('telescope').load_extension("file_browser")
  --      -- require('telescope').load_extension("fzf")
  --      require('telescope').load_extension('media_files')
  --      require("telescope").setup ({
  --          -- defaults = require("telescope.themes").get_cursor({
  --          defaults = {
  --              initial_mode = 'normal',
  --              layout_strategy = 'vertical',
  --              layout_config = {
  --                vertical = {
  --                  height = function(_, _, max_lines) return max_lines end,
  --                  preview_cutoff = 0,
  --                  preview_height = 0.5,
  --                  prompt_position = "top",
  --                }                
  --              },
  --              mappings = {
  --                  ["n"] = {
  --                      ["q"] = require("telescope.actions").close,
  --                      ["<CR>"] = require("telescope.actions").select_tab_drop,
  --                      ["g<CR>"] = require("telescope.actions").select_default,
  --                      ["p"] = require("telescope.actions.layout").toggle_preview,
  --                      ["P"] = require("telescope.actions").paste_register,
  --                  },
  --                  ["i"] = {
  --                      ["<CR>"] = require("telescope.actions").select_tab_drop,
  --                  }
  --              }
  --          -- }),
  --          },
  --          picker = {
  --              registers = {
  --                  mappings = {
  --                      ["n"] = {
  --                          ["<C-p>"] = require("telescope.actions").paste_register,
  --                      },
  --                  },
  --              }
  --          },
  --          extensions = {
  --             file_browser = {
  --                   theme = "cursor",
  --                   -- disables netrw and use telescope-file-browser in its place
  --                   -- hijack_netrw = true,
  --                   depth = 3,
  --                   auto_depth = true,
  --                   files = true,
  --                   add_dirs = false,
  --                   mappings = {
  --                     ["i"] = {
  --                       -- your custom insert mode mappings
  --                     },
  --                     ["n"] = {
  --                       -- your custom normal mode mappings
  --                     },
  --                   },
  --                 },
  --              media_files = {
  --                   filetypes = {"png", "webp", "jpg", "jpeg"},
  --                   find_cmd = "rg",
  --              }
  --          },
  --      })
  --
  --      local opts = require("telescope.themes").get_cursor {
  --           sort_mru = true,
  --           previewer = false,
  --           ignore_current_buffer = true,
  --              layout_config = {
  --                cursor = {
  --                  height = 0.5,
  --                   preview_cutoff = 0,
  --                   preview_width = 0.4,
  --                }                
  --              },
  --       }
  --
  --     local function new_opts(src)
  --       return vim.tbl_deep_extend("force", {}, opts, src)
  --     end
  --
  --     local opts_default_cr = new_opts({
  --       attach_mappings = function(_, map)
  --         map("n", "<CR>", require('telescope.actions').select_default)
  --         return true
  --       end
  --     })
  --
  --     local builtin = require('telescope.builtin')
  --     local initial_insert_opt = new_opts({
  --       initial_mode = 'insert',
  --     })
  --
  --     vim.keymap.set('n', '<Leader>ll',  function() builtin.buffers(opts) end)
  --     vim.keymap.set('n', '<Leader>lh',  function() builtin.help_tags(opts) end)
  --     vim.keymap.set('n', '<Leader>lf', function() builtin.find_files(initial_insert_opt) end)
  --     vim.keymap.set('v', '<Leader>lr', function() builtin.registers(opts_default_cr) end)
  --     vim.keymap.set('n', '<Leader>lr', function() builtin.registers(opts_default_cr) end)
  --
  --     local wide_previewer = {
  --       previewer = true,
  --       layout_config = {
  --         cursor = {
  --           preview_width = 0.8,
  --         }
  --       },
  --     }
  --
  --     vim.keymap.set('n', '<Leader>lj', function() builtin.jumplist(new_opts(wide_previewer)) end)
  --     vim.keymap.set('n', '<Leader>j',  function() builtin.jumplist(new_opts(wide_previewer)) end)
  --     vim.keymap.set('n', '<Leader>lm',  function() builtin.marks(new_opts(wide_previewer)) end)
  --     vim.keymap.set('n', '<Leader>lg', function() builtin.live_grep(new_opts({ 
  --       previewer = true,
  --       initial_mode = 'insert',
  --     })) end)
  --
  --     vim.keymap.set('n', '<Leader>lo', function() builtin.oldfiles(opts) end)
  --     vim.keymap.set('n', '<Leader>lb', function() 
  --       require("telescope").extensions.file_browser.file_browser(opts) 
  --     end)
  --   end
  -- },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "nvim-telescope/telescope-media-files.nvim",
    dependencies = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'nvim-telescope/telescope-media-files.nvim',
    },
  },

  -- コード成型
  {
      "godlygeek/tabular",
  },

  -- Markdown 系
  {
      "preservim/vim-markdown",
      ft = "markdown",
      config = function()
          vim.g.vim_markdown_folding_disabled = 1
          vim.g.vim_markdown_conceal_code_blocks = 0
      end
  },

  -- {
  --     'MeanderingProgrammer/render-markdown.nvim',
  --     dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --     config = function ()
  --       require('render-markdown').setup({
  --         bullet   = { enabled = false, },
  --         checkbox = { enabled = false, },
  --       })
  --     end
  -- },

  -- Typst
  { 
      "kaarmu/typst.vim",
      ft = "typst",
      config = function()
        vim.g.typst_embedded_languages = {'c', 'cpp', 'python', 'rust', 'java', 'diff', }
        vim.g.typst_pdf_viewer = "open --root .."
        -- vim.g.typst_auto_open_quickfix = 0
      end
  },

  -- 自動括弧補完など
  { 
      "cohama/lexima.vim",
      config = function()
          vim.g.lexima_enable_basic_rules = 1
          vim.g.lexima_enable_newline_rules = 1
          vim.g.lexima_enable_endwise_rules = 1
      end
  },

  -- 括弧で囲む
  {
      "kylechui/nvim-surround",
      version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              keymaps = {
                  normal = "<Leader>s",
                  visual = "s",
                  delete = "<Leader>sd",
                  change = "<Leader>sc",
              }
          })
      end
  },
  -- その他
  {
      "edvb/catium.vim",
      config = function()
          vim.o.statusline = vim.o.statusline:gsub("%%=", "%%=%%{g:Catium()}")
      end
  },

  {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        -- require('nvim-treesitter.configs').setup({
        --   ensure_installed = {
        --     "bash", "c", "cpp", "go", "html", "javascript", "json", "lua", "markdown", "markdown_inline", "python", "query", "rust", "tsx", "typescript", "vim", "vimdoc", "yaml"
        --   },
        --   auto_install = true,
        --   highlight = {
        --     enable = true,
        --   },
          -- indent = { enable = true },
        -- })
      end,
  },

  {
      'nguyenvukhang/nvim-toggler',
      config = function()
          require('nvim-toggler').setup({
              inverses = {
                  ['True'] = 'False',
                  ['Yes'] = 'No',
                  ['UP'] = 'DOWN',
                  ['LEFT'] = 'RIGHT',
                  ['width'] = 'height',
                  ['左'] = '右',
                  ['←'] = '→',
                  ['>'] = '<=',
                  ['<'] = '>=',
                  ['&&'] = '||',
                  ['&'] = '|',
              },
              remove_default_keybinds = true,
              autoselect_longest_match = true,
          })
          vim.keymap.set({ 'n', 'v' }, '<leader>i', require('nvim-toggler').toggle)
      end,
      opts = {}
  },

  {
      'junegunn/fzf',
  },

  {
      'chrisbra/unicode.vim',
      config = function()
          vim.g.Unicode_no_default_mappings = true
          vim.keymap.set('n', '<Leader>uf', '<Cmd>call unicode#Fuzzy()<CR>', {silent = true})
          vim.keymap.set('n', 'ga', '<Plug>(UnicodeGA)')
          vim.keymap.set('v', '<Leader>um', '<Plug>(MakeDigraph)')
      end
  },

  {
    "vim-jp/vimdoc-ja",
    config = function()
      vim.opt.helplang = 'ja'
    end
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      search = {
        mode = "fuzzy",
        incremental = true,
      },
      modes = {
        search = {
          search = { incremental = true },
        },
        char = {
          jump_labels = true
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
      { "<Leader>/", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "<Leader><Leader>/", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<Leader><Leader><Leader>/", mode = { "n", "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-/>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function()
  --     require("noice").setup({
  --       cmdline = {
  --         format = {
  --           filter = {
  --             view = "split",
  --             pattern = "^:%s*!",
  --             icon = "$",
  --             lang = "bash",
  --             event = "msg_show"
  --           },
  --         },
  --       },
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --         },
  --       },
  --       -- you can enable a preset for easier configuration
  --       presets = {
  --         -- bottom_search = true, -- use a classic bottom cmdline for search
  --         -- command_palette = true, -- position the cmdline and popupmenu together
  --         long_message_to_split = true, -- long messages will be sent to a split
  --         inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --         lsp_doc_border = false, -- add a border to hover docs and signature help
  --       },
  --       messages = {
  --         view_search = false, -- disable
  --       }
  --     })
  --
  --     -- require("notify").setup({
  --     --   background_colour = "#000000",
  --     -- })
  --     --
  --     -- vim.keymap.set('n', '<Leader><Leader>n', function()
  --     --   require('notify').dismiss { silent = true }
  --     -- end, { desc = 'Dismiss notifications' })
  --   end
  -- },

  {
    "obsidian-nvim/obsidian.nvim",
    ft = "markdown",
    config = function ()
      require("obsidian").setup({
        ui = {
          enable = true,
          bullets = { char = "-", hl_group = "ObsidianBullet" },
        },
        legacy_commands = false, -- this will be removed in the next major release
        workspaces = {
          {
            name = "personal",
            path = "/mnt/c/Users/ayamo/OneDrive/ドキュメント/nikki/links",
          },
        },
        footer = {
          enabled = false,
        },
        checkbox = {
          -- create_new = false,
          order = { " ", "x", ">", },
        },
        -- completion = {
        --   nvim_cmp = true,
        -- },
        callbacks = {
          enter_note = function (note)
            vim.keymap.del("n", "<CR>", { buffer = true }) -- remove smart action
            --
            local api = require "obsidian.api"
            vim.keymap.set("n", "x", function ()
              local line = vim.fn.getline('.')
              local is_start_with_bullet = line:match("^%s*[-*]%s")
              if api.cursor_checkbox() or (is_start_with_bullet and Obsidian.opts.checkbox.create_new) then
                 return "<cmd>Obsidian toggle_checkbox<cr>" 
              end
              return "x"
            end, {
              buffer = true,
              expr = true,
              desc = "Toggle checkbox",
            })
            vim.keymap.set("n", "<CR>", function ()
              -- see https://github.com/obsidian-nvim/obsidian.nvim/blob/main/lua/obsidian/actions.lua
              if api.cursor_link() then
                return "<cmd>Obsidian follow_link<cr>"
              elseif api.cursor_tag() then
                return "<cmd>Obsidian tags<cr>"
              end
              return 'A<CR><Esc>0"_D'
            end, {
              buffer = true,
              expr = true,
              desc = "my smart action on obsidian",
            })
          end
        }
      })
      vim.opt_local.conceallevel = 2
    end
  }
}
