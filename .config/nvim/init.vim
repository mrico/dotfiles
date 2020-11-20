call plug#begin('~/.local/share/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'will133/vim-dirdiff'

call plug#end()

set background=dark
set number 
set guicursor=

set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

syntax on
colorscheme onedark

tnoremap <esc> <c-\><c-n>
nnoremap <f2> :Files<cr>
nnoremap <F3> g]
nnoremap <f12> :!ctags -R -f tags .<cr>


autocmd FileType scala setlocal commentstring=//\ %s

