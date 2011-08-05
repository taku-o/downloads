" {{{
scriptencoding utf-8 " {{{
if &cp || exists("g:loaded_hl")
    finish
endif
let g:loaded_hl = 1

let s:save_cpo = &cpo
set cpo&vim
" }}}


" command {{{
command! -narg=0 -range HLLine <line1>,<line2>call s:HLLine()
command! -narg=0 HLWord call s:HLWord()
command! -narg=0 -range HLSelect call s:HLSelect()
" map
nmap HL :HLLine<CR>
vmap HL :HLLine<CR>
nmap HW :HLWord<CR>
vmap HS :HLSelect<CR>
" }}}

" function: s:HLLine / highlight current line {{{
function! s:HLLine() range
    let l:save_cursor = getpos(".")
    let @/ =
                \ '\%>' . (a:firstline - 1) . 'l' .
                \ '\%<' . (a:lastline + 1) . 'l'
    call feedkeys("n")
    " not beautiful
    call feedkeys("h")
    call setpos('.', l:save_cursor)
endfunction " }}}

" function s:HLWord / highlight current word {{{
function! s:HLWord()
    let l:save_cursor = getpos(".")
    let [l:bufnum, l:lnum, l:col, l:off] = l:save_cursor

    let l:cword = expand("<cword>")
    let l:cword_len = strlen(l:cword)

    let l:l = l:col - 1
    let l:r = l:col + l:cword_len

    let @/ =
                \ '\%' . l:lnum . 'l' .
                \ '\%>' . l:l . 'c' .
                \ '\%<' . l:r . 'c'

    call feedkeys("n")
    " not beautiful
    call feedkeys("h")
    call setpos('.', l:save_cursor)
endfunction " }}}

" function s:HLSelect / highlight selected area {{{
function! s:HLSelect()
    let l:save_cursor = getpos(".")

    let [l:bufnuml, l:lnuml, l:coll, l:offl] = getpos('''<')
    let [l:bufnumr, l:lnumr, l:colr, l:offr] = getpos('''>')

    " in a line
    if l:lnuml == l:lnumr
        let l:u = l:lnuml - 1
        let l:b = l:lnumr + 1
        let l:l = l:coll - 1
        let l:r = l:colr + 1

        let @/ =
                    \ '\%>' . l:u . 'l' .
                    \ '\%<' . l:b . 'l' .
                    \ '\%>' . l:l . 'c' .
                    \ '\%<' . l:r . 'c'

    " in some lines
    else
        let @/ =
                    \ '\%(' .
                    \ '\%' . l:lnuml . 'l' .
                    \ '\%>' . (l:coll - 1) . 'c' .
                    \ '\)' .
                    \ '\|' .
                    \ '\%(' .
                    \ '\%' . l:lnumr . 'l' .
                    \ '\%<' . (l:colr + 1) . 'c' .
                    \ '\)' .
                    \ '\|' .
                    \ '\%(' .
                    \ '\%>' . (l:lnuml) . 'l' .
                    \ '\%<' . (l:lnumr) . 'l' .
                    \ '\)'
    endif

    call feedkeys("n")
    " not beautiful
    call feedkeys("h")
    call setpos('.', l:save_cursor)
endfunction " }}}

let &cpo = s:save_cpo " {{{
finish " }}}
" }}}
==============================================================================
hl.vim : ハイライト用スクリプト
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/plugin/hl.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
現在行、カーソル下単語、選択範囲をhlsearchオンによる強調表示でハイライトする
プレゼンテーション用スクリプトです。

------------------------------------------------------------------------------
[ノーマルモード用]
" カレント行をハイライト表示する。
:HL

" カーソル下単語をハイライト表示する。
" カーソルは単語の先頭位置でなければならない。
:HW

------------------------------------------------------------------------------
[ビジュアルモード用]
" 選択した範囲の行をハイライト表示する。
:'<,'>HL

" ビジュアルモードで選択したテキストをハイライト表示する。
:'<,'>HS

------------------------------------------------------------------------------
[更新履歴]
2009.12.01 ハイライトの形式を修正。
2008.10.01 initial upload.

==============================================================================
" vim: set et ft=vim nowrap foldmethod=marker :
