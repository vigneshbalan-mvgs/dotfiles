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
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        -- Add any configuration options here
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
}
