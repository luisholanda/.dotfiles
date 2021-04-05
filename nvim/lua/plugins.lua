local vim = vim or {}

vim.cmd [[packadd packer.nvim]]

local packages = {
  'wbthomason/packer.nvim',

    -- Text objects
  'jiangmiao/auto-pairs',
  'tpope/vim-surround',
  'wellle/targets.vim',
  'gcmt/wildfire.vim',

  -- Color-schemes
  'sainnhe/sonokai',

  -- Syntax
  'sheerun/vim-polyglot',
  'nvim-treesitter/nvim-treesitter',

  -- Appearance
  'Yggdroot/indentLine',
  'rbong/vim-crystalline',
  'norcalli/nvim-colorizer.lua',

  -- LSP
  {
    'neovim/nvim-lspconfig',
    requires = {
      'hrsh7th/nvim-compe',
      'nvim-lua/lsp-status.nvim',
      'tjdevries/lsp_extensions.nvim',
      'norcalli/snippets.nvim',
    },
  },
  {
    'RishabhRD/nvim-lsputils',
    requires = {
      'RishabhRD/popfix'
    }
  },
  'glepnir/lspsaga.nvim',

  -- Interface
  {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim'
    },
  },
  -- {
  --   'kristijanhusak/vim-dadbod-ui',
  --   requires = {
  --     'tpope/vim-dadbod',
  --     'kristijanhusak/vim-dadbod-completion'
  --   },
  -- },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  },
  'TimUntersberger/neogit',
  'pwntester/octo.nvim',

  -- Language specific
  'rust-lang/rust.vim',

  -- Fuzzy search
  {
    'junegunn/fzf',
    run = './install --all',
    requires = {
      { 'junegunn/fzf.vim' }
    },
  },

  -- Extras
  'mhinz/vim-rfc',
  'prabirshrestha/async.vim',
  'airblade/vim-rooter',
}

return require('packer').startup {
  function(use)
    for _, pkg in pairs(packages) do
      use(pkg)
    end
  end,
  config = {
    display = {
      _open_fn = function(name)
        local ok, float_win = pcall(function()
          return require('plenary.window.float').percentage_range_window(0.8, 0.8)
        end)

        if not ok then
          vim.cmd [[65vnew [packer] ]]
          return vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
        end

        local bufnr = float_win.buf
        local win = float_win.win

        vim.api.nvim_buf_set_name(bufnr, name)
        vim.api.nvim_win_set_option(win, 'winblend', 10)

        return win, bufnr
      end
    }
  }
}
