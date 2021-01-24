" neovim config
"
" Useful stuff: https://phaazon.net/blog/editors-in-2020

" Plugins
call plug#begin(stdpath('data') . '/plugged')

" sonokai is a color scheme
Plug 'sainnhe/sonokai'

" icons for stuff
Plug 'ryanoasis/vim-devicons'

" haskell
Plug 'neovimhaskell/haskell-vim'

" fuzzy-find
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" lightline status line
Plug 'itchyny/lightline.vim'

" easymotion
Plug 'easymotion/vim-easymotion'

" vim-nix
Plug 'LnL7/vim-nix'

call plug#end()


" Spaces, not tabs (sorry Luke)
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab


" Color scheme
if has('termguicolors')
  set termguicolors
endif
let g:sonokai_style = 'shusia'
colorscheme sonokai
let g:lightline = {
    \ 'colorscheme': 'sonokai',
    \ }


" Keyboard configuration
:let mapleader = "\<Space>"

