""#####表示設定#####
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
set tabstop=4 "インデントをスペース4つ分に設定
set smartindent "オートインデント

""#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検


autocmd ColorScheme * highlight Comment ctermfg=22 guifg=#008800
autocmd BufNewFile,BufRead *.{html,htm,vue*} set filetype=html

set clipboard& clipboard+=unnamedplus

set encoding=utf-8
scriptencoding utf-8

" tabのスペースの設定
set tabstop=2
set shiftwidth=2
set expandtab

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

"閉じタグ自動補完
inoremap <expr> % Lt_Percent_Completion()
function Lt_Percent_Completion()
 if matchstr(getline('.'), '.', col('.') -1 ) == ">"
   return "\%\%\<Left>"
  else
    return "\%"
  end
endf

"jjを打つことでインサートモード終了
inoremap <silent> jj <ESC>
"矢印キーの代用
imap <C-k> <Up>
imap <C-j> <Down>
imap <C-h> <Left>
imap <C-l> <Right>

"行頭移動(normal mode)
noremap <Space>h ^
noremap <Space>l $
"
"行頭へ移動
inoremap <C-a> <C-o>^
"行末へ移動
inoremap <C-e> <C-o>$

set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=2 " 画面上でタブ文字が占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅

" 行の構文をチェックし次の行のインデントを増減する
"tで増減する幅

" ルサーチ. 文字入力毎に検索を行うに大文字小文字を区別しない 大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

"
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カーソルラインをハイライト
"
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

"""""""""""""""""""""""""""""""
"" 自動的に閉じ括弧を入力
"" """"""""""""""""""""""""""""""
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
"" """"""""""""""""""""""""""""""
"自動で閉じタグを補完する
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype rb inoremap <buffer> </ </<C-x><C-o>
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ↓↓↓↓dein.vimの設定↓↓↓↓
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" deinがインストールされるディレクトリの指定
let s:dein_dir = expand('~/.cache/dein') "<- dein によってプラグインがインストールされるディレクトリ ##########
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
 
" deinがインストールされているかをチェック インストールされていなかったらdeinをダウンロードしてくる
if &runtimepath !~# '/dein.vim'
 if !isdirectory(s:dein_repo_dir)
   execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
 endif
   execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
 
" deinの起動
" dein#load_stateはほんとはifで囲わなくちゃダメ
" だけどうまく動かなくなるから暫定対応
" ↓正規コード↓
" if dein#load_state(s:dein_dir)
"   .....
" endif 
 call dein#load_state(s:dein_dir)
 call dein#begin(s:dein_dir)
 
 " tomlファイル（使用するプラグインのリストが記述されているファイル）の場所を指定
 let g:rc_dir = expand('~/.vim/dein') "<- dein.toml dein_lazy.toml を読み込むディレクトリ ##########
 let s:toml = g:rc_dir . '/dein.toml'
 " let s:lazy_toml = g:rc_dir . '/dein_lazy.toml' "<- dein_lazy.toml を使う場合はコメント解除 ##########
 
 " tomlファイルを読み込む
 call dein#load_toml(s:toml, {'lazy': 0})
 " call dein#load_toml(s:lazy_toml, {'lazy': 1}) "<- dein_lazy.toml を使う場合はコメント解除 ##########
 autocmd VimEnter * execute 'NERDTree'
 let NERDTreeShowHidden=1 

 " 設定の終了
 call dein#end()
 call dein#save_state()
 
" プラグインのインストールをチェック 未インストールのプラグインがあればインストールする
if dein#check_install()
 call dein#install()
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ↑↑↑↑ここまでdein.vim↑↑↑↑
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

set wildmenu " コマンドモードの補完

" 文字色の設定
hi Directory guifg=#FF0000 ctermfg=green
"
"""""""""""""""""""""""""""""""
"" fugitive.vimの設定
""""""""""""""""""""""""""""""
" grep検索の実行後にQuickFix Listを表示する
 autocmd QuickFixCmdPost *grep* cwindow

syntax on
