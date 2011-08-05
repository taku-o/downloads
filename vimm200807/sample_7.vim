" 1度しか読み込ませない。 {{{
" 開発中はコメントアウトしておくと楽です。
"if exists('g:loaded_sample')
"    finish
"endif
"let g:loaded_sample = 1

" cpoオプションを逃がす。
let s:save_cpo = &cpo
set cpo&vim

" OutCommandViewerコマンドを実行すると、s:OutCommandViewer()を呼び出します。
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
    " key      入力キー
    " key_name ヘルプで使用する
    " help     ヘルプで使用する
    " agent    どのファンクションを呼び出すか
    let l:world.key_handlers = [
    \    {'key':1,  'key_name':'<c-a>', 'help':'push Control-A.', 'agent':'g:CallCtrlA' },
    \    {'key':16, 'key_name':'<c-p>', 'help':'push Control-P.', 'agent':'g:CallCtrlP' },
    \    {'key':21, 'key_name':'<c-u>', 'help':'push Control-U.', 'agent':'g:CallCtrlU' }
    \ ]


    " 開いたスクラッチウィンドウで表示する一覧
    " 仮実装のコメントアウト
    " let l:world.base = [ "A", "B", "C" ]

    " 外部コマンドを実行
    let l:ls_result = system('ls')

    " 結果を編集してリストに変換
    let l:ls_list = split(l:ls_result, '\n')

    " baseキーにセットする
    let l:world.base = l:ls_list


    " 渡されたWorldオブジェクトのパラメータを元に、
    " スクラッチウィンドウを開きます。
    call tlib#input#ListW(l:world)

endfunction


" Control-Aを押すと呼び出される
function! g:CallCtrlA(world, selected)
    " 選択したテキストを取得
    let l:entry = a:selected[0]

    " パターン1 単純にコマンドを実行する
    let l:files = system('ls')
    echo l:files
" }}}
    return a:world
endfunction


" Control-Pを押すと呼び出される
function! g:CallCtrlP(world, selected)
    " 選択したテキストを取得
    let l:entry = a:selected[0]

    " パターン2 元のウィンドウで何かコマンドを実行する
    let l:sb = a:world.SwitchWindow('win')

    " SwitchWindow()実行後に処理を実行
    "let l:files = system('ls')
    "echo l:files


    " 選択したファイルを読む
    for l:line in readfile(l:entry)
        " 最後の行の後に追加.
        call append(line("$"), l:line)
    endfor


    " 処理が終わったら、SwitchWindow()のreturn valueを実行する
    execute l:sb

    return a:world
endfunction


" Control-Uを押すと呼び出される
function! g:CallCtrlU(world, selected) " {{{
    " 選択したテキストを取得
    let l:entry = a:selected[0]

    " パターン3 コマンド実行後、ウィンドウを閉じる
    let l:files = system('ls')
    echo l:files

    " CloseScratch()でウィンドウを閉じる。
    silent call a:world.CloseScratch()

    return a:world
endfunction


" cpoオプションを元に戻す。
let &cpo = s:save_cpo
finish

" TITLE: 実行する処理を変更
" vim:set ft=vim ff=unix fenc=cp932 nolist number hlsearch nowrap foldmethod=marker : }}}
