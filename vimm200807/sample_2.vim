" 1�x�����ǂݍ��܂��Ȃ��B {{{
" �J�����̓R�����g�A�E�g���Ă����Ɗy�ł��B
if exists('g:loaded_sample')
    finish
endif
let g:loaded_sample = 1

" cpo�I�v�V�����𓦂����B }}}
let s:save_cpo = &cpo
set cpo&vim


" OutCommandViewer�R�}���h�����s����ƁAs:OutCommandViewer()���Ăяo���܂��B
command! -nargs=0 OutCommandViewer :call s:OutCommandViewer()

" OutCommandViewer�R�}���h����Ăяo����܂��B
function! s:OutCommandViewer()

    " ������tlib���C�u�����̏������Ăяo���B
    " ������tlib���C�u�����̏������Ăяo���B
    " ������tlib���C�u�����̏������Ăяo���B

endfunction


" cpo�I�v�V���������ɖ߂��B
let &cpo = s:save_cpo
finish
" {{{

" TITLE: �R�}���h�ƃt�@���N�V�����̒�`
" NEXT: sample_3.vim
" vim:set ft=vim ff=unix fenc=cp932 nolist number hlsearch nowrap foldmethod=marker : }}}
