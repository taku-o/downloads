scriptencoding utf-8
if &cp || exists("g:loaded_winresize")
    finish
endif
let g:loaded_winresize = 1

let s:save_cpo = &cpo
set cpo&vim

" command
command! -narg=0 WinResizeToRight1 :call s:WinResize( 1,  0)
command! -narg=0 WinResizeToRight5 :call s:WinResize( 5,  0)
command! -narg=0 WinResizeToLeft1  :call s:WinResize(-1,  0)
command! -narg=0 WinResizeToLeft5  :call s:WinResize(-5,  0)
command! -narg=0 WinResizeToUp1    :call s:WinResize( 0, -1)
command! -narg=0 WinResizeToUp5    :call s:WinResize( 0, -5)
command! -narg=0 WinResizeToDown1  :call s:WinResize( 0,  1)
command! -narg=0 WinResizeToDown5  :call s:WinResize( 0,  5)

" map
nmap <M-Right>   :WinResizeToRight1<CR>
nmap <S-M-Right> :WinResizeToRight5<CR>
nmap <M-Left>    :WinResizeToLeft1<CR>
nmap <S-M-Left>  :WinResizeToLeft5<CR>
nmap <M-Up>      :WinResizeToUp1<CR>
nmap <S-M-Up>    :WinResizeToUp5<CR>
nmap <M-Down>    :WinResizeToDown1<CR>
nmap <S-M-Down>  :WinResizeToDown5<CR>

" &columns += &columns + a:columns
" &lines   += &lines   + a:lines
function! s:WinResize(columns, lines)
    let &columns += a:columns
    let &lines   += a:lines
endfunction

let &cpo = s:save_cpo
finish

==============================================================================
winresize.vim : ウィンドウサイズコントロールスクリプト
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/plugin/winresize.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
ウィンドウのサイズを拡大、縮小するスクリプト。
プレゼンなど、急にウィンドウサイズの変更が必要になった際に使用する。

------------------------------------------------------------------------------
横幅（columns）拡大
<M-Right>    サイズ+1
<S-M-Right>  サイズ+5

横幅（columns）縮小
<M-Left>    サイズ-1
<S-M-Left>  サイズ-5

縦幅（lines）拡大
<M-Up>      サイズ-1
<S-M-Up>    サイズ-5

縦幅（lines）縮小
<M-Down>    サイズ+1
<S-M-Down>  サイズ+5

==============================================================================
" vim: set et ft=vim nowrap :
