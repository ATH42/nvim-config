local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}
-- code formats on save
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use {
    'kyazdani42/nvim-tree.lua', commit = "ce463a5",
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use "moll/vim-bbye" -- closes buffers without closing window
  use "nvim-lualine/lualine.nvim" -- bufferline
  use { "akinsho/toggleterm.nvim", tag = 'v1.*', config = function() -- toggles multiple terminals
    require("toggleterm").setup()
  end }
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
  use "ahmedkhalf/project.nvim" -- look through frecent projects
  use "lewis6991/impatient.nvim" -- faster vim
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim" -- startup dashboard
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim" -- popup help for keymaps

  -- Colorschemes
  use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use 'folke/tokyonight.nvim'
  use "lunarvim/darkplus.nvim"
  use 'rockerBOO/boo-colorscheme-nvim'
  use 'shaunsingh/nord.nvim'
  use 'overcache/NeoSolarized'
  use 'kyazdani42/blue-moon'
  use 'rktjmp/lush.nvim'
  use 'RishabhRD/gruvy'
  use "rebelot/kanagawa.nvim"
  use "phha/zenburn.nvim"
  --[[ use { ]]
  --[[   "catppuccin/nvim", ]]
  --[[   as = "catppuccin", ]]
  --[[   config = function() ]]
  --[[     vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha ]]
  --[[     require("catppuccin").setup() ]]
  --[[     vim.api.nvim_command "colorscheme catppuccin" ]]
  --[[   end ]]
  --[[ } ]]
  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- prettier
  use 'sbdchd/neoformat'

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  use "github/copilot.vim"
  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
