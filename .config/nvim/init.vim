set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set relativenumber

call plug#begin()

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" shortcut :F and :B for files and buffers
command! -bang F call fzf#vim#files('~/', <bang>0)
command! -bang B call fzf#vim#buffers(<bang>0)

" Control-P for :F
nnoremap <C-p> :F<Cr>
nnoremap <C-b> :B<Cr>
