let mapleader = "\<Space>"
filetype plugin indent on
syntax on

" SET section
set tabstop=4
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set scrolloff=999
set showcmd
set smartcase
set hlsearch
set incsearch
set wildmenu
set wildmode=longest:full
set ruler
set backspace=indent,eol
set laststatus=2
set relativenumber
set ignorecase
set smartcase


"REMAP section
nnoremap <leader>f 1z=
nnoremap <leader>s :set spell!<CR>
inoremap jk <ESC>
nnoremap <CR> :noh<CR><CR>

execute pathogen#infect()
" set spell spellang=en_us
