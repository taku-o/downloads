scriptencoding utf-8

" 1度スクリプトを読み込んだら、2度目は読み込まない
if &cp || exists("g:loaded_zshr")
    finish
endif
let g:loaded_zshr = 1

" ユーザの初期設定を逃がす
let s:save_cpo = &cpo
set cpo&vim

" コマンド定義
command! -nargs=+ R :call s:R(<f-args>)

function! s:R(...)
    let l:length = len(a:000)
    let l:index = 0

    " 直前のコマンドを取得
    let l:pre_cmd = histget(":", -2)

    " パラメータの数だけコマンドの置換処理を実行
    while l:index < l:length
        let l:pre_cmd = s:ReplaceCmd(l:pre_cmd, a:000[l:index])
        let l:index += 1
    endwhile

    " コマンドを実行
    try
        execute l:pre_cmd
    catch
        " コマンド実行に失敗
        echohl ErrorMsg | echo v:exception | echohl None
    endtry

    " コマンド実行履歴を追加。連続で:Rコマンドを実行するために必要。
    " 履歴を消す方法で、連続実行可能にすることはおそらく無理。
    call histadd(":", l:pre_cmd)
endfunction

" コマンドを置換して返す
function! s:ReplaceCmd(cmd, param)
    let l:cmd = a:cmd

    let l:matched = match(a:param, '[^=]\+=[^=]\+')
    if l:matched > -1
        " 置換パターンを取り出して、置換処理実行
        let l:pre  = substitute(a:param, '\([^=]\+\)=\([^=]\+\)', '\1', "")
        let l:post = substitute(a:param, '\([^=]\+\)=\([^=]\+\)', '\2', "")
        let l:cmd = substitute(l:cmd, l:pre, l:post, "g")
    else
        " コマンドの呼び出し方が違う
        :echohl WarningMsg | echo ":R command syntax error is found." | echohl None
    endif

    return l:cmd
endfunction

" 退避していたユーザのデータをリカバリ
let &cpo = s:save_cpo
" スクリプトはここまで
finish

==============================================================================
zshr.vim : 直前に実行したコマンドを少し変更して実行する。zshシェルのrコマンド。
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/plugin/zshr.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
直前に実行したコマンドの一部を少し変更して実行する。

:%s/aaabbbccc/xxxyyyzzz/g
としてから、

:R a=m
と実行すると、

:%s/mmmbbbccc/xxxyyyzzz/g
が実行される。
直前に実行したコマンドを置き換えてから、改めて実行する。

:R a=m ccc=xyz bb=123
のように複数の置換パラメータをとれる。

==============================================================================
" vim: set et ft=vim nowrap :
