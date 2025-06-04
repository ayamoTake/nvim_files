
--- Startup times for process: Primary (or UI client) ---

-- times in msec
--  clock   self+sourced   self:  sourced script
--  clock   elapsed:              other lines
--
-- 000.000  000.000: --- NVIM STARTING ---
-- 000.114  000.114: event init
-- 000.191  000.077: early init
-- 000.230  000.039: locale set
-- 000.257  000.027: init first window
-- 005.617  005.360: inits 1
-- 005.625  000.008: window checked
-- 005.628  000.003: parsing arguments
-- 005.939  000.026  000.026: require('vim.shared')
-- 005.997  000.025  000.025: require('vim.inspect')
-- 006.025  000.023  000.023: require('vim._options')
-- 006.027  000.086  000.037: require('vim._editor')
-- 006.027  000.129  000.018: require('vim._init_packages')
-- 006.028  000.271: init lua interpreter
-- 009.101  003.072: nvim_ui_attach
-- 009.313  000.213: nvim_set_client_info
-- 009.314  000.001: --- NVIM STARTED ---
--
-- --- Startup times for process: Embedded ---
--
-- times in msec
--  clock   self+sourced   self:  sourced script
--  clock   elapsed:              other lines
--
-- 000.000  000.000: --- NVIM STARTING ---
-- 000.096  000.096: event init
-- 000.170  000.074: early init
-- 000.204  000.034: locale set
-- 000.229  000.025: init first window
-- 001.238  001.010: inits 1
-- 001.246  000.008: window checked
-- 001.257  000.011: parsing arguments
-- 001.597  000.027  000.027: require('vim.shared')
-- 001.659  000.025  000.025: require('vim.inspect')
-- 001.691  000.025  000.025: require('vim._options')
-- 001.692  000.093  000.043: require('vim._editor')
-- 001.693  000.137  000.016: require('vim._init_packages')
-- 001.694  000.301: init lua interpreter
-- 001.732  000.037: expanding arguments
-- 001.758  000.026: inits 2
-- 001.927  000.169: init highlight
-- 001.927  000.001: waiting for UI
-- 001.998  000.071: done waiting for UI
-- 002.000  000.002: clear screen
-- 002.094  000.011  000.011: require('vim.keymap')
-- 002.670  000.088  000.088: sourcing nvim_exec2()
-- 002.756  000.754  000.655: require('vim._defaults')
-- 002.757  000.003: init default mappings & autocommands
-- 009.232  000.063  000.063: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/ftplugin.vim
-- 011.154  000.029  000.029: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/indent.vim
-- 022.735  005.021  005.021: require('mapping')
-- 022.842  000.015  000.015: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 022.846  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 022.848  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 028.793  000.506  000.506: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/autoload/provider/clipboard.vim
-- 028.806  005.952  005.446: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 031.388  002.550  002.550: require('lazy')
-- 031.428  000.015  000.015: require('ffi')
-- 031.470  000.020  000.020: require('vim.fs')
-- 033.910  002.437  002.437: require('vim.uri')
-- 033.925  002.494  000.038: require('vim.loader')
-- 038.631  003.616  003.616: require('lazy.stats')
-- 041.869  003.212  003.212: require('lazy.core.util')
-- 044.073  002.202  002.202: require('lazy.core.config')
-- 049.821  003.227  003.227: require('lazy.core.handler')
-- 059.044  003.328  003.328: require('lazy.pkg')
-- 059.054  006.849  003.522: require('lazy.core.meta')
-- 059.060  009.232  002.383: require('lazy.core.plugin')
-- 059.068  014.993  002.534: require('lazy.core.loader')
-- 061.521  002.293  002.293: require('lazy.core.fragments')
-- 078.630  002.017  002.017: require('lazy.core.handler.event')
-- 078.634  004.010  001.992: require('lazy.core.handler.ft')
-- 080.463  001.826  001.826: require('lazy.core.handler.cmd')
-- 082.410  001.943  001.943: require('lazy.core.handler.keys')
-- 082.466  000.010  000.010: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 083.455  000.002  000.002: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 083.510  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 083.517  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 083.531  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 083.537  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 083.541  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 087.499  000.043  000.043: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-markdown/ftdetect/markdown.vim
-- 087.502  002.079  002.036: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 087.506  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 087.516  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 091.587  000.007  000.007: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/typst.vim/ftdetect/typst.vim
-- 091.589  002.023  002.016: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 091.593  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 091.682  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 092.737  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 098.517  002.326  002.326: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/filetype.lua:0
-- 098.521  003.501  001.176: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/filetype.lua
-- 098.523  005.745  002.244: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 108.361  002.874  002.874: require('vim.lsp.log')
-- 110.684  002.321  002.321: require('vim.lsp.protocol')
-- 112.718  002.030  002.030: require('vim.lsp.util')
-- 116.467  001.899  001.899: require('vim.lsp.sync')
-- 116.481  003.760  001.861: require('vim.lsp._changetracking')
-- 120.339  001.877  001.877: require('vim.lsp._transport')
-- 120.350  003.867  001.990: require('vim.lsp.rpc')
-- 120.369  017.810  002.958: require('vim.lsp')
-- 126.413  006.042  006.042: require('lspconfig.util')
-- 128.516  002.096  002.096: require('vim.version')
-- 129.494  027.941  001.992: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/nvim-lspconfig/plugin/lspconfig.lua
-- 129.500  029.880  001.940: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 129.506  000.002  000.002: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 129.515  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 132.546  000.178  000.178: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/neoterm/plugin/neoterm.vim
-- 132.549  002.152  001.975: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 132.554  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 135.370  000.070  000.070: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/neoterm/ftdetect/set_repl_cmd.vim
-- 135.373  001.970  001.900: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 135.376  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 137.376  000.002  000.002: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 137.381  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 139.567  000.002  000.002: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 139.575  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 149.391  002.013  002.013: require('ibl.utils')
-- 149.396  004.072  002.059: require('ibl.config')
-- 151.409  002.012  002.012: require('ibl.indent')
-- 151.415  011.838  005.754: require('ibl.hooks')
-- 155.402  001.944  001.944: require('ibl.highlights')
-- 157.485  002.082  002.082: require('ibl.autocmds')
-- 159.504  002.018  002.018: require('ibl.inlay_hints')
-- 161.481  001.974  001.974: require('ibl.virt_text')
-- 165.490  002.066  002.066: require('ibl.scope_languages')
-- 165.492  004.009  001.943: require('ibl.scope')
-- 165.498  014.049  002.022: require('ibl')
-- 168.879  003.232  003.232: require('vim.iter')
-- 173.201  002.291  002.291: require('vim.lsp.completion')
-- 173.251  004.340  002.049: require('vim.lsp.handlers')
-- 173.498  000.004  000.004: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 173.519  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 178.241  000.036  000.036: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/catium.vim/plugin/catium.vim
-- 178.245  001.850  001.814: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 178.250  000.002  000.002: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 178.271  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 183.826  000.464  000.464: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-abolish/plugin/abolish.vim
-- 183.830  002.321  001.856: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 183.838  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 183.847  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 191.327  000.051  000.051: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/plenary.nvim/plugin/plenary.vim
-- 191.339  002.227  002.176: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 191.358  000.002  000.002: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 191.395  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 195.582  001.185  001.185: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/telescope.nvim/plugin/telescope.lua
-- 195.586  003.199  002.014: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 195.591  000.002  000.002: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 195.602  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 201.406  000.055  000.055: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/lexima.vim/plugin/lexima.vim
-- 201.410  002.901  002.845: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 201.415  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 201.422  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 216.542  002.529  002.529: require('Comment.config')
-- 220.648  002.097  002.097: require('Comment.ft')
-- 220.653  004.102  002.006: require('Comment.utils')
-- 222.826  002.172  002.172: require('Comment.opfunc')
-- 224.699  001.871  001.871: require('Comment.extra')
-- 224.704  017.102  006.427: require('Comment.api')
-- 224.762  018.206  001.104: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/Comment.nvim/plugin/Comment.lua
-- 224.769  020.230  002.024: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 224.781  000.006  000.006: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 224.795  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 227.920  000.056  000.056: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip-integ/plugin/vsnip_integ.vim
-- 227.924  002.040  001.984: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 227.928  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 227.939  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 245.474  000.155  000.155: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vital/vsnip.vim
-- 250.479  000.052  000.052: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vital/_vsnip/VS/LSP/Position.vim
-- 252.426  000.013  000.013: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vital/_vsnip.vim
-- 252.601  010.236  010.016: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vsnip/snippet.vim
-- 254.707  000.084  000.084: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vital/_vsnip/VS/LSP/TextEdit.vim
-- 256.872  000.045  000.045: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vital/_vsnip/VS/LSP/Text.vim
-- 260.089  000.071  000.071: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vital/_vsnip/VS/Vim/Buffer.vim
-- 262.276  000.055  000.055: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vital/_vsnip/VS/Vim/Option.vim
-- 264.510  000.096  000.096: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vital/_vsnip/VS/LSP/Diff.vim
-- 264.611  024.202  013.615: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vsnip/session.vim
-- 264.710  026.318  002.116: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/autoload/vsnip.vim
-- 264.857  031.444  005.126: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip/plugin/vsnip.vim
-- 264.859  033.386  001.942: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 264.866  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 264.875  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 270.424  000.047  000.047: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/nvim-web-devicons/plugin/nvim-web-devicons.vim
-- 270.433  002.047  002.000: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 270.441  000.002  000.002: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 270.455  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 270.466  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 270.471  000.000  000.000: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 285.669  003.527  003.527: require('nvim-tree.log')
-- 291.988  002.065  002.065: require('nvim-tree.notify')
-- 291.992  004.181  002.117: require('nvim-tree.events')
-- 297.423  003.221  003.221: require('nvim-tree.iterators.node-iterator')
-- 297.459  005.466  002.245: require('nvim-tree.utils')
-- 297.477  011.801  002.154: require('nvim-tree.view')
-- 307.424  002.089  002.089: require('nvim-tree.core')
-- 313.382  002.937  002.937: require('nvim-tree.git.utils')
-- 317.437  004.054  004.054: require('nvim-tree.renderer.components.devicons')
-- 321.402  002.006  002.006: require('nvim-tree.classic')
-- 321.406  003.967  001.961: require('nvim-tree.node')
-- 321.411  013.985  003.027: require('nvim-tree.node.directory')
-- 321.413  018.012  001.938: require('nvim-tree.actions.finders.find-file')
-- 323.505  002.091  002.091: require('nvim-tree.actions.finders.search-node')
-- 323.507  023.086  002.983: require('nvim-tree.actions.finders')
-- 330.391  001.911  001.911: require('nvim-tree.node.file')
-- 330.393  004.005  002.094: require('nvim-tree.actions.fs.create-file')
-- 334.355  001.995  001.995: require('nvim-tree.lib')
-- 338.319  001.968  001.968: require('nvim-tree.node.link')
-- 338.327  003.970  002.002: require('nvim-tree.node.directory-link')
-- 338.330  007.936  001.971: require('nvim-tree.actions.fs.remove-file')
-- 340.515  002.184  002.184: require('nvim-tree.actions.fs.rename-file')
-- 342.425  001.906  001.906: require('nvim-tree.actions.fs.trash')
-- 342.427  018.919  002.888: require('nvim-tree.actions.fs')
-- 349.451  001.926  001.926: require('nvim-tree.diagnostics')
-- 349.453  004.088  002.162: require('nvim-tree.actions.moves.item')
-- 351.602  002.148  002.148: require('nvim-tree.actions.moves.parent')
-- 353.448  001.845  001.845: require('nvim-tree.actions.moves.sibling')
-- 353.450  011.022  002.942: require('nvim-tree.actions.moves')
-- 358.258  002.056  002.056: require('nvim-tree.actions.node.file-popup')
-- 360.284  002.024  002.024: require('nvim-tree.actions.node.open-file')
-- 362.360  002.075  002.075: require('nvim-tree.actions.node.run-command')
-- 364.396  002.034  002.034: require('nvim-tree.actions.node.system-open')
-- 366.366  001.968  001.968: require('nvim-tree.actions.node.buffer')
-- 366.368  012.916  002.759: require('nvim-tree.actions.node')
-- 371.364  002.085  002.085: require('nvim-tree.actions.root.change-dir')
-- 373.432  002.066  002.066: require('nvim-tree.actions.root.dir-up')
-- 373.435  007.066  002.915: require('nvim-tree.actions.root')
-- 378.368  002.006  002.006: require('nvim-tree.actions.tree.find-file')
-- 383.251  001.986  001.986: require('nvim-tree.actions.tree.modifiers.collapse-all')
-- 385.256  001.990  001.990: require('nvim-tree.actions.tree.modifiers.expand-all')
-- 385.259  006.889  002.912: require('nvim-tree.actions.tree.modifiers')
-- 387.611  002.350  002.350: require('nvim-tree.actions.tree.open')
-- 390.284  002.664  002.664: require('nvim-tree.actions.tree.toggle')
-- 392.330  002.043  002.043: require('nvim-tree.actions.tree.resize')
-- 392.333  018.897  002.944: require('nvim-tree.actions.tree')
-- 392.336  094.858  002.951: require('nvim-tree.actions')
-- 395.621  000.008  000.008: require('vim.F')
-- 395.681  003.336  003.328: require('vim.diagnostic')
-- 395.706  125.151  011.628: require('nvim-tree')
-- 397.565  001.843  001.843: require('nvim-tree.legacy')
-- 397.676  000.022  000.022: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 397.687  000.008  000.008: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 399.675  001.970  001.970: require('nvim-tree.keymap')
-- 402.568  002.890  002.890: require('nvim-tree.appearance')
-- 407.859  001.904  001.904: require('nvim-tree.buffers')
-- 411.823  002.016  002.016: require('nvim-tree.git.runner')
-- 413.983  002.159  002.159: require('nvim-tree.watcher')
-- 413.988  006.127  001.952: require('nvim-tree.git')
-- 418.013  002.118  002.118: require('nvim-tree.node.file-link')
-- 418.016  004.027  001.909: require('nvim-tree.node.factory')
-- 420.003  001.986  001.986: require('nvim-tree.node.root')
-- 424.124  002.177  002.177: require('nvim-tree.enum')
-- 424.142  004.136  001.959: require('nvim-tree.explorer.filters')
-- 427.563  003.420  003.420: require('nvim-tree.marks')
-- 429.492  001.920  001.920: require('nvim-tree.explorer.live-filter')
-- 431.487  001.993  001.993: require('nvim-tree.explorer.sorter')
-- 433.417  001.928  001.928: require('nvim-tree.actions.fs.clipboard')
-- 442.304  001.921  001.921: require('nvim-tree.renderer.decorator')
-- 442.308  004.837  002.916: require('nvim-tree.renderer.decorator.bookmarks')
-- 444.307  001.998  001.998: require('nvim-tree.renderer.decorator.copied')
-- 446.499  002.191  002.191: require('nvim-tree.renderer.decorator.cut')
-- 448.398  001.896  001.896: require('nvim-tree.renderer.decorator.diagnostics')
-- 450.433  002.034  002.034: require('nvim-tree.renderer.decorator.git')
-- 452.436  002.001  002.001: require('nvim-tree.renderer.decorator.hidden')
-- 454.434  001.996  001.996: require('nvim-tree.renderer.decorator.modified')
-- 456.379  001.944  001.944: require('nvim-tree.renderer.decorator.opened')
-- 458.297  001.915  001.915: require('nvim-tree.renderer.decorator.user')
-- 460.007  001.708  001.708: require('nvim-tree.renderer.components.padding')
-- 460.042  024.602  002.081: require('nvim-tree.renderer.builder')
-- 460.050  026.631  002.029: require('nvim-tree.renderer')
-- 460.062  057.130  003.059: require('nvim-tree.explorer')
-- 462.158  002.094  002.094: require('nvim-tree.explorer.watch')
-- 466.314  002.026  002.026: require('nvim-tree.renderer.components.full-name')
-- 466.318  004.154  002.128: require('nvim-tree.renderer.components')
-- 471.617  002.087  002.087: require('nvim-web-devicons.filetypes')
-- 477.018  003.424  003.424: require('nvim-web-devicons.default.icons_by_filename')
-- 479.859  002.839  002.839: require('nvim-web-devicons.default.icons_by_file_extension')
-- 482.006  002.145  002.145: require('nvim-web-devicons.default.icons_by_operating_system')
-- 484.141  002.133  002.133: require('nvim-web-devicons.default.icons_by_desktop_environment')
-- 486.544  002.402  002.402: require('nvim-web-devicons.default.icons_by_window_manager')
-- 486.553  014.902  001.960: require('nvim-web-devicons.icons-default')
-- 486.833  020.513  003.523: require('nvim-web-devicons')
-- 490.876  002.288  002.288: require('nvim-tree.help')
-- 495.454  002.467  002.467: require('nvim-tree.appearance.hi-test')
-- 495.521  004.642  002.175: require('nvim-tree.api')
-- 497.974  002.347  002.347: require('nvim-tree.commands')
-- 508.215  000.035  000.035: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/tcomment_vim/autoload/tcomment/deprecated.vim
-- 509.392  007.311  007.276: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/tcomment_vim/plugin/tcomment.vim
-- 509.397  009.994  002.683: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 509.413  000.002  000.002: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 509.448  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 509.511  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 509.517  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 571.414  001.938  001.938: require('vscode.config')
-- 573.609  002.189  002.189: require('vscode.theme')
-- 575.508  001.897  001.897: require('vscode.utils')
-- 575.510  010.113  004.089: require('vscode')
-- 575.654  000.139  000.139: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vscode.nvim/colors/vscode.lua:0
-- 575.756  000.094  000.094: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vscode.nvim/colors/vscode.lua:0
-- 578.625  002.862  002.862: require('vscode.colors')
-- 579.283  014.826  001.617: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vscode.nvim/colors/vscode.lua
-- 586.062  002.121  002.121: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-easymotion/plugin/EasyMotion.vim
-- 586.066  004.267  002.147: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 586.071  000.002  000.002: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 586.080  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 590.519  000.003  000.003: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 590.527  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 590.533  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 590.538  000.001  000.001: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 602.686  002.150  002.150: require('mason-core.path')
-- 609.370  001.985  001.985: require('mason-core.functional.data')
-- 611.404  002.031  002.031: require('mason-core.functional.function')
-- 613.600  002.189  002.189: require('mason-core.functional.list')
-- 615.588  001.982  001.982: require('mason-core.functional.relation')
-- 617.675  002.084  002.084: require('mason-core.functional.logic')
-- 619.677  001.999  001.999: require('mason-core.functional.number')
-- 621.902  002.220  002.220: require('mason-core.functional.string')
-- 624.014  002.108  002.108: require('mason-core.functional.table')
-- 626.195  002.176  002.176: require('mason-core.functional.type')
-- 626.199  021.733  002.960: require('mason-core.functional')
-- 626.254  023.565  001.831: require('mason-core.platform')
-- 628.540  002.285  002.285: require('mason.settings')
-- 628.545  031.170  003.170: require('mason-core.installer.InstallLocation')
-- 636.087  002.233  002.233: require('mason-core.log')
-- 636.091  004.382  002.149: require('mason-core.EventEmitter')
-- 640.347  004.255  004.255: require('mason-registry.sources')
-- 640.359  011.812  003.176: require('mason-registry')
-- 640.362  049.821  006.840: require('mason')
-- 643.709  003.308  003.308: require('mason.api.command')
-- 650.646  002.445  002.445: require('mason-lspconfig.settings')
-- 650.657  006.941  004.496: require('mason-lspconfig')
-- 655.390  002.516  002.516: require('mason-lspconfig.notify')
-- 655.399  004.738  002.222: require('mason-lspconfig.lspconfig_hook')
-- 658.701  003.301  003.301: require('mason-lspconfig.mappings.server')
-- 660.995  002.290  002.290: require('mason-lspconfig.server_config_extensions')
-- 665.567  002.041  002.041: require('lspconfig.async')
-- 665.571  004.573  002.532: require('lspconfig.configs')
-- 696.486  002.077  002.077: require('mason-core.optional')
-- 699.474  002.980  002.980: require('mason-core.async')
-- 699.503  008.956  003.899: require('mason-lspconfig.api.command')
-- 705.540  001.147  001.147: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/editorconfig.lua
-- 705.545  003.044  001.896: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 707.695  000.133  000.133: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/gzip.vim
-- 707.698  002.137  002.004: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 710.859  001.051  001.051: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/man.lua
-- 710.861  003.159  002.108: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 719.732  000.159  000.159: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/pack/dist/opt/matchit/plugin/matchit.vim
-- 719.746  006.743  006.584: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/matchit.vim
-- 719.748  008.874  002.132: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 722.019  000.084  000.084: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/matchparen.vim
-- 722.022  002.267  002.183: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 724.482  000.040  000.040: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/netrwPlugin.vim
-- 724.495  002.467  002.427: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 728.126  001.229  001.229: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/osc52.lua
-- 728.131  003.611  002.382: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 730.769  000.183  000.183: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/rplugin.vim
-- 730.780  002.644  002.461: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 732.853  000.055  000.055: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/shada.vim
-- 732.856  002.052  001.998: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 735.361  000.044  000.044: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/spellfile.vim
-- 735.373  002.509  002.466: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 737.647  000.077  000.077: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/tarPlugin.vim
-- 737.650  002.259  002.181: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 740.893  001.217  001.217: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/tohtml.lua
-- 740.896  003.239  002.022: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 742.943  000.019  000.019: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/tutor.vim
-- 742.946  002.046  002.027: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 745.463  000.128  000.128: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/plugin/zipPlugin.vim
-- 745.474  002.484  002.357: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 756.563  000.025  000.025: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip-integ/autoload/vsnip_integ/integration.vim
-- 758.581  000.033  000.033: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip-integ/autoload/vsnip_integ/detection.vim
-- 759.671  010.276  010.218: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/vim-vsnip-integ/after/plugin/vsnip_integ.vim
-- 759.674  012.901  002.624: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 763.543  001.072  001.072: sourcing /jugyou/ise/23D8101003K/.local/share/nvim/lazy/indent-blankline.nvim/after/plugin/commands.lua
-- 763.546  002.916  001.844: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 763.717  000.134  000.134: sourcing nvim_exec2() called at /jugyou/ise/23D8101003K/.config/nvim/init.lua:0
-- 763.719  749.518  154.984: sourcing /jugyou/ise/23D8101003K/.config/nvim/init.lua
-- 763.725  011.357: sourcing vimrc file(s)
-- 765.946  001.014  001.014: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/filetype.lua
-- 772.050  000.054  000.054: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/syntax/synload.vim
-- 772.103  003.169  003.114: sourcing /jugyou/ise/23D8101003K/bin/nvim-linux-x86_64/share/nvim/runtime/syntax/syntax.vim
-- 772.113  004.206: inits 3
-- 777.797  005.683: reading ShaDa
-- 778.192  000.396: opening buffers
-- 778.203  000.011: BufEnter autocommands
-- 778.205  000.002: editing files in windows
-- 778.267  000.062: VimEnter autocommands
-- 780.403  002.104  002.104: require('vim.termcap')
-- 780.439  000.022  000.022: require('vim.text')
-- 780.455  000.063: UIEnter autocommands
-- 780.457  000.002: before starting main loop
-- 780.669  000.212: first screen update
-- 780.671  000.001: --- NVIM STARTED ---
--

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
        vim.opt.mouse = "nvi"
    end,
})

