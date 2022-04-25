require "paq" {
    { "junegunn/fzf", hook=vim.fn["fzf#install"] };
    "junegunn/fzf.vim";
    "tpope/vim-fugitive";
    "airblade/vim-gitgutter";
    "myusuf3/numbers.vim";
    "scrooloose/nerdcommenter";
    "machakann/vim-sandwich";
    "pangloss/vim-javascript";
    "HerringtonDarkholme/yats.vim";
    "peitalin/vim-jsx-typescript";
    "evanleck/vim-svelte";
    "mbbill/undotree";
    "mhinz/vim-startify";
    "nvim-treesitter/nvim-treesitter";
    "neovim/nvim-lspconfig";
    "glepnir/lspsaga.nvim";
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-path";
    "kyazdani42/nvim-web-devicons";
    "nvim-lua/plenary.nvim";
    "MunifTanjim/nui.nvim";
    "nvim-neo-tree/neo-tree.nvim";
    "romgrk/barbar.nvim";
    "folke/which-key.nvim";
    "akinsho/nvim-toggleterm.lua";
    "EdenEast/nightfox.nvim";
    "cocopon/iceberg.vim";
    "dracula/vim";
    "folke/trouble.nvim";
    "chentau/marks.nvim";
    "vim-test/vim-test";
    "is0n/fm-nvim";
    "posva/vim-vue";
    "kevinhwang91/nvim-bqf";
    "nvim-lualine/lualine.nvim";
    "lewis6991/impatient.nvim";
}

require('impatient')

local set = vim.opt

set.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"
set.undofile = true
set.undolevels = 1000

set.mouse = "a"
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.number = true
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.showmatch = true
set.hlsearch = true

set.termguicolors = true
vim.cmd [[
    colorscheme nightfox
]]

vim.g.startify_change_to_dir = 0
vim.g.startify_bookmarks = {{
    i = "~/.config/nvim/init.lua",
    z = "~/.zshrc",
}}

vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

function highlight_on_yank()
    vim.highlight.on_yank { on_visual=false }
end
vim.api.nvim_create_autocmd("TextYankPost * silent!", { callback = highlight_on_yank })

vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
vim.api.nvim_set_keymap("n", "]q", ":cnext<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[q", ":cprev<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><space>", ":nohl<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>s", ":%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>", { noremap = true })
vim.api.nvim_set_keymap("n", ",cr", ":let @+=expand(\"%:.\")<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ",ca", ":let @+=expand(\"%:p\")<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ",cf", ":let @+=expand(\"%:t\")<CR>", { noremap = true })


require('ranger-setup')
require('trouble-setup')
require('cmp-setup')
require('lsp')
require('toggle-term')
require('fzf')
require('barbar')
require('tree')
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
        },
    },
};
require'marks'.setup {}
require('fm-nvim').setup{
    ui = {
        float = {
            border = 'single',
        },
    },
}

require("which-key").setup {}
require'lualine'.setup {
    sections = {
        lualine_c = {{'filename', path = 1}},
    }
}
