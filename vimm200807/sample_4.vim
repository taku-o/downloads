" 1度しか読み込ませない。 {{{
" 開発中はコメントアウトしておくと楽です。
if exists('g:loaded_sample')
    finish
endif
let g:loaded_sample = 1

" cpoオプションを逃がす。
let s:save_cpo = &cpo
set cpo&vim

" OutCommandViewerコマンドを実行すると、s:OutCommandViewer()を呼び出します。
" }}}
command! -nargs=0 OutCommandViewer :call s:OutCommandViewer()


" OutCommandViewerコマンドから呼び出されます。
function! s:OutCommandViewer()

    " Worldオブジェクトを生成
    let l:world = tlib#World#New()

    " Worldオブジェクトの属性を設定

    " スクラッチの名前
    let l:world.scratch = "SCRATCH_NAME"

    " ウィンドウを縦に分割するか、横に分割するか
    let l:world.scratch_vertical = 1

    " リストを選択したら、どういう挙動にさせるか
    " key      入力キー a=1 b=2 c=3 ... z=26
    " key_name ヘルプで使用する
    " help     ヘルプで使用する
    " agent    どのファンクションを呼び出すか
    let l:world.key_handlers = [
    \    {'key':1,  'key_name':'<c-a>', 'help':'push Control-A.', 'agent':'g:CallCtrlA' },
    \    {'key':16, 'key_name':'<c-p>', 'help':'push Control-P.', 'agent':'g:CallCtrlP' },
    \    {'key':21, 'key_name':'<c-u>', 'help':'push Control-U.', 'agent':'g:CallCtrlU' }
    \ ]

    " 開いたスクラッチウィンドウで表示する一覧
    " 仮実装
    let l:world.base = [ "A", "B", "C" ]

    " 渡されたWorldオブジェクトのパラメータを元に、
    " スクラッチウィンドウを開きます。
    call tlib#input#ListW(l:world)

endfunction


" Control-Aを押すと呼び出される
function! g:CallCtrlA(world, selected)

    " ここでリストを選択した時の処理を記述
    " ここでリストを選択した時の処理を記述
    " ここでリストを選択した時の処理を記述

    return a:world
endfunction


" Control-Pを押すと呼び出される
function! g:CallCtrlP(world, selected)

    " ここでリストを選択した時の処理を記述
    " ここでリストを選択した時の処理を記述
    " ここでリストを選択した時の処理を記述

    return a:world
endfunction


" Control-Uを押すと呼び出される
function! g:CallCtrlU(world, selected)

    " ここでリストを選択した時の処理を記述
    " ここでリストを選択した時の処理を記述
    " ここでリストを選択した時の処理を記述

    return a:world
endfunction


" cpoオプションを元に戻す。 {{{
let &cpo = s:save_cpo
finish

" TITLE: tlibの挙動の設定
" NEXT: sample_5.vim
" vim:set ft=vim ff=unix fenc=cp932 nolist number hlsearch nowrap foldmethod=marker : }}}
