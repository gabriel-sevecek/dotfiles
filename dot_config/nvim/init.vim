if &compatible
  set nocompatible
endif
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim
set rtp+=/usr/local/opt/fzf

if dein#load_state('~/.local/share/dein')
    call dein#begin('~/.local/share/dein')

    call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

    call dein#add('markonm/traces.vim')
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    call dein#add('vim-airline/vim-airline')
    call dein#add('myusuf3/numbers.vim')
    call dein#add('scrooloose/nerdcommenter')
    call dein#add('machakann/vim-sandwich')

    call dein#add('pangloss/vim-javascript')
    call dein#add('HerringtonDarkholme/yats.vim')
    call dein#add('peitalin/vim-jsx-typescript')
    call dein#add('evanleck/vim-svelte')

    call dein#add('mbbill/undotree')

    "bclose is dep of ranger
    "call dein#add('rbgrouleff/bclose.vim')
    "call dein#add('francoiscabrol/ranger.vim')
    call dein#add('kevinhwang91/rnvimr')

    call dein#add('mhinz/vim-startify')
    call dein#add('nvim-treesitter/nvim-treesitter')
    call dein#add('neovim/nvim-lspconfig')
    call dein#add('glepnir/lspsaga.nvim')

    call dein#add('hrsh7th/vim-vsnip')

    call dein#add('hrsh7th/nvim-cmp')
    call dein#add('hrsh7th/cmp-nvim-lsp', {'depends': 'nvim-cmp'})
    call dein#add('hrsh7th/cmp-buffer', {'depends': 'nvim-cmp'})
    call dein#add('hrsh7th/cmp-vsnip', {'depends': 'nvim-cmp'})
    call dein#add('hrsh7th/cmp-path', {'depends': 'nvim-cmp'})

    call dein#add('kyazdani42/nvim-web-devicons')
    call dein#add('romgrk/barbar.nvim')

    call dein#add('lukas-reineke/indent-blankline.nvim', { 'rev': 'lua'})

    call dein#add('folke/which-key.nvim')

    call dein#add('akinsho/nvim-toggleterm.lua')

    call dein#add('EdenEast/nightfox.nvim')
    call dein#add('rmehri01/onenord.nvim')
    call dein#add('cocopon/iceberg.vim')
    call dein#add('dracula/vim')

    call dein#add('folke/trouble.nvim')

    call dein#add('chentau/marks.nvim')

    call dein#add('vim-test/vim-test')

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

" nvim-cmp
set completeopt=menu,menuone,noselect

" Undo
set undodir=~/.local/share/nvim/undo
set undofile
set undolevels=1000

"TAB settings.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>

"Mouse
set mouse=a

"Settings for Searching and Moving
" nnoremap / /\v
" vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

"Quickfix
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>

"Buffers
nnoremap <M-]> :BufferNext<cr>
nnoremap <M-[> :BufferPrevious<cr>
nnoremap <M-p> :BufferPick<cr>

" colors
set termguicolors
"colorscheme iceberg
" colorscheme nord
"colorscheme onenord
"colorscheme dracula

" Remove scrollbars
:set guioptions-=r
:set guioptions-=L

" \s Shortcut to substitute word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>

nmap ,cr :let @+=expand("%")<CR>
nmap ,ca :let @+=expand("%:p")<CR>
nmap ,ct :let @+=expand("%:t")<CR>

set hidden
set number

" Ranger
:nnoremap <Leader>r :RnvimrToggle<cr>
let g:rnvimr_enable_picker = 1
let g:rnvimr_layout = {
    \ 'relative': 'editor',
    \ 'width': &columns,
    \ 'height': &lines - 2,
    \ 'col': 0,
    \ 'row': 0,
    \ 'style': 'minimal'
    \ }
let g:rnvimr_presets = [{}]

" Search filenames
:nnoremap <Leader>ff :FZF<cr>
:nnoremap <Leader>fg :GFiles<cr>
" Ripgrep 
:nnoremap <Leader>fr :Rg<cr>
" Ripgrep word under cursor
:nnoremap <Leader>fs :Rg <C-r><C-w><cr>
" Search open buffers content
:nnoremap <Leader>fl :Lines<cr>
" Search open buffers names
:nnoremap <Leader>fb :Buffers<cr>
" Search history of opened files
:nnoremap <Leader>fh :History<cr>

autocmd BufNewFile,BufRead *.tsx,*.jsx,*.js, set filetype=typescriptreact
autocmd BufNewFile,BufRead *.ts,*.tsx,*.js,*.jsx set suffixesadd=.js,.jsx,.ts,.tsx

let g:python3_host_prog = '~/.pyenv/versions/3.10.0/bin/python'
let g:python_host_prog = '~/.pyenv/versions/2.7.17/bin/python'

" vsnip
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Staritfy
let g:startify_change_to_dir = 0
let g:startify_bookmarks = [ {'i': '~/.config/nvim/init.vim'}, {'z': '~/.zshrc'} ]

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
augroup END

command! -nargs=0 Format :lua vim.lsp.buf.formatting()

lua << EOF
  require('cmp-setup')
  require('lsp')
  require('toggle-term')

  -- treesitter
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
  };

  -- marks.nvim
  require'marks'.setup {}

  -- nightfox colorscheme
  local nightfox = require('nightfox')
  nightfox.setup({
    -- fox = "nordfox",
  })
  nightfox.load()

  -- local saga = require 'lspsaga'
  -- saga.init_lsp_saga()
EOF

hi LspDiagnosticsDefaultError ctermbg=234 ctermfg=203 guibg=#161821 guifg=#e27878
hi LspDiagnosticsUnderlineError ctermbg=95 ctermfg=252 gui=undercurl guifg=NONE guisp=#e27878

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

let g:indent_blankline_show_current_context = v:true

set backupcopy=yes

let g:test#neovim#start_normal = 1
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
