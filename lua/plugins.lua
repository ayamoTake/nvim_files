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
  { "Mofiqul/vscode.nvim" },

  -- コメント系
  { "numToStr/Comment.nvim", lazy = false }, -- 起動時読み込みでもOK

  -- ツリー表示
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- インデント可視化
  { "lukas-reineke/indent-blankline.nvim" },

  -- ターミナル統合
  { "akinsho/toggleterm.nvim", version = "*", config = true },

  -- ターミナルのウィンドウ整理
  { "willothy/flatten.nvim" },

  -- 置換ツール
  { "tpope/vim-abolish" },

  -- スクショ
  { "segeljakt/vim-silicon" },

  -- Lean 向け
  { "Julian/lean.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", version = "v1.9.0" },
  { "williamboman/mason-lspconfig.nvim", version = "v1.22.0" },

  -- LSP 補完
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },

  -- スニペット
  { "hrsh7th/vim-vsnip" },
  { "hrsh7th/vim-vsnip-integ" },
  { "hrsh7th/cmp-vsnip" },

  -- Lean スイッチ切替
  { "andrewradev/switch.vim" },

  -- コメント操作
  { "tomtom/tcomment_vim" },

  -- 検索
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Markdown 系
  { "kannokanno/previm" },
  { "godlygeek/tabular" },
  { "preservim/vim-markdown" },
  { "tyru/open-browser.vim" },

  -- Typst
  { "kaarmu/typst.vim" },

  -- 自動括弧補完など
  { "cohama/lexima.vim" },

  -- その他
  { "edvb/catium.vim" },
}

