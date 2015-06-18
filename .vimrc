set encoding=utf-8
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

nnoremap <silent><Space>j    :VimFilerExplorer -find<CR>

 " Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \   'mac' : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \   'linux' : 'make',
      \ },
      \}
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'Shougo/vimshell'
NeoBundle 'VimClojure'

"unite install
NeoBundle 'Shougo/unite.vim'
NeoBundle 'basyura/unite-rails'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'violetyk/cake.vim'
"powerline tool
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'slim-template/vim-slim'
" 静的解析
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-rails'
NeoBundle 'edsono/vim-matchit'
"NeoBundle 'vim-coffee-script'
NeoBundle 'kchmck/vim-coffee-script'
"NeoBundle 'https://bitbucket.org/kovisoft/slimv'
NeoBundle 'vim-scripts/dbext.vim'
NeoBundle 'thinca/vim-quickrun'
" ドキュメント参照
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
"NeoBundle 'w0ng/vim-hybrid'

NeoBundleLazy 'alpaca-tc/alpaca_tags', {
  \ 'depends': ['Shougo/vimproc'],
  \ 'autoload' : {
  \   'commands' : [
  \     { 'name' : 'AlpacaTagsBundle', 'complete': 'customlist,alpaca_tags#complete_source' },
  \     { 'name' : 'AlpacaTagsUpdate', 'complete': 'customlist,alpaca_tags#complete_source' },
  \     'AlpacaTagsSet', 'AlpacaTagsCleanCache', 'AlpacaTagsEnable', 'AlpacaTagsDisable', 'AlpacaTagsKillProcess', 'AlpacaTagsProcessStatus',
  \ ],
  \ }}


NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'tpope/vim-endwise' "rubyでend勝手に入力してくれるやつ
NeoBundle 'tpope/vim-fugitive' "Gitを便利に使うやつ
"NeoBundle 'nathanaelkane/vim-indent-guides' "インデントに色を付けて見やすくする
"
"
let g:ref_phpmanual_path = $HOME . '/.vim/manuals/php-chunked-xhtml'

augroup AlpacaTags
  autocmd!
  if exists(':Tags')
  autocmd BufWritePost Gemfile TagsBundle
  autocmd BufEnter * TagsSet
  " 毎回保存と同時更新する場合はコメントを外す
  "     " autocmd BufWritePost * TagsUpdate
  endif
augroup END

call neobundle#end()

" vim-indent-guidesのsetting
"let g:indent_guides_enable_on_vim_startup = 1
"hi IndentGuidesOdd  ctermbg = black
"hi IndentGuidesEven ctermbg = darkgrey

"""""""""""""" Unite setting"""""""""""""""""""""""""""""""""""""""""""""""
"" prefix
nnoremap [unite] <Nop>
nmap    <Space>u [unite]

" unite.vim
function! DispatchUniteFileRecAsyncOrGit()
  if isdirectory(getcwd()."/.git")
    Unite file_rec/git
  else
    Unite file_rec/async
  endif
endfunction
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]c   :<C-u>Unite -start-insert cake_controller cake_model cake_config cake_component cake_behavior cake_helper cake_shell cake_fixture cake_core cake_lib<CR>
nnoremap <silent> [unite]r   :<C-u>Unite -start-insert rails/model rails/controller rails/view rails/helper rails/mailer rails/lib rails/db rails/config rails/javascript rails/stylesheet<CR>
nnoremap <silent> [unite]d   :<C-u>UniteWithBufferDir -buffer-name=files file -start-insert<CR>
"nnoremap <silent> [unite]f   :<C-u>Unite file -default-action=tabopen<CR>
nnoremap <silent> [unite]f :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>
"nnoremap <silent> [unite]f   :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <silent> [unite]m   :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]t   :<C-u>Unite tab<CR>
nnoremap <silent> [unite]o   :<C-u>Unite -vertical -winwidth=40 outline<CR>

" horizontal split
au FileType unite nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')

" vertical split
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

" tab open
au FileType unite nnoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
au FileType unite inoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')

let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

call unite#custom#profile('default',  'context',  {
  \   'winheight': 10,
  \   'direction': 'botright',
  \ })
let g:unite_winheight = 10

"let g:unite_source_rec_max_cache_files = 25500 "file_recでcacheするmax files

call unite#custom#source('file_rec/async', 'ignore_pattern', '\(png\|gif\|jpeg\|jpg\|html\)$')

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
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

""""""cake.vim setting""""""

let g:cakephp_enable_auto_mode = 1

"""""vimfiler setting"""""""""""""
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_edit_action = 'tabopen'

" smartchar setting
inoremap <expr> = smartchr#loop('=', ' = ', ' == ', ' =')
inoremap <expr> , smartchr#loop(',', ', ')
inoremap <expr> # smartchr#loop('#', '# ')


" paste切り替え
"nnoremap <silent><space>pa :set paste<CR>:startinsert<CR>
"autocmd InsertLeave * set nopaste

"""""""""""""" vim-rails setting"""""""""""""""""""""""""""""""""""""""""""""""
"""{{{
"有効化
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0
" let g:rails_some_option = 1
let g:rails_statusline = 1
" let g:rails_subversion=0
" let g:rails_syntax = 1
" let g:rails_url='http:// localhost:3000'
" let g:rails_ctags_arguments='--languages=-javascript'
" let g:rails_ctags_arguments = ''
function! SetUpRailsSetting()
  nnoremap <buffer><Space>r :R<CR>
  nnoremap <buffer><Space>a :A<CR>
  nnoremap <buffer><Space>m :Rmodel<Space>
  nnoremap <buffer><Space>c :Rcontroller<Space>
  nnoremap <buffer><Space>v :Rview<Space>
  nnoremap <buffer><Space>p :Rpreview<CR>
endfunction

aug MyAutoCmd
        au User Rails call SetUpRailsSetting()
aug END

aug RailsDictSetting
        au!
aug END
"}}}

" 括弧や引用符入力時に戻る
"inoremap // // 
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
" --------------------------------
"  " rubocop
"  " --------------------------------
"  " syntastic_mode_mapをactiveにするとバッファ保存時にsyntasticが走る
"  " active_filetypesに、保存時にsyntasticを走らせるファイルタイプを指定する
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

" Rename command
" how to use
" :Rename newfilename
" if you want to override strongly, you may use this command
" :Rename! newfilename
" source: http:// d.hatena.ne.jp/fuenor/20100115/1263551230
command! -nargs=1 -bang -bar -complete=file Rename saveas<bang> <args> | call delete(expand('#:p'))

" Required:
filetype plugin indent on

filetype indent on
syntax on                      "シンタックス有効化

"colorscheme Tomorrow-Night-Eighties
colorscheme Tomorrow-Night-Bright
"colorscheme Tomorrow
"colorscheme Tomorrow-Night-Blue

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
"highlight StatusLine ctermfg=black ctermbg=grey
"highlight CursorLine ctermfg=none ctermbg=darkgray cterm=none
"highlight MatchParen ctermfg=none ctermbg=darkgray
"highlight Comment ctermfg=DarkGreen ctermbg=NONE
"highlight Directory ctermfg=DarkGreen ctermbg=NONE
"色設定終わり

set number
set autoindent
set tabstop=2
set incsearch
set expandtab
set list
"set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
" listchars
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
