call plug#begin()
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" colorscheme
Plug 'cocopon/iceberg.vim'

" automatically set tab options
Plug 'tpope/vim-sleuth'

" linting
Plug 'w0rp/ale'

" tpope
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-tbone'
call plug#end()

silent! colorscheme iceberg

let mapleader = ","
nnoremap <leader><space> :noh<cr>

iabbr @@ Kostis Karantias <kkarantias@gmail.com>

set ignorecase
set smartcase

nnoremap * *N
vnoremap * y<esc>/\V<c-r>"<cr>N

nnoremap / /\v
nnoremap ? ?\v

nnoremap n nzz
nnoremap N Nzz

cmap w!! w !sudo tee > /dev/null %

set cinoptions=g2,h2

" ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_fix_on_save = 1

" fzf
let g:fzf_buffers_jump = 1
nnoremap <leader>f :GitFiles<cr>
