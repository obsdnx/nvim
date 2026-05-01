vim.g.mapleader      = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ── File operations ──────────────────────────────────────────────────────────
map("n", "<leader>w", "<cmd>w<cr>",    vim.tbl_extend("force", opts, { desc = "Save file" }))
map("n", "<leader>q", "<cmd>q<cr>",    vim.tbl_extend("force", opts, { desc = "Quit" }))
map("n", "<leader>Q", "<cmd>qa!<cr>",  vim.tbl_extend("force", opts, { desc = "Force quit all" }))

-- ── Splits ───────────────────────────────────────────────────────────────────
map("n", "<leader>s", "<cmd>split<cr>",  vim.tbl_extend("force", opts, { desc = "Horizontal split" }))
map("n", "<leader>v", "<cmd>vsplit<cr>", vim.tbl_extend("force", opts, { desc = "Vertical split" }))

-- ── Split navigation (Ctrl+hjkl) ─────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", vim.tbl_extend("force", opts, { desc = "Move to left split" }))
map("n", "<C-j>", "<C-w>j", vim.tbl_extend("force", opts, { desc = "Move to lower split" }))
map("n", "<C-k>", "<C-w>k", vim.tbl_extend("force", opts, { desc = "Move to upper split" }))
map("n", "<C-l>", "<C-w>l", vim.tbl_extend("force", opts, { desc = "Move to right split" }))

-- ── Split resize ─────────────────────────────────────────────────────────────
map("n", "<C-Up>",    "<cmd>resize +2<cr>",          opts)
map("n", "<C-Down>",  "<cmd>resize -2<cr>",          opts)
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>", opts)
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opts)

-- ── Buffer navigation ─────────────────────────────────────────────────────────
map("n", "<S-l>", "<cmd>bnext<cr>",     vim.tbl_extend("force", opts, { desc = "Next buffer" }))
map("n", "<S-h>", "<cmd>bprevious<cr>", vim.tbl_extend("force", opts, { desc = "Previous buffer" }))
map("n", "<leader>bd", "<cmd>bdelete<cr>", vim.tbl_extend("force", opts, { desc = "Close buffer" }))

-- ── File explorer (nvim-tree) ─────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", vim.tbl_extend("force", opts, { desc = "Toggle file explorer" }))
map("n", "<leader>E", "<cmd>NvimTreeFocus<cr>",  vim.tbl_extend("force", opts, { desc = "Focus file explorer" }))

-- ── Telescope ────────────────────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>",  vim.tbl_extend("force", opts, { desc = "Find files" }))
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",   vim.tbl_extend("force", opts, { desc = "Live grep" }))
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",     vim.tbl_extend("force", opts, { desc = "Find buffers" }))
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",   vim.tbl_extend("force", opts, { desc = "Help tags" }))
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",    vim.tbl_extend("force", opts, { desc = "Recent files" }))
map("n", "<leader>fc", "<cmd>Telescope commands<cr>",    vim.tbl_extend("force", opts, { desc = "Commands" }))
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", vim.tbl_extend("force", opts, { desc = "Diagnostics" }))

-- ── LSP (defined here; overridden per-buffer in lsp.lua on_attach) ───────────
-- These are global fallbacks; lsp.lua attaches buffer-local ones.
map("n", "gd", vim.lsp.buf.definition,     vim.tbl_extend("force", opts, { desc = "Go to definition" }))
map("n", "gr", vim.lsp.buf.references,     vim.tbl_extend("force", opts, { desc = "Find references" }))
map("n", "gD", vim.lsp.buf.declaration,    vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
map("n", "K",  vim.lsp.buf.hover,          vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
map("n", "<leader>ca", vim.lsp.buf.code_action,   vim.tbl_extend("force", opts, { desc = "Code actions" }))
map("n", "<leader>rn", vim.lsp.buf.rename,        vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end,
    vim.tbl_extend("force", opts, { desc = "Format buffer" }))

-- ── Diagnostics ──────────────────────────────────────────────────────────────
map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
map("n", "<leader>dl", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostics to loclist" }))

-- ── Comment (Comment.nvim uses gcc/gbc; add visual map) ──────────────────────
map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle line comment" })
map("v", "<leader>/", "gc",  { remap = true, desc = "Toggle block comment" })

-- ── Search UX ────────────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohl<cr>", vim.tbl_extend("force", opts, { desc = "Clear search highlight" }))

-- ── Indenting in visual mode keeps selection ──────────────────────────────────
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- ── Move lines up/down in visual mode ────────────────────────────────────────
map("v", "J", ":m '>+1<cr>gv=gv", opts)
map("v", "K", ":m '<-2<cr>gv=gv", opts)

-- ── Keep cursor centered on half-page jumps ───────────────────────────────────
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- ── Paste without losing register ────────────────────────────────────────────
map("x", "<leader>p", '"_dP', vim.tbl_extend("force", opts, { desc = "Paste without yanking" }))
