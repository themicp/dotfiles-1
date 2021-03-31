set termguicolors
syntax enable
colorscheme tender
set number

let mapleader = ","
nnoremap <leader><space> :noh<cr>

nnoremap <leader>ge :e $MYVIMRC<cr>

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
endfunction

augroup tex_stuff
    autocmd!
    autocmd FileType tex call SetupLatex()
    autocmd FileType plaintex setl ft=tex
augroup END

let g:airline_powerline_fonts = 1
let g:coc_global_extensions = ['coc-go', 'coc-git', 'coc-json']
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
source ~/.config/nvim/coc-necessities.vim
