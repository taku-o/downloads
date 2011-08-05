scriptencoding utf-8

" colorscheme
colorscheme delek

" options
set nolist
set number
set hlsearch
set nowrap
set showtabline=0

" GUI
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=l
set guioptions-=b

" remove augroup MiniBufExplorer
augroup MiniBufExplorer
    augroup MiniBufExplorer!
augroup END

finish

==============================================================================
presenrc.vim : プレゼンテーション、デモ用設定ファイル
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/macros/demorc.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
・カラースキーマ
    delek

・設定
    set nolist
    set number
    set hlsearch
    set nowrap
    set showtabline=0

・モードラインで、コードによっては設定
    foldmethod=marker

・GUI
    メニュー、ツールバー、スクロールバーは削除すべきか

・邪魔なコードはフォールディングして見やすくする
・幅が制限されるので、サイドに出るタイプのタブは使わない。
・バッファを利用すると、見る側が追跡しづらくなるので、
  ウィンドウを多数用意することで代用

・コードをハイライト表示する
    hl.vim
    visualmark.vim

・次のスクリプトは使用しない方が良い
    minibufexpl.vim

・次のコマンドでスクリプトを読み込む
    runtime macros/demorc.vim

==============================================================================
" vim: set et nowrap ft=vim :
