local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
require("lazy").setup({
    { "junegunn/fzf", build=":call fzf#install()" };
    "junegunn/fzf.vim";
    "tpope/vim-fugitive";
    "myusuf3/numbers.vim";
    { 'echasnovski/mini.comment', version = false },
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
    "nvim-tree/nvim-web-devicons";
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
    "chentoast/marks.nvim";
    "vim-test/vim-test";
    "is0n/fm-nvim";
    "posva/vim-vue";
    "kevinhwang91/nvim-bqf";
    "nvim-lualine/lualine.nvim";
    "lewis6991/impatient.nvim";
    "jose-elias-alvarez/null-ls.nvim";
    "L3MON4D3/LuaSnip";
    "rafamadriz/friendly-snippets";
    "saadparwaiz1/cmp_luasnip";
    "lewis6991/gitsigns.nvim";
    "rbong/vim-flog";
    "stevearc/oil.nvim";
    "williamboman/mason.nvim";
})

require("impatient")

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
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.node_host_prog = "/Users/g.sevecek/.nvm/versions/node/v14.21.2/bin/neovim-node-host"


function highlight_on_yank()
    vim.highlight.on_yank { on_visual=false }
end
vim.api.nvim_create_autocmd("TextYankPost", { pattern = "*", callback = highlight_on_yank })

vim.api.nvim_create_user_command("Format", function() vim.lsp.buf.format { async = true } end, {})
vim.api.nvim_set_keymap("n", "]q", ":cnext<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[q", ":cprev<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><space>", ":nohl<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>s", ":%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>", { noremap = true })
vim.api.nvim_set_keymap("n", ",cr", ":let @+=expand(\"%:.\")<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ",ca", ":let @+=expand(\"%:p\")<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ",cf", ":let @+=expand(\"%:t\")<CR>", { noremap = true })

local null_ls = require("null-ls");

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.pg_format,
        null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.nixpkgs_fmt,
        null_ls.builtins.code_actions.eslint,
    },
})

local wk = require("which-key")

require("gitsigns").setup{
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Navigation
        vim.keymap.set("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
        end, {expr=true})

        vim.keymap.set("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
        end, {expr=true})

        wk.register({
            h = {
                name = "GitSigns",
                s = { ":Gitsigns stage_hunk<CR>", "Stage hunk" },
                r = { ":Gitsigns reset_hunk<CR>", "Reset hunk" },
                u = { gs.undo_stage_hunk, "Undo stage hunk" },
                S = { gs.stage_buffer, "Stage buffer" },
                R = { gs.reset_buffer, "Reset buffer" },
                p = { gs.preview_hunk, "Preview hunk" },
                b = { function() gs.blame_line{full=true} end, "Blame with diff" },
                t = { gs.toggle_current_line_blame, "Inline blame" },
                d = { gs.diffthis, "Diff" },
                D = { function() gs.diffthis("~") end, "Diff agains HEAD" },
                x = { gs.toggle_deleted, "Show old version of hunk" },
            }
        }, { prefix = "<leader>"})
    end
}
require("ranger-setup")
require("trouble-setup")
require("cmp-setup")
require("lsp")
require("toggle-term")
require("fzf")
require("barbar-setup")
require("tree")
require("tests")
require"nvim-treesitter.configs".setup {
    -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "vue", "markdown", "markdown_inline" },
    -- highlight = {
    --     enable = true,
    -- },
    -- incremental_selection = {
    --     enable = true,
    --     keymaps = {
    --         init_selection = "<CR>",
    --         scope_incremental = "<CR>",
    --         node_incremental = "<TAB>",
    --         node_decremental = "<S-TAB>",
    --     },
    -- },
    ensure_installed = "all", -- or a list of languages
        highlight = {
            enable = true, -- false will disable the whole extension
        },
        indent = {
            enable = true,
        },
        folding = {
            enable = true -- enables folding
        }

};
require"marks".setup {}
require("fm-nvim").setup{
    ui = {
        float = {
            border = "single",
        },
    },
}

require("which-key").setup {}
require"lualine".setup {
    sections = {
        lualine_c = {{"filename", path = 1}},
    }
}
require("luasnip.loaders.from_vscode").lazy_load()
require"luasnip".filetype_extend("typescript", {"typescript", "javascript", "javascriptreact-ts"})
require("oil").setup {}
require("oil-setup")
require('mini.comment').setup()
require("mason").setup()
