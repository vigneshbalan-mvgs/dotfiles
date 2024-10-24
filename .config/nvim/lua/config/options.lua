-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- -- Add this in your LazyVim config
vim.opt.guicursor = {
  "n-v-c:block", -- Block cursor in normal mode
  "i-ci-ve:ver25", -- Vertical line in insert mode
  "r-cr:hor20", -- Horizontal bar in replace mode
  "o:hor50", -- Half-size horizontal bar in operator pending mode
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- Blink settings for all modes
}
