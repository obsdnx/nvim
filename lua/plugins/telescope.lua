return {
  {
    "nvim-telescope/telescope.nvim",
    cmd          = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond  = function() return vim.fn.executable("make") == 1 end,
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix   = "  ",
          selection_caret = "  ",
          entry_prefix    = "  ",
          sorting_strategy = "ascending",
          layout_strategy  = "horizontal",
          layout_config    = {
            horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
            vertical   = { mirror = false },
            width      = 0.87,
            height     = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = {
            "%.git/", "node_modules/", "%.cache/", "%.o", "%.a",
            "__pycache__/", "%.pyc", "%.class",
          },
          mappings = {
            i = {
              ["<C-j>"]   = actions.move_selection_next,
              ["<C-k>"]   = actions.move_selection_previous,
              ["<C-c>"]   = actions.close,
              ["<Down>"]  = actions.move_selection_next,
              ["<Up>"]    = actions.move_selection_previous,
              ["<CR>"]    = actions.select_default,
              ["<C-x>"]   = actions.select_horizontal,
              ["<C-v>"]   = actions.select_vertical,
              ["<C-u>"]   = actions.preview_scrolling_up,
              ["<C-d>"]   = actions.preview_scrolling_down,
              ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"]   = actions.send_to_qflist + actions.open_qflist,
            },
            n = {
              ["<Esc>"]   = actions.close,
              ["j"]       = actions.move_selection_next,
              ["k"]       = actions.move_selection_previous,
              ["<CR>"]    = actions.select_default,
              ["<C-x>"]   = actions.select_horizontal,
              ["<C-v>"]   = actions.select_vertical,
              ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"]   = actions.send_to_qflist + actions.open_qflist,
              ["gg"]      = actions.move_to_top,
              ["G"]       = actions.move_to_bottom,
              ["q"]       = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = vim.fn.executable("fd") == 1
              and { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
              or  nil,
          },
          live_grep = {
            additional_args = { "--hidden", "--glob=!.git" },
          },
          buffers = {
            sort_mru        = true,
            ignore_current_buffer = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy                   = true,
            override_generic_sorter = true,
            override_file_sorter    = true,
            case_mode               = "smart_case",
          },
        },
      })

      pcall(telescope.load_extension, "fzf")
    end,
  },
}
