scriptencoding utf-8
if &cp || exists("g:auto_wc_loaded")
    finish
endif
let g:auto_wc_loaded = 1

augroup WC
    autocmd!
    autocmd BufUnload,FileWritePre,BufWritePre * call <SID>WC()
augroup END

function! s:WC()
    if &modifiable
        let l:current = 0
        let l:last = line('$')
        let l:charcount = s:CharCount()
        while l:current <= l:last
            let l:line = getline(l:current)
            call s:SearchAndReplace(l:line, l:current, l:charcount)
            let l:current += 1
        endwhile
    endif
endfunction

function! s:CharCount()
    let l:count = 0
    let l:current = 0
    let l:last = line('$')
    while l:current <= l:last
        let l:line = getline(l:current)
        let l:count += strlen(substitute(l:line, ".", "x", "g"))
        let l:current += 1
    endwhile
    return l:count
endfunction

function! s:SearchAndReplace(linetext, lineno, charcount)
    let l:found = match(a:linetext, 'WC:\[\d\{1,}/\d\{1,}]:')
    if l:found >= 0
        let l:pre  = substitute(a:linetext, '\(^.*WC:\[\)\d\{1,}\(/\d\{1,}]:.*$\)', '\1', '')
        let l:post = substitute(a:linetext, '\(^.*WC:\[\)\d\{1,}\(/\d\{1,}]:.*$\)', '\2', '')
        let l:newline = l:pre . a:charcount . l:post
        call setline(a:lineno, l:newline)
    endif
endfunction

finish

==============================================================================
auto_wc.vim : ファイルの文字数を自動的に集計する
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/plugin/auto_wc.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
ファイルに
WC:[1920/4200]:
という行を書いておくと、左側ファイル文字数カウンタが
ファイル保存時に自動的に更新される。
右側数値は、入力可能な最大文字数を想定。

==============================================================================
" vim: set et ft=vim nowrap :
