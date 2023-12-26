-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

vim.g.auto_save = 1
vim.opt.iskeyword:append "-"  -- hyphenated words recognized by searches

vim.opt.relativenumber = true -- relative line numbers

lvim.colorscheme = "darkblue"

-- Normal --
-- Resize with arrows
lvim.keys.normal_mode["<C-Left>"] = ":vertical resize +2<CR>"
lvim.keys.normal_mode["<C-Right>"] = ":vertical resize -2<CR>"
-- Navigate buffers

lvim.keys.normal_mode["<S-l>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":bprevious<CR>"
lvim.keys.normal_mode["<S-x>"] = ":bdelete<CR>"

-- Move text up and down

lvim.keys.normal_mode["J"] = ":m .+1<CR>=="
lvim.lsp.buffer_mappings.normal_mode['K'] = nil -- LSP bindings take precedence over regular keybindings. So in order to use a key for a regular binding, we have to remove it first
lvim.keys.normal_mode["K"] = ":m .-2<CR>=="

-- window management
lvim.keys.normal_mode["<leader>s|"] = "<C-w>v"        -- split window vertically
lvim.keys.normal_mode["<leader>s-"] = "<C-w>s"        -- split window horizontally
lvim.keys.normal_mode["<leader>se"] = "<C-w>="        -- make split windows equal width & height
lvim.keys.normal_mode["<leader>sx"] = ":close<CR>"    -- close current split window

lvim.keys.normal_mode["<leader>to"] = ":tabnew<CR>"   -- open new tab
lvim.keys.normal_mode["<leader>tx"] = ":tabclose<CR>" -- close current tab
lvim.keys.normal_mode["<leader>tn"] = ":tabn<CR>"     --  go to next ta
lvim.keys.normal_mode["<leader>tp"] = ":tabp<CR>"     --  go to previous tab

lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- Insert --
-- Press jk fast to exit insert mode
lvim.keys.insert_mode["jj"] = "<ESC>"

-- Visual --
-- To retain the yanked text when pasted.
lvim.keys.visual_mode["p"] = '"_dP'

-- Visual Block
-- Move text up and down
lvim.keys.visual_block_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.lsp.buffer_mappings.visual_mode['K'] = nil -- LSP bindings take precedence over regular keybindings. So in order to use a key for a regular binding, we have to remove it first
lvim.keys.visual_block_mode["K"] = ":m '<-2<CR>gv=gv"

lvim.builtin.terminal.open_mapping = "<C-t>"

lvim.plugins = {
  { "mfussenegger/nvim-jdtls" },
  { "907th/vim-auto-save" },
  { "christoomey/vim-tmux-navigator" }, -- tmux & split window navigation
  { "szw/vim-maximizer" },              -- maximizes and restores current window
  { "folke/trouble.nvim" },
  { "tpope/vim-fugitive" },
  { "mhinz/vim-signify" },
  { "folke/tokyonight.nvim" },
  { "tyru/open-browser.vim" },
  { "aklt/plantuml-syntax" },
  { "weirongxu/plantuml-previewer.vim" },
  {
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  { name = "autoflake" },
  { name = "prettier" },
  { command = "google_java_format", filetypes = { "java" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8" },
  { name = "mypy" },
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })
