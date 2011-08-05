" 1度しか読み込ませない。
" 開発中はコメントアウトしておくと楽です。
if exists('g:loaded_sample')
    finish
endif
let g:loaded_sample = 1

" cpoオプションを逃がす。
let s:save_cpo = &cpo
set cpo&vim


" ここにコードを書きます。
" ここにコードを書きます。
" ここにコードを書きます。


" cpoオプションを元に戻す。
let &cpo = s:save_cpo
finish

" TITLE: vimスクリプトの構造 {{{
" NEXT: sample_2.vim
" vim:set ft=vim ff=unix fenc=cp932 nolist number hlsearch nowrap foldmethod=marker : }}}
