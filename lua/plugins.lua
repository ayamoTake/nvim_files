return {
  -- -- 移動系
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


  { "numToStr/Comment.nvim", lazy = false }, -- 起動時読み込みでもOK

  -- -- ツリー表示
  -- { 
  --     "nvim-tree/nvim-tree.lua",
  --     dependencies = { "nvim-tree/nvim-web-devicons" },
  --     config = function()
  --       vim.g.loaded_netrw = 1
  --       vim.g.loaded_netrwPlugin = 1
  --
  --       -- optionally enable 24-bit colour
  --       vim.opt.termguicolors = true
  --
  --       local function my_on_attach(bufnr)
  --         local api = require "nvim-tree.api"
  --
  --         local function opts(desc)
  --           return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  --         end
  --
  --         -- default mappings
  --         api.config.mappings.default_on_attach(bufnr)
  --
  --         -- custom mappings
  --         vim.keymap.del('n', '<CR>', { buffer = bufnr })
  --         vim.keymap.set('n', '<CR>',   api.node.open.vertical, opts('Open: Vertical Split'))
  --         vim.keymap.del('n', '<Tab>', { buffer = bufnr })
  --         vim.keymap.set('n', '<Tab>',   api.node.open.tab, opts('Open: New Tab'))
  --         vim.keymap.set('n', '?',     api.tree.toggle_help, opts('Help'))
  --         vim.keymap.del('n', 'u', { buffer = bufnr })
  --         vim.keymap.set('n', 'u',       api.tree.change_root_to_parent, opts('Up'))
  --         vim.keymap.set('n', 'cd',   api.tree.change_root_to_node, opts('CD'))
  --       end
  --
  --       -- vim.keymap.del('n', '<Leader>e')
  --       vim.keymap.set('n', '<Leader>e', '<Cmd>NvimTreeOpen<CR>', {silent = true})
  --
  --       -- pass to setup along with your other options
  --       require("nvim-tree").setup {
  --         filters = {
  --           dotfiles = true,
  --         },
  --         on_attach = my_on_attach,
  --         actions = {
  --           open_file = {
  --             window_picker = {
  --               -- enable = false,
  --               enable = true,
  --             },
  --           },
  --         },
  --       }
  --
  --     end
  -- },

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
      "tzachar/cmp-fuzzy-buffer",
      "tzachar/fuzzy.nvim",
      "romgrk/fzy-lua-native",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require'cmp'
      local timer = vim.loop.new_timer()
      vim.api.nvim_create_autocmd("TextChangedI", {
        callback = function()
          timer:stop()
          timer:start(400, 0, vim.schedule_wrap(function()
            local col = vim.fn.col('.') - 1
            local line = vim.fn.getline('.')
            if col > 0 and line:sub(col, col):match('[%w_$]') then
              cmp.complete()
            end
          end))
        end,
      })
      local compare = require('cmp.config.compare')

      cmp.setup({
        completion = {
          autocomplete = false -- { cmp.TriggerEvent.TextChanged },
        },
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require('cmp_fuzzy_buffer.compare'),
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          }
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
            { name = 'fuzzy_buffer' },
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
          }, {
            { name = 'buffer' },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = function(entry, vim_item)
            -- ソース名のプレフィックスを追加
            vim_item.menu = ({
              fuzzy_buffer = "[Fuzzy]",
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
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
       vim.opt.hidden = true -- 未保存でも閉じてよい
       require('telescope').load_extension("file_browser")
       -- require('telescope').load_extension("fzf")
       require('telescope').load_extension('media_files')
       require("telescope").setup ({
           -- defaults = require("telescope.themes").get_cursor({
           defaults = {
               initial_mode = 'normal',
               layout_strategy = 'vertical',
               layout_config = {
                 vertical = {
                   height = function(_, _, max_lines) return max_lines end,
                   preview_cutoff = 0,
                   preview_height = 0.5,
                   prompt_position = "top",
                 }                
               },
               mappings = {
                   ["n"] = {
                       ["q"] = require("telescope.actions").close,
                       ["<CR>"] = require("telescope.actions").select_tab_drop,
                       ["g<CR>"] = require("telescope.actions").select_default,
                       ["p"] = require("telescope.actions.layout").toggle_preview,
                       ["P"] = require("telescope.actions").paste_register,
                   },
                   ["i"] = {
                       ["<CR>"] = require("telescope.actions").select_tab_drop,
                   }
               }
           -- }),
           },
           picker = {
               registers = {
                   mappings = {
                       ["n"] = {
                           ["<C-p>"] = require("telescope.actions").paste_register,
                       },
                   },
               }
           },
           extensions = {
              file_browser = {
                    theme = "cursor",
                    -- disables netrw and use telescope-file-browser in its place
                    -- hijack_netrw = true,
                    depth = 3,
                    auto_depth = true,
                    files = true,
                    add_dirs = false,
                    mappings = {
                      ["i"] = {
                        -- your custom insert mode mappings
                      },
                      ["n"] = {
                        -- your custom normal mode mappings
                      },
                    },
                  },
               media_files = {
                    filetypes = {"png", "webp", "jpg", "jpeg"},
                    find_cmd = "rg",
               }
           },
       })

       local opts = require("telescope.themes").get_cursor {
            sort_mru = true,
            previewer = false,
            ignore_current_buffer = true,
               layout_config = {
                 cursor = {
                   height = 0.5,
                    preview_cutoff = 0,
                    preview_width = 0.4,
                 }                
               },
        }

      local function new_opts(src)
        return vim.tbl_deep_extend("force", {}, opts, src)
      end

      local opts_default_cr = new_opts({
        attach_mappings = function(_, map)
          map("n", "<CR>", require('telescope.actions').select_default)
          return true
        end
      })

      local builtin = require('telescope.builtin')
      local initial_insert_opt = new_opts({
        initial_mode = 'insert',
      })

      vim.keymap.set('n', '<Leader>ll',  function() builtin.buffers(opts) end)
      vim.keymap.set('n', '<Leader>lf', function() builtin.find_files(initial_insert_opt) end)
      vim.keymap.set('v', '<Leader>lr', function() builtin.registers(opts_default_cr) end)
      vim.keymap.set('n', '<Leader>lr', function() builtin.registers(opts_default_cr) end)

      local wide_previewer = {
        previewer = true,
        layout_config = {
          cursor = {
            preview_width = 0.8,
          }
        },
      }

      vim.keymap.set('n', '<Leader>lj', function() builtin.jumplist(new_opts(wide_previewer)) end)
      vim.keymap.set('n', '<Leader>j',  function() builtin.jumplist(new_opts(wide_previewer)) end)
      vim.keymap.set('n', '<Leader>lm',  function() builtin.marks(new_opts(wide_previewer)) end)
      vim.keymap.set('n', '<Leader>lg', function() builtin.live_grep(new_opts({ 
        previewer = true,
        initial_mode = 'insert',
      })) end)

      vim.keymap.set('n', '<Leader>lo', function() builtin.oldfiles(opts) end)
      vim.keymap.set('n', '<Leader>lb', function() 
        require("telescope").extensions.file_browser.file_browser(opts) 
      end)
    end
  },

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

  -- Markdown 系
  {
      "kannokanno/previm",
      ft = "markdown",
  },
  {
      "godlygeek/tabular",
      ft = "markdown",
  },
  {
      "preservim/vim-markdown",
      ft = "markdown",
      config = function()
          vim.g.vim_markdown_folding_disabled = 1
      end
  },

  -- Typst
  { 
      "kaarmu/typst.vim",
      ft = "typst",
      config = function()
        vim.g.typst_embedded_languages = {'c', 'cpp', 'python', 'rust', 'java', 'diff', }
        vim.g.typst_pdf_viewer = "tdf"
        vim.g.typst_auto_open_quickfix = 0
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
        autojump = true,
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
  --   opts = {
  --     -- add any options here
  --     notify = {
  --         -- Noice can be used as `vim.notify` so you can route any notification like other messages
  --         -- Notification messages have their level and other properties set.
  --         -- event is always "notify" and kind can be any log level as a string
  --         -- The default routes will forward notifications to nvim-notify
  --         -- Benefit of using Noice for this is the routing and consistent history view
  --         enabled = false,
  --         view = "notify",
  --     },
  --     background_colour = "#000000",                                                                          │
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   },
  -- },
}
