vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.g.mapleader=" "
-- custom shortcuts
vim.keymap.set("n", "<leader>n", ":bnext<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>p", ":bprevious<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", ":bdelete<cr>", { noremap = true, silent = true })
vim.keymap.set('t', '°', [[<C-\><C-n>]], { noremap = true })

-- Lazy setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}
local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}},
  {"nvim-treesitter/nvim-treesitter", build= ":TSUpdate"},
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
}

-- individual plugin setup
require("lazy").setup(plugins, opts)

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "python"},
  highlight = { enable = true },
  indent = { enable = true }
})

