" -----------------------------
" Plugin Section (vim-plug)
" -----------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'plasticboy/vim-markdown'

call plug#end()


" -----------------------------
" Basic Settings
" -----------------------------
set number
set relativenumber
set wrap
set linebreak
syntax on
filetype plugin indent on


" -----------------------------
" Markdown Settings
" -----------------------------
let g:vim_markdown_folding_disabled = 0
set foldmethod=expr
set foldexpr=vim_markdown#foldexpr()
set conceallevel=2
