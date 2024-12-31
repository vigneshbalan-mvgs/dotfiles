return {
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
  {
    "gen740/SmoothCursor.nvim",
    config = function()
      require("smoothcursor").setup({
        autostart = true,
        cursor = "nf-fae-glass", -- This sets the cursor icon (you can choose another)
        fancy = {
          enable = true,
          head = { cursor = "", texthl = "SmoothCursor" }, -- Customize cursor head
        },
      })
    end,
  },
  -- {
  --   "stevearc/oil.nvim",
  --   config = function()
  --     require("oil").setup({
  --       -- Add any configuration options here
  --       view_options = {
  --         show_hidden = true,
  --       },
  --     })
  --   end,
  -- },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          layout_config = {
            horizontal = { preview_width = 0.6 },
          },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- Keybinding to open Telescope with leader-space
  config = function()
    vim.api.nvim_set_keymap("n", "<Space>", ":Telescope find_files<CR>", { noremap = true, silent = true })
  end,
}
