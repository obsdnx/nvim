local opt = vim.opt

-- Appearance
opt.termguicolors  = true
opt.background     = "dark"
opt.syntax         = "on"
opt.number         = true
opt.relativenumber = false
opt.cursorline     = true
opt.signcolumn     = "yes"
opt.colorcolumn    = "80"
opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.wrap           = false
opt.list           = true
opt.listchars      = { tab = "→ ", trail = "·", nbsp = "⎵" }
opt.showmode       = false       -- lualine handles this
opt.showcmd        = false
opt.cmdheight      = 1
opt.pumheight      = 10          -- max completion items shown
opt.conceallevel   = 0

-- Splits
opt.splitbelow  = true
opt.splitright  = true

-- Editing
opt.expandtab   = true
opt.shiftwidth  = 4
opt.tabstop     = 4
opt.softtabstop = 4
opt.smartindent = true
opt.autoindent  = true
opt.shiftround  = true

-- Search
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = true
opt.incsearch  = true

-- Files & buffers
opt.hidden     = true
opt.swapfile   = false
opt.backup     = false
opt.undofile   = true
opt.undodir    = vim.fn.stdpath("data") .. "/undodir"
opt.autowrite  = true    -- write before :make, etc.
opt.autoread   = true    -- reload when file changes on disk

-- Clipboard
opt.clipboard  = "unnamedplus"

-- Mouse
opt.mouse      = "a"

-- Performance
opt.updatetime  = 250
opt.timeoutlen  = 400
opt.ttimeoutlen = 10

-- Completion
opt.completeopt = { "menuone", "noselect" }
opt.shortmess:append("c")

-- Folding (uses treesitter when available)
opt.foldmethod  = "expr"
opt.foldexpr    = "nvim_treesitter#foldexpr()"
opt.foldlevel   = 99           -- start fully unfolded
