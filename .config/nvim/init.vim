call plug#begin()
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" language support
Plug 'leafgarland/typescript-vim'
Plug 'tomlion/vim-solidity'

" automatically set tab options
Plug 'tpope/vim-sleuth'

" linting
Plug 'w0rp/ale'

" tpope
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-sensible'

Plug 'wincent/terminus' " focus reporting

Plug 'tomasr/molokai'

Plug 'scrooloose/nerdtree'
call plug#end()

colorscheme molokai

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

set updatetime=100

" ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_python_auto_pipenv = 1

" fzf
let g:fzf_buffers_jump = 1
nnoremap <leader>f :GitFiles<cr>

" nerdtree
map <C-n> :NERDTreeToggle<CR>
