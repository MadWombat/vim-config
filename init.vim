" this is required by everything
set nocompatible

" install vim-plug if not already there
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    execute '!curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

"
" vim plugins
"
call plug#begin('~/.config/nvim/plugins')

" tpope collection
Plug 'tpope/vim-sensible'   " sensible defaults
Plug 'tpope/vim-unimpaired' " bunch of mapping pairs
Plug 'tpope/vim-commentary' " easy comments
Plug 'tpope/vim-fugitive'   " awesome Git integration
Plug 'tpope/vim-surround'   " easy quotes/brackets
Plug 'tpope/vim-rsi'        " readline mappings in insert mode
" general IDE shit
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Konfekt/FastFold'                                       " cached folding
Plug 'neomake/neomake'                                        " async lint and make
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " async completion
Plug 'w0rp/ale'                                               " linter for multiple languages
Plug 'scrooloose/nerdtree'                                    " navigation tree
Plug 'Xuyuanp/nerdtree-git-plugin'                            " nerdtree git support
Plug 'vim-airline/vim-airline'                                " better status line
Plug 'vim-airline/vim-airline-themes'                         " themes for airline
Plug 'Valloric/ListToggle'                                    " quick open/close of list windows
" python 
Plug 'python-mode/python-mode', { 'for': 'python'}
" other languages support
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'leafgarland/typescript-vim'
Plug 'gavocanov/vim-js-indent'
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go'
Plug 'uarun/vim-protobuf'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'hashivim/vim-terraform'
Plug 'farfanoide/vim-kivy'
Plug 'neovimhaskell/haskell-vim'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh',}
Plug 'beyondmarc/glsl.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'udalov/kotlin-vim'
Plug 'lifepillar/pgsql.vim'
" misc
Plug 'chr4/nginx.vim'
Plug 'junegunn/vim-easy-align'
Plug 'gregsexton/gitv'
Plug 'digitaltoad/vim-pug'
Plug 'ddollar/nerdcommenter'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'flazz/vim-colorschemes'

call plug#end()

"
" global settings
"
syntax on
set background=dark
colorscheme badwolf

if has("gui_macvim")
    set antialias
    set guioptions-=rRlL
    set guifont="Knack Nerd Font 11"
endif

set laststatus=2

set ttyfast
set lazyredraw
set hidden
set wildmenu
set incsearch
set encoding=utf-8
let base16colorspace=256
set t_Co=256

" sensible tab/indent defaults
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set fileformat=unix

" never autowrap text and set textwidth to a reasonable number
set wrapmargin=0
set textwidth=150

" small conveniences
set cursorline
set showmatch

" relative line numbers
set number
set relativenumber

set pastetoggle=<F3>

" set vertical split for diffs
set diffopt+=vertical

" airline settings
let g:airline_theme='badwolf'
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts=1

" language client
let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie', '--lsp'], 
    \ 'python': ['pyls'],
    \ }

" deoplete completion
let g:deoplete#enable_at_startup = 1
let g:deoplete_disable_auto_complete=1
call deoplete#custom#buffer_option('auto_complete', v:false)
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

let g:deoplete#sources = {}
let g:deoplete#sources.cpp = ['LanguageClient']
let g:deoplete#sources.python = ['LanguageClient']
let g:deoplete#sources.python3 = ['LanguageClient']
let g:deoplete#sources.rust = ['LanguageClient']
let g:deoplete#sources.c = ['LanguageClient']
let g:deoplete#sources.vim = ['vim']

" ale linting
let g:ale_sign_column_always = 0
let g:ale_emit_conflict_warnings = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linters = {'python': ['pyls', ], 'go': ['gofmt', 'govet']}

" file browsing
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" map NERDTree
let NERDTreeWinSize=50
map <F2> :NERDTreeToggle<CR>

" map for align module
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" quickfix and location toggle
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" session settings
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:session_directory = '~/.config/nvim/sessions/'

" move viminfo to.vim
set viminfo+=n~/.config/nvim/viminfo

" stay in the current directory when opening files
set noautochdir
" fold with space
nnoremap <space> za
" quick save
noremap <Leader>w :write<CR>
" find shit in python files
map <C-w><C-f> :vimgrep <cword> **/*.py <Bar> copen <CR>

"
" language specific settings
"
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" javascript
au FileType javascript set tabstop=2
au FileType javascript set softtabstop=2
au FileType javascript set shiftwidth=2

" python
au FileType python set colorcolumn=150
au FileType python set wrapmargin=0
au FileType python set textwidth=150
au FileType python let python_highlight_all = 1

au FileType python let g:pymode_folding = 1
au FileType python let g:pymode_python='python3'
au FileType python let g:pymode_lint=0
au FileType python let g:pymode_rope=0
au FileType python let g:pymode_rope_completion=0
au FileType python let g:pymode_rope_complete_on_dot=0
au FileType python let g:pymode_rope_auto_project=0
au FileType python let g:pymode_rope_enable_autoimport=0
au FileType python let g:pymode_rope_autoimport_generate=0
au FileType python let g:pymode_rope_guess_project=0
au FileType python let g:pymode_doc=0

" haskell
au FileType haskell let g:haskell_enable_quantification = 1
au FileType haskell let g:haskell_enable_recursivedo = 1
au FileType haskell let g:haskell_enable_arrowsyntax = 1
au FileType haskell let g:haskell_enable_pattern_synonyms = 1
au FileType haskell let g:haskell_enable_typeroles = 1
au FileType haskell let g:haskell_enable_static_pointers = 1
au FileType haskell let g:haskell_backpack = 1

" Go
au FileType go let g:go_metalinter_autosave_enabled = ['vet']

" SQL
au FileType sql let g:sql_type_default = 'pgsql'
