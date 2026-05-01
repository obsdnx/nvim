return {
  -- ── File explorer ─────────────────────────────────────────────────────────
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd          = { "NvimTreeToggle", "NvimTreeFocus" },
    keys         = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" } },
    opts = {
      disable_netrw       = true,
      hijack_netrw        = true,
      hijack_cursor       = true,
      sync_root_with_cwd  = true,
      update_focused_file = { enable = true },
      view = { width = 30, side = "left" },
      renderer = {
        add_trailing        = false,
        highlight_git       = true,
        highlight_opened_files = "name",
        indent_markers      = { enable = true },
        icons = {
          glyphs = {
            default  = "",
            symlink  = "",
            folder   = { arrow_open = "", arrow_closed = "", default = "", open = "" },
            git      = { unstaged = "✗", staged = "✓", unmerged = "", renamed = "➜",
                         untracked = "★", deleted = "", ignored = "◌" },
          },
        },
      },
      filters = { dotfiles = false },
      git     = { enable = true, ignore = false },
      actions = { open_file = { quit_on_open = false } },
    },
  },

  -- ── Status line ───────────────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event        = "VimEnter",
    config = function()
      -- Strict black + green palette (matching themes/hacker.lua)
      local g6   = "#00FF00"   -- bright green  — NORMAL mode
      local g5   = "#00CC00"   -- green         — INSERT mode
      local g4   = "#00AA00"   -- mid green     — COMMAND mode
      local g2   = "#005500"   -- dark green    — inactive
      local g7   = "#33FF33"   -- pale green    — VISUAL mode
      local lime = "#88FF00"   -- lime          — REPLACE mode
      local bg   = "#000000"   -- black
      local bg2  = "#1A1A1A"   -- near-black    — section b background

      local hacker_theme = {
        normal = {
          a = { fg = bg,  bg = g6,   gui = "bold" },
          b = { fg = g6,  bg = bg2 },
          c = { fg = g4,  bg = bg },
        },
        insert = {
          a = { fg = bg,  bg = g5,   gui = "bold" },
          b = { fg = g5,  bg = bg2 },
        },
        visual = {
          a = { fg = bg,  bg = g7,   gui = "bold" },
          b = { fg = g7,  bg = bg2 },
        },
        replace = {
          a = { fg = bg,  bg = lime, gui = "bold" },
          b = { fg = lime, bg = bg2 },
        },
        command = {
          a = { fg = bg,  bg = g4,   gui = "bold" },
          b = { fg = g4,  bg = bg2 },
        },
        inactive = {
          a = { fg = g2,  bg = bg },
          b = { fg = g2,  bg = bg },
          c = { fg = g2,  bg = bg },
        },
      }

      require("lualine").setup({
        options = {
          theme            = hacker_theme,
          section_separators   = { left = "", right = "" },
          component_separators = { left = "│", right = "│" },
          globalstatus     = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff",
            { "diagnostics", sources = { "nvim_lsp" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " } } },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "location" },
        },
      })
    end,
  },

  -- ── Buffer tabs ───────────────────────────────────────────────────────────
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event        = "VimEnter",
    opts = {
      options = {
        mode                 = "buffers",
        numbers              = "none",
        close_command        = "bdelete! %d",
        diagnostics          = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        show_buffer_icons     = true,
        show_buffer_close_icons = true,
        show_close_icon       = false,
        separator_style       = "thin",
        always_show_bufferline = true,
        offsets = {
          { filetype = "NvimTree", text = " FILE EXPLORER", text_align = "left", separator = true },
        },
      },
      -- Explicit hacker palette so bufferline never computes its own colors
      highlights = {
        fill                = { fg = "#005500", bg = "#000000" },
        background          = { fg = "#005500", bg = "#111111" },
        buffer_visible      = { fg = "#00AA00", bg = "#0D0D0D" },
        buffer_selected     = { fg = "#00FF00", bg = "#000000", bold = true },
        separator           = { fg = "#003300", bg = "#111111" },
        separator_visible   = { fg = "#003300", bg = "#0D0D0D" },
        separator_selected  = { fg = "#003300", bg = "#000000" },
        indicator_selected  = { fg = "#00FF00", bg = "#000000" },
        modified            = { fg = "#00AA00", bg = "#111111" },
        modified_selected   = { fg = "#00FF00", bg = "#000000" },
        close_button        = { fg = "#005500", bg = "#111111" },
        close_button_selected = { fg = "#00FF00", bg = "#000000" },
        tab                 = { fg = "#005500", bg = "#111111" },
        tab_selected        = { fg = "#00FF00", bg = "#000000", bold = true },
        tab_separator       = { fg = "#003300", bg = "#111111" },
        tab_separator_selected = { fg = "#003300", bg = "#000000" },
        tab_close           = { fg = "#005500", bg = "#000000" },
        numbers             = { fg = "#005500", bg = "#111111" },
        numbers_selected    = { fg = "#00FF00", bg = "#000000", bold = true },
        diagnostic          = { fg = "#005500", bg = "#111111" },
        diagnostic_selected = { fg = "#00AA00", bg = "#000000" },
        error               = { fg = "#FF2200", bg = "#111111" },
        error_selected      = { fg = "#FF2200", bg = "#000000" },
        warning             = { fg = "#AAAA00", bg = "#111111" },
        warning_selected    = { fg = "#AAAA00", bg = "#000000" },
        info                = { fg = "#00FF88", bg = "#111111" },
        info_selected       = { fg = "#00FF88", bg = "#000000" },
        hint                = { fg = "#00AA00", bg = "#111111" },
        hint_selected       = { fg = "#00FF00", bg = "#000000" },
        duplicate           = { fg = "#005500", bg = "#111111", italic = true },
        duplicate_selected  = { fg = "#00AA00", bg = "#000000", italic = true },
        offset_separator    = { fg = "#005500", bg = "#000000" },
      },
    },
  },

  -- ── Indentation guides ────────────────────────────────────────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    main  = "ibl",
    event = "BufReadPre",
    opts  = {
      indent  = { char = "│" },
      scope   = { enabled = true, show_start = false, show_end = false },
      exclude = {
        filetypes = { "help", "NvimTree", "lazy", "mason", "toggleterm" },
      },
    },
  },

  -- ── Dashboard (startup screen) ────────────────────────────────────────────
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha  = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗  ",
        "  ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗ ",
        "  ███████║███████║██║     █████╔╝ █████╗  ██████╔╝ ",
        "  ██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗ ",
        "  ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║ ",
        "  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ",
        "                                                     ",
        "         > SYSTEM COMPROMISED — ENTER NEOVIM <       ",
        "                                                     ",
      }

      dashboard.section.header.opts.hl = "Function"

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file",    ":Telescope find_files<cr>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<cr>"),
        dashboard.button("g", "  Live grep",    ":Telescope live_grep<cr>"),
        dashboard.button("e", "  Explorer",     ":NvimTreeToggle<cr>"),
        dashboard.button("l", "  Lazy plugins", ":Lazy<cr>"),
        dashboard.button("m", "  Mason LSPs",   ":Mason<cr>"),
        dashboard.button("q", "  Quit",         ":qa<cr>"),
      }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl        = "Keyword"
        button.opts.hl_shortcut = "Function"
      end

      dashboard.section.footer.val = { "[ NEOVIM — " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch .. " ]" }
      dashboard.section.footer.opts.hl = "Comment"

      alpha.setup(dashboard.config)
    end,
  },
}
