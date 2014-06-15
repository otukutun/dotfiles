if has('vim_starting')
set nocompatible               "vi互換解除
,
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

NeoBundle 'Shougo/vimproc.vim', {'build' : {'mac' : 'make -f make_mac.mak','unix' : 'make -f make_unix.mak',},}
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'Shougo/vimshell'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'basyura/unite-rails'
NeoBundle 'h1mesuke/unite-outline'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-rails'
"NeoBundle 'https://bitbucket.org/kovisoft/slimv'
NeoBundle 'vim-scripts/dbext.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'violetyk/cake.vim'
"NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'tpope/vim-endwise' "rubyでend勝手に入力してくれるやつ
NeoBundle 'tpope/vim-fugitive' "Gitを便利に使うやつ
"NeoBundle 'nathanaelkane/vim-indent-guides' "インデントに色を付けて見やすくする

call neobundle#end()

" vim-indent-guidesのsetting
"let g:indent_guides_enable_on_vim_startup = 1
"hi IndentGuidesOdd  ctermbg = black
"hi IndentGuidesEven ctermbg = darkgrey

" Unite setting
"" prefix
nnoremap [unite] <Nop>
nmap    <Space>u [unite]

" unite.vim
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
"nnoremap <silent> [unite]f   :<C-u>Unite file -default-action=tabopen<CR>
nnoremap <silent> [unite]f   :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <silent> [unite]m   :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]t   :<C-u>Unite tab<CR>

"let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

call unite#custom#profile('default',  'context',  {
\   'winheight': 10,
\   'direction': 'botright',
\ })
let g:unite_winheight = 10

let g:unite_source_rec_max_cache_files = 3000 "file_recでcacheするmax files

if executable('ag')
  let g:unite_source_grep_command  =  'ag'
  let g:unite_source_grep_default_opts  = 
  \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
  \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt  =  ''
endif

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> , r  :<C-u>UniteResume search-buffer<CR>

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" smartchar setting
inoremap <expr> = smartchr#loop(' = ', ' == ', ' =', '=')
inoremap <expr> , smartchr#loop(', ', ',')

" paste切り替え
"nnoremap <silent><space>pa :set paste<CR>:startinsert<CR>
"autocmd InsertLeave * set nopaste

" 括弧や引用符入力時に戻る
inoremap // // 
inoremap /* /* 
inoremap */ */<CR>
"inoremap {} {}<LEFT>
"inoremap [] []<LEFT>
"inoremap () ()<LEFT>
"inoremap "" ""<LEFT>
"inoremap '' ''<LEFT>
"inoremap <> <><LEFT>
"tab setting
map  :t :tabnew

" syntastic setting
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_highlighting = 1


" Required:
filetype plugin indent on

filetype indent on
syntax on                      "シンタックス有効化

colorscheme Tomorrow-Night-Eighties

set noswapfile
set backspace=start,eol,indent "backspace有効化
set whichwrap=b,s,[,],<,>,~    "やじるし有効化
set mouse=                     "マウス無効化
set nohlsearch                 "検索時のハイライト無効化
set laststatus=2               "status行を２行に
"set paste                      "コピペ時にずれる現象対策 これを設定していると、inoremapがうまく動作しない

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
  let bufnrs = tabpagebuflist(i)
  let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
  let no = i  " display 0-origin tabpagenr.
  let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
  let title = fnamemodify(bufname(bufnr), ':t')
  let title = '[' . title . ']'
  let s .= '%'.i.'T'
  let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
  let s .= no . ':' . title
  let s .= mod
  let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

set showtabline=2              "tablineを2行に

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
