scriptencoding utf-8

command! -nargs=0 LSF :call s:LSF()
command! -nargs=0 LSD :call s:LSD()

function! s:LS()
    let l:list = glob("**/*")
    let l:files = split(l:list, '\n')
    return l:files
endfunction

function! s:LSF()
    let l:list = []
    let l:files = s:LS()

    for l:i in l:files
        if isdirectory(l:i)
        else
            call add(l:list, l:i)
        endif
    endfor

    call setline(".", l:list)
endfunction

function! s:LSD()
    let l:list = []
    let l:files = s:LS()

    for l:i in l:files
        if isdirectory(l:i)
            call add(l:list, l:i)
        else
        endif
    endfor

    call setline(".", l:list)
endfunction

finish

==============================================================================
lsf.vim : カレントディレクトリ以下、ファイルの一覧を取得するスクリプト
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/plugin/lsf.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
「LSF」コマンドを実行すると、カレントディレクトリ以下の全ファイルの一覧を、
「LSD」コマンドを実行すると、カレントディレクトリ以下の全ディレクトリの一覧を、
カレント行に書き込む。

==============================================================================
" vim: set et ft=vim nowrap :
