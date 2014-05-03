if has('vim_starting')
set nocompatible               "vi互換解除

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

"Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" originalrepos on github
" " .vimrcを開く
nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>
" source ~/.vimrc を実行する。
nnoremap <Space>,  :<C-u>source $MYVIMRC<CR>

nnoremap <silent><Space>j    :Explore<CR>

 " Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
        let g:make = 'make'
endif
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': g:make}}
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'Shougo/vimshell'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'basyura/unite-rails'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
"NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-rails'
"NeoBundle 'tpope/vim-endwise.git'
"NeoBundle 'https://bitbucket.org/kovisoft/slimv'
NeoBundle 'vim-scripts/dbext.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'violetyk/cake.vim'
"NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'

call neobundle#end()

"Unite setting
""prefix
nnoremap [unite] <Nop>
nmap    <Space>u [unite]

"unite.vim
nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f   :<C-u>Unite file -default-action=tabopen<CR>
nnoremap <silent> [unite]f   :<C-u>Unite file<CR>
nnoremap <silent> [unite]m   :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]t   :<C-u>Unite tab<CR>

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"tab setting
map  :t :tabnew

" Required:
filetype plugin indent on

filetype indent on
syntax on                      "シンタックス有効化

colorscheme Tomorrow-Night-Eighties

set noswapfile                 "swapファイルを無効化
set backspace=start,eol,indent "backspace有効化
set whichwrap=b,s,[,],<,>,~    "やじるし有効化
set mouse=                     "マウス無効化
set nohlsearch                 "検索時のハイライト無効化
set laststatus=2               "status行を２行に
set showtabline=2
set statusline=%F%r%h%=         "ファイル位置を表示

"黒の場合の色設定
highlight StatusLine ctermfg=black ctermbg=grey
highlight CursorLine ctermfg=none ctermbg=darkgray cterm=none
highlight MatchParen ctermfg=none ctermbg=darkgray
highlight Comment ctermfg=DarkGreen ctermbg=NONE
highlight Directory ctermfg=DarkGreen ctermbg=NONE
"色設定終わり

set number
set autoindent
set tabstop=2
set incsearch
set expandtab
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