vim.api.nvim_create_autocmd("FocusLost", {
    callback = function()
        vim.opt.mouse = ""
    end,
})

require("mapping")

if vim.fn.has("wsl") == 1 then
    if vim.fn.executable("xsel") == 0 then
        print("xsel not found, clipboard integration won't work")
    else
        vim.g.clipboard = {
            name = 'xsel-clipboard (wsl)',
            copy = {
                ['+'] = 'xsel -bi',
                ['*'] = 'xsel -bi',
            },
            paste = {
                ['+'] = 'xsel -bo',
                ['*'] = function() return vim.fn.systemlist('xsel -bo | tr -d "\r"') end,
            },
            cache_enabled = true,
        }
    end
end
vim.opt.clipboard = "unnamedplus"

-- LSPサーバアタッチ時の処理
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ctx)
    local set = vim.keymap.set
    set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = true })
    set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = true })
    set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = true })    
    set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = true })
    set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { buffer = true })
    set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = true })
    set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = true })

  end,
})

-- vim.api.nvim_set_keymap('n', '<leader>r', ':w<CR>:belowright split term://g++ % -o %:r && ./%:r<CR>', { noremap = true, silent = true })

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- 検索
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = false

-- タブ
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.autoindent = false

-- 矩形選択
vim.opt.virtualedit="block"

