-- ╔══════════════════════════════════════════════════════════════╗
-- ║           HACKER NEOVIM — init.lua entry point              ║
-- ║           Green on Black. No mercy. No GUI.                 ║
-- ╚══════════════════════════════════════════════════════════════╝

require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Set colorscheme before plugins so the rtp entry is registered early.
-- colors/hacker.lua is the standard Neovim colorscheme entry point.
vim.cmd.colorscheme("hacker")

-- Bootstrap lazy.nvim and load all plugins
require("plugins.init")

-- Re-apply after VimEnter: lualine / bufferline / alpha all run on VimEnter
-- and may set their own highlights. vim.defer_fn(fn, 0) pushes us to the
-- very end of the VimEnter callback queue.
vim.api.nvim_create_autocmd("VimEnter", {
  once     = true,
  callback = function()
    vim.defer_fn(function()
      vim.cmd.colorscheme("hacker")
    end, 0)
  end,
})
