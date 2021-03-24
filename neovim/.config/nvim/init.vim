syntax enable

colorscheme molokai

let mapleader = ","
nnoremap <leader><space> :noh<cr>

nnoremap <leader>ge :e $MYVIMRC<cr>

iabbr @@ Kostis Karantias <kkarantias@gmail.com>

set ignorecase
set smartcase

nnoremap ; :
vnoremap ; :

nnoremap * *N
vnoremap * y<esc>/\V<c-r>"<cr>N

nnoremap / /\v
nnoremap ? ?\v

nnoremap n nzz
nnoremap N Nzz

cmap w!! w !sudo tee > /dev/null %

set cinoptions=g2,h2

" fzf
let g:fzf_buffers_jump = 1
nnoremap <leader>f :GitFiles<cr>

function! SetupLatex()
    setl spell
    setl linebreak

    " TODO: should write a function to exchange two keys instead of doing this
    " manually
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
    nnoremap <buffer> 0 g0
    nnoremap <buffer> $ g$
    nnoremap <buffer> gj j
    nnoremap <buffer> gk k
    nnoremap <buffer> g0 0
    nnoremap <buffer> g$ $
    nnoremap <cr> :!(cd $(git rev-parse --show-toplevel) && make)<cr>
endfunction

augroup tex_stuff
    autocmd!
    autocmd FileType tex call SetupLatex()
    autocmd FileType plaintex setl ft=tex
augroup END

let g:coc_global_extensions = ['coc-go', 'coc-git']
source ~/.config/nvim/coc-necessities.vim
