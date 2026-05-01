local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ── Auto-save on focus loss / buffer leave ────────────────────────────────────
augroup("AutoSave", { clear = true })
autocmd({ "FocusLost", "BufLeave" }, {
  group   = "AutoSave",
  pattern = "*",
  command = "silent! wa",
})

-- ── Filetype-specific indentation ────────────────────────────────────────────
augroup("FiletypeIndent", { clear = true })
autocmd("FileType", {
  group   = "FiletypeIndent",
  pattern = { "python", "yaml", "toml" },
  callback = function()
    vim.opt_local.tabstop     = 4
    vim.opt_local.shiftwidth  = 4
    vim.opt_local.expandtab   = true
  end,
})
autocmd("FileType", {
  group   = "FiletypeIndent",
  pattern = { "c", "cpp", "h", "lua", "javascript", "typescript", "json" },
  callback = function()
    vim.opt_local.tabstop    = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab  = true
  end,
})
autocmd("FileType", {
  group   = "FiletypeIndent",
  pattern = { "make", "makefile" },
  callback = function()
    vim.opt_local.expandtab = false  -- Makefiles require real tabs
    vim.opt_local.tabstop   = 4
  end,
})

-- ── Remove trailing whitespace on save ───────────────────────────────────────
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group   = "TrimWhitespace",
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- ── Highlight yanked text briefly ────────────────────────────────────────────
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group    = "YankHighlight",
  pattern  = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Search", timeout = 200 })
  end,
})

-- ── Restore cursor position when reopening a file ────────────────────────────
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = "RestoreCursor",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ── Auto-reload files changed on disk ────────────────────────────────────────
augroup("AutoReload", { clear = true })
autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group   = "AutoReload",
  pattern = "*",
  command = "checktime",
})

-- ── Resize splits when window is resized ─────────────────────────────────────
augroup("WinResize", { clear = true })
autocmd("VimResized", {
  group   = "WinResize",
  pattern = "*",
  command = "tabdo wincmd =",
})

-- ── C: auto-format on save via clang-format if available ─────────────────────
augroup("CAutoFormat", { clear = true })
autocmd("BufWritePre", {
  group   = "CAutoFormat",
  pattern = { "*.c", "*.h", "*.cpp", "*.hpp" },
  callback = function()
    if vim.fn.executable("clang-format") == 1 then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

-- ── Python: auto-format on save via LSP (black via pyright) ──────────────────
augroup("PythonAutoFormat", { clear = true })
autocmd("BufWritePre", {
  group   = "PythonAutoFormat",
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- ── Close certain windows with just 'q' ──────────────────────────────────────
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group   = "CloseWithQ",
  pattern = { "help", "man", "qf", "lspinfo", "checkhealth" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
  end,
})
