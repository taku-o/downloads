" 1度しか読み込ませない。 {{{
" 開発中はコメントアウトしておくと楽です。
if exists('g:loaded_sample')
    finish
endif
let g:loaded_sample = 1

" cpoオプションを逃がす。 }}}
let s:save_cpo = &cpo
set cpo&vim


" OutCommandViewerコマンドを実行すると、s:OutCommandViewer()を呼び出します。
command! -nargs=0 OutCommandViewer :call s:OutCommandViewer()

" OutCommandViewerコマンドから呼び出されます。
function! s:OutCommandViewer()

    " ここでtlibライブラリの処理を呼び出す。
    " ここでtlibライブラリの処理を呼び出す。
    " ここでtlibライブラリの処理を呼び出す。

endfunction


" cpoオプションを元に戻す。
let &cpo = s:save_cpo
finish
" {{{

" TITLE: コマンドとファンクションの定義
" NEXT: sample_3.vim
" vim:set ft=vim ff=unix fenc=cp932 nolist number hlsearch nowrap foldmethod=marker : }}}
