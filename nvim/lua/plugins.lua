local vim = vim or {}

vim.cmd [[packadd packer.nvim]]
vim._update_package_paths()

local packages = {
  { 'wbthomason/packer.nvim', opt = true },

    -- Text objects
  'jiangmiao/auto-pairs',
  'tpope/vim-surround',
  'wellle/targets.vim',
  'gcmt/wildfire.vim',

  -- Color-schemes
  'Iron-E/nvim-highlite',
  'nightsense/snow',
  'axvr/photon.vim',
  'davidosomething/vim-colors-meh',
  'andreypopp/vim-colors-plain',

  -- Syntax
  'sheerun/vim-polyglot',

  -- Appearance
  'Yggdroot/indentLine',
  'rbong/vim-crystalline',
  {
    'norcalli/nvim-colorizer.lua',
    config = 'require [[colorizer]].setup()'
  },

  -- LSP
  'tjdevries/nlua.nvim',
  {
    'neovim/nvim-lsp',
    requires = {
      'nvim-lua/completion-nvim',
      'nvim-lua/diagnostic-nvim',
      'nvim-lua/lsp-status.nvim',
      'tjdevries/lsp_extensions.nvim'
    },
    config = 'require [[lsp_config]].setup()'
  },

  -- Git
  'airblade/vim-gitgutter',

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
  { 'mhinz/vim-rfc', cmd = 'RFC' },
  'prabirshrestha/async.vim',
  'airblade/vim-rooter',
  { 'skywind3000/asyncrun.vim', cmd = 'AsyncRun' },
}

return require('packer').startup {
  function(use)
    for _, pkg in pairs(packages) do
      use(pkg)
    end

    vim._update_package_paths()
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
