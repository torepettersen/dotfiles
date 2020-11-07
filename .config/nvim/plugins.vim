" Automatically install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'lambdalisue/suda.vim'

" Themes
Plug 'joshdick/onedark.vim'

" Rust
Plug 'rust-lang/rust.vim'

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'

" Elm
Plug 'ElmCast/elm-vim'

" Docker
Plug 'ekalinin/dockerfile.vim'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
