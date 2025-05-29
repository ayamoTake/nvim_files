return {
  -- 移動系
  { 
      "easymotion/vim-easymotion",
      config = function()
        vim.keymap.set('', 'ff', '<Plug>(easymotion-overwin-w)')
        vim.keymap.set('n', '<Leader>', '<Plug>(easymotion-prefix)')
      end,
  },

  -- カラースキーム
  { 
      "Mofiqul/vscode.nvim",
      config = function()
        vim.cmd.colorscheme "vscode"
      end
  },

  -- コメント系
  { "numToStr/Comment.nvim", lazy = false }, -- 起動時読み込みでもOK

  -- ツリー表示
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- インデント可視化
  {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
            local highlight = {
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
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

  -- ターミナルのウィンドウ整理
  {
      "willothy/flatten.nvim",
      config = function()
        require("flatten").setup({open = "alternate",})
      end
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

  -- Lean 向け
  {
      "Julian/lean.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      ft = "lean",
  },

  -- Lean スイッチ切替
  {
      "andrewradev/switch.vim",
      ft = "lean",
  },

  -- LSP
  {
      "neovim/nvim-lspconfig",
      config = function()
        require('lspconfig').clangd.setup({
            on_attach = function(client, bufnr)
            end
        })
      end
  },
  -- { "williamboman/mason.nvim", version = "v1.9.0" },
  {
      "williamboman/mason-lspconfig.nvim",
      -- version = "v1.22.0",
      dependencies = {"neovim/nvim-lspconfig", "williamboman/mason.nvim", },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
        require("mason-lspconfig").setup_handlers({
          function(server_name)
            require("lspconfig")[server_name].setup()
          end,
        })
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
            ['<CR>'] = cmp.mapping.confirm({ select = true }),

         ['<C-p>'] = function()
              if cmp.visible() then
                cmp.select_prev_item()
              else
                cmp.complete()
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
                    cmp.complete()
                  else
                    fallback()
                  end

              end
            end,

            -- ['<C-p>'] = function(fallback)
            --   if cmp.visible() then
            --     cmp.select_prev_item()
            --   else
            --       cmp.complete()
            --   end
            -- end,


            ['<C-n>'] = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                  cmp.complete()
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
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

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
        vim.g.typst_embedded_languages = {'c', 'cpp', 'python', 'rust'}
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
      end
  },

  -- その他
  { "edvb/catium.vim" },

}

