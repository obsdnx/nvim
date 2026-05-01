-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- ── UI ──────────────────────────────────────────────────────────────────────
  { import = "plugins.ui" },

  -- ── Telescope ────────────────────────────────────────────────────────────────
  { import = "plugins.telescope" },

  -- ── Treesitter ───────────────────────────────────────────────────────────────
  { import = "plugins.treesitter" },

  -- ── LSP + Mason ──────────────────────────────────────────────────────────────
  { import = "plugins.lsp" },

  -- ── Completion ───────────────────────────────────────────────────────────────
  { import = "plugins.completion" },

  -- ── Editor utilities ─────────────────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts  = { check_ts = true },
  },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    opts  = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts  = {
      plugins = { spelling = { enabled = true } },
      win     = { border = "single" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts  = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▁" },
        topdelete    = { text = "▔" },
        changedelete = { text = "▎" },
        untracked    = { text = "┆" },
      },
      current_line_blame = false,
    },
  },
}, {
  defaults = { lazy = true },
  install  = { colorscheme = { "habamax" } },
  checker  = { enabled = false },
  ui       = {
    border = "single",
    icons  = {
      package_pending  = "⟳ ",
      package_installed  = "✓ ",
      package_uninstalled = "✗ ",
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})
