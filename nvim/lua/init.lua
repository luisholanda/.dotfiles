require("completion")
require("config")
require("plugins")
require("essentials")
require("statusline")
require("keymaps")

require("gitsigns").setup {
    numhl = false,
    signs = {
        add = { text = "┃", hl = "GitGutterAdd" },
        change = { text = "┃", hl = "GitGutterChange" },
        delete = { text = "◢", hl = "GitGutterDelete" },
        topdelete = { text = "◥", hl = "GitGutterDelete" },
        changedelete = { text = "◢", hl = "GitGutterChangeDelete" },
    },
}

require("nvim-treesitter.configs").setup {
    highlight = { enable = true, use_languagetree = true },
    textsubjects = { enable = true, keymaps = { ["<cr>"] = "textsubjects-smart" } },
    indent = { enable = false },
}

vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]

require("colorizer").setup()
require("lsp/config").setup()
require("lsp/saga").setup()

require"compe".setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        path = true,
        buffer = false,
        calc = false,
        vsnip = false,
        nvim_lsp = true,
        nvim_lua = true,
        spell = true,
        tags = false,
        snippets_nvim = true,
        treesitter = false,
        vim_dadbod_completion = false,
    },
}

require("telescope").setup {
    defaults = {
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename", "--line-number",
            "--column", "--smart-case",
        },
        layout_strategy = "horizontal",
        layout_defaults = { horizontal = { mirror = false, preview_width = 0.5 } },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        mapping = { i = { ["<esc>"] = require("telescope.actions").close } },
    },
}

require("lightspeed").setup { highlight_unique_chars = true }

require("rust-tools").setup {
    tools = {
        inlay_hints = { parameter_hints_prefix = "ᐊ", other_hints_prefix = "ᐅ " },
    },
}
