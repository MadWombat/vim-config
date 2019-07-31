" this is required by everything
set nocompatible
" do this first, so colors in plug don't get screwed up
syntax on

" install vim-plug if not already there
let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path . ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

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
Plug 'scrooloose/nerdtree'                                    " navigation tree
Plug 'Xuyuanp/nerdtree-git-plugin'                            " nerdtree git support
Plug 'vim-airline/vim-airline'                                " better status line
Plug 'vim-airline/vim-airline-themes'                         " themes for airline
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'beyondmarc/glsl.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'udalov/kotlin-vim'
Plug 'lifepillar/pgsql.vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'bfrg/vim-cpp-modern'
Plug 'dart-lang/dart-vim-plugin'
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

if plug_install
    PlugInstall --sync
endif
unlet plug_install

"
" global settings
"
set background=dark
colorscheme badwolf

if has("gui_macvim")
    set antialias
    set guioptions-=rRlL
    set guifont="Knack Nerd Font 11"
endif

set laststatus=2

set exrc
set secure

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

" disable python2 support
let g:loaded_python_provider = 1
let g:python_host_prog = '/Users/dmitriy.kropivnitski/.pyenv/versions/neovim2/bin/python2'
let g:python3_host_prog = '/Users/dmitriy.kropivnitski/.pyenv/versions/3.6.8/bin/python3'

" file browsing
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" map NERDTree
let NERDTreeWinSize=50
map <F2> :NERDTreeToggle<CR>

" map for align module
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" location list toggle
nnoremap <leader>l :CocList diagnostics<CR>

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
au FileType python let g:pymode_run=0
au FileType python let b:coc_root_patterns = ['.git', '.env']
au FileType python nnoremap <leader>r :CocCommand python.runLinting

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
