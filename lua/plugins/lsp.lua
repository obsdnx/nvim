-- Neovim 0.11+ native LSP API: vim.lsp.config / vim.lsp.enable
-- nvim-lspconfig is NOT used (it's deprecated in 0.11).
-- Mason handles server installation; vim.lsp.* handles configuration.

return {
  -- ── Mason: LSP server installer GUI ────────────────────────────────────────
  {
    "williamboman/mason.nvim",
    cmd   = "Mason",
    build = ":MasonUpdate",
    opts  = {
      ui = {
        border = "single",
        icons  = {
          package_installed   = "✓",
          package_pending     = "⟳",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- ── mason-lspconfig: auto-install + wire native LSP ────────────────────────
  {
    "williamboman/mason-lspconfig.nvim",
    lazy         = false,
    dependencies = { "williamboman/mason.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- mason.setup() prepends ~/.local/share/nvim/mason/bin to vim.env.PATH
      -- so vim.lsp.enable() can find clangd / pyright-langserver
      require("mason").setup({
        ui = {
          border = "single",
          icons  = { package_installed = "✓", package_pending = "⟳", package_uninstalled = "✗" },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed   = { "clangd", "pyright" },
        automatic_installation = true,
      })

      -- ── Diagnostics ─────────────────────────────────────────────────────────
      vim.diagnostic.config({
        virtual_text     = { prefix = "●", source = "if_many" },
        signs            = true,
        underline        = true,
        update_in_insert = false,
        severity_sort    = true,
        float = {
          focusable = false,
          style     = "minimal",
          border    = "single",
          source    = "always",
        },
      })

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- ── Buffer-local keymaps via LspAttach ──────────────────────────────────
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("HackerLspKeymaps", { clear = true }),
        callback = function(ev)
          local buf = ev.buf
          local bmap = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
          end

          bmap("n", "gd",         vim.lsp.buf.definition,     "Go to definition")
          bmap("n", "gD",         vim.lsp.buf.declaration,    "Go to declaration")
          bmap("n", "gr",         vim.lsp.buf.references,     "Find references")
          bmap("n", "gi",         vim.lsp.buf.implementation, "Go to implementation")
          bmap("n", "K",          vim.lsp.buf.hover,          "Hover documentation")
          bmap("n", "<C-k>",      vim.lsp.buf.signature_help, "Signature help")
          bmap("n", "<leader>ca", vim.lsp.buf.code_action,    "Code actions")
          bmap("v", "<leader>ca", vim.lsp.buf.code_action,    "Code actions")
          bmap("n", "<leader>rn", vim.lsp.buf.rename,         "Rename symbol")
          bmap("n", "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
          end, "Format buffer")
          bmap("n", "]d",         vim.diagnostic.goto_next,   "Next diagnostic")
          bmap("n", "[d",         vim.diagnostic.goto_prev,   "Previous diagnostic")
          bmap("n", "<leader>dl", vim.diagnostic.setloclist,  "Diagnostics → loclist")

          -- Float diagnostic on cursor hold
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer   = buf,
            callback = function()
              vim.diagnostic.open_float(nil, { focusable = false })
            end,
          })
        end,
      })

      -- ── Capabilities (enhanced with nvim-cmp) ────────────────────────────────
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ── clangd — C/C++ ───────────────────────────────────────────────────────
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        filetypes    = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", "Makefile", ".git" },
        capabilities = capabilities,
        init_options = {
          usePlaceholders    = true,
          completeUnimported = true,
          clangdFileStatus   = true,
        },
      })
      vim.lsp.enable("clangd")

      -- ── pyright — Python ─────────────────────────────────────────────────────
      vim.lsp.config("pyright", {
        cmd          = { "pyright-langserver", "--stdio" },
        filetypes    = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "pyrightconfig.json", ".git" },
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths        = true,
              diagnosticMode         = "workspace",
              useLibraryCodeForTypes = true,
              typeCheckingMode       = "basic",
            },
          },
        },
      })
      vim.lsp.enable("pyright")
    end,
  },
}
