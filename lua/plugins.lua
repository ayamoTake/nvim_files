return {

  -- 移動系
  { 
      "easymotion/vim-easymotion",
      config = function()
        vim.keymap.set('', 'ff', '<Plug>(easymotion-overwin-w)')
        vim.keymap.set('n', '<Leader>', '<Plug>(easymotion-prefix)')
      end,
  },

  -- -- カラースキーム
  { 
      "Mofiqul/vscode.nvim",
      config = function()
        vim.cmd.colorscheme "vscode"
      end
  },

  -- コメント系
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
  -- { "williamboman/mason.nvim", version = "v1.9.0" },
  {
      "williamboman/mason-lspconfig.nvim",
      -- version = "v1.22.0",
      dependencies = {"neovim/nvim-lspconfig", "williamboman/mason.nvim", },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
      end
  },

  -- LSP 補完
  {
      "hrsh7th/nvim-cmp",
      dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "hrsh7th/cmp-vsnip",
          "hrsh7th/cmp-vsnip",
          "hrsh7th/vim-vsnip",
          "hrsh7th/vim-vsnip-integ",
      },
      event = "InsertEnter",
      config = function()
        local cmp = require'cmp'

        cmp.setup({
          completion = {
              autocomplete = false,
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
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
          }, {
            { name = 'buffer' },
          }),
          window = {
            -- Uncomment to enable borders
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
          },
        })

        -- Optional: Git completion in gitcommit filetype
        --[[ 
        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'git' },
          }, {
            { name = 'buffer' },
          }),
        })
        require("cmp_git").setup()
        ]]

        -- Command-line completion

        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        -- cmp.setup.cmdline(':', {
        --   mapping = cmp.mapping.preset.cmdline(),
        --   sources = cmp.config.sources({
        --     { name = 'path' }
        --   }, {
        --     -- { name = 'cmdline' }
        --   }),
        --   matching = { disallow_symbol_nonprefix_matching = false }
        -- })

        -- LSP config
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Replace or add your own LSP servers here
        -- local lspconfig = require('lspconfig')
        -- local servers = { 'pyright', 'tsserver', 'clangd', 'lua_ls' }
        --
        -- for _, lsp in ipairs(servers) do
        --   lspconfig[lsp].setup {
        --     capabilities = capabilities,
        --   }
        -- end
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
          vim.keymap.set('n', '<Leader>l', function()
              require('telescope.builtin').buffers({
                  sort_mru = true,
                  -- previewer = false,
              })
          end, {desc='List and select buffers'})

         require('telescope').load_extension("file_browser")

          require("telescope").setup {
              defaults = {
                  initial_mode = 'normal',
                  previewer = false,
                  mappings = {
                      ["n"] = {
                          ["q"] = require("telescope.actions").close,
                          ["<CR>"] = require("telescope.actions").select_tab_drop,
                          ["g<CR>"] = require("telescope.actions").select_default,
                      },
                      ["i"] = {
                          ["<CR>"] = require("telescope.actions").select_tab_drop,
                          ["g<CR>"] = require("telescope.actions").select_default,
                      }
                  }
              }
          }
      end
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.keymap.set("n", "<Leader><Leader>l", function()
           require("telescope").extensions.file_browser.file_browser({
             hidden = true,
             respect_gitignore = false,
             grouped = false,
             -- previewer = false,
           })
        end, { desc = "Browse files (tab jump)" })
    end,
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
        vim.g.typst_embedded_languages = {'c', 'cpp', 'python', 'rust', 'java', }
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
  },

  {
      'joshuadanpeterson/typewriter',
      config = function()
          require('typewriter').setup({
              keep_cursor_position = true,
              enable_notifications = false,
              enable_horizontal_scroll = false,
              start_enabled = true,
              always_center = true,
              -- always_center_filetypes = {},
          })
      end,
      opts = {}
  },

  {
      'nguyenvukhang/nvim-toggler',
      config = function()
          require('nvim-toggler').setup({
              inverses = {
                  ['True'] = 'False',
                  ['Yes'] = 'No',
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

}

