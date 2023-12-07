let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set relativenumber

call plug#begin()

" Secure modelines
Plug 'ciaranm/securemodelines'

" Sneak
Plug 'justinmk/vim-sneak'

" Better lightline
Plug 'itchyny/lightline.vim'

" Highlight yank
Plug 'machakann/vim-highlightedyank'

" Extend % to work for if endif etc.
Plug 'andymass/vim-matchup'

" Autoset work directory to project root when opening file
Plug 'airblade/vim-rooter'

" Rust support
Plug 'rust-lang/rust.vim'

" Align text using regular expressions
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown' " Must come after tabular

" GitHub Copilot
Plug 'github/copilot.vim'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" color theme
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

" shortcut :F and :B for files and buffers
command! -bang F call fzf#vim#files('~/', <bang>0)
command! -bang B call fzf#vim#buffers(<bang>0)
command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}), <bang>0)


" Control-P for :PRg
nnoremap <C-p> :PRg<Cr>

" Control-B for :B
nnoremap <C-b> :B<Cr>

" Set color theme
set t_Co=256
set background=dark
colorscheme PaperColor

" Replace f and t with 1 character sneak
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Make s go to next highlighted for vim sneak
let g:sneak#s_next = 1

" Make highlighted yank last 5 seconds
let g:highlightedyank_highlight_duration = 5000