-- 候補のマッチ
vim.opt.wildmenu = true
vim.opt.wildmode = "longest", "full"

-- クリップボードにヤンク
-- vim.opt.clipboard:append({ unnamedplus = true })

vim.cmd('let &t_SI .= "\\e[6 q"')
vim.cmd('let &t_EI .= "\\e[2 q"')
vim.cmd('let &t_SR .= "\\e[4 q"')

vim.opt.showmatch = true
vim.opt.splitbelow = true
vim.opt.undofile = true
-- vim.opt.relativenumber = true

vim.cmd([[
    " https://qiita.com/yahihi/items/4112ab38b2cc80c91b16
    if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal g`\"" | endif
    " end https://qiita.com/yahihi/items/4112ab38b2cc80c91b16
]])

-- status line
vim.opt.laststatus = 2

if vim.fn.winwidth(0) >= 130 then
    vim.opt.statusline = "%F"
else
    vim.opt.statusline = "%t"
end

vim.opt.statusline:append(" %y%=[%l/%L]")

require("lazy").setup({
    defaults = { lazy = false, },
    spec = {
        { import = "plugins" },
    },
})

-- 透明化 
vim.cmd([[
  highlight Normal       ctermbg=none guibg=none
  highlight NormalNC     ctermbg=none guibg=none
  highlight NormalSB     ctermbg=none guibg=none
  highlight NonText      ctermbg=none guibg=none
  highlight LineNr       ctermbg=none guibg=none
  highlight LineNrAbove  ctermbg=none guibg=none
  highlight LineNrBelow  ctermbg=none guibg=none
  highlight CursorLineNr ctermbg=none guibg=none
  highlight SignColumn   ctermbg=none guibg=none
]])

