
source $HOME/.config/nvim/plugins.vim

" Enable truecolors
if (has("termguicolors"))
    set termguicolors
endif

" Themes
syntax enable
colorscheme onedark

" Copy paste between vim and everything else
set clipboard=unnamedplus

" Tabs and spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Editor UI
set relativenumber
set encoding=utf-8
set nowrap
set cursorline
set updatetime=300

" Split
:set splitbelow
:set splitright

" FZF
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
let $FZF_DEFAULT_COMMAND = 'rg --files'
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>F :Files ~<cr>
nnoremap <silent> <leader>g :Rg<cr>

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'onedark'

set noshowmode

" Terminal
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <leader>t :terminal<CR>

" Move beetwen windows
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move between buffers
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>

" Save 
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>=gi
nnoremap <leader>W :w suda://%<CR>

" Search
nnoremap * :let @/='\<'.expand('<cword>').'\>'<bar>set hlsearch<CR>
nnoremap <CR> :set nohlsearch<CR>

" Quit
nnoremap <silent> <leader>q :quit<CR>
nnoremap <silent> <leader>Q :quitall<CR>

" Buffers
nnoremap <leader>c :bp<bar>sp<bar>bn<bar>bd<CR>

" Reload vim config
nnoremap <leader>r :so $MYVIMRC<CR>

" Rustfmt
let g:rustfmt_autosave = 1

" Mix format
let g:mix_format_on_save = 1
