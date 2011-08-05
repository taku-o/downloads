scriptencoding utf-8 " {{{ {{{
if &cp || exists("g:loaded_rand")
    finish
endif
let g:loaded_rand = 1

let s:save_cpo = &cpo
set cpo&vim " }}}

function! Rand(max) " {{{
    perl << EOF
        my $max = VIM::Eval('a:max');
        my $value = int(rand($max)), '\n';
        VIM::DoCommand("let l:r = $value")
EOF
    return l:r
endfunction " }}}

let &cpo = s:save_cpo " {{{
finish " }}} }}}
==============================================================================
rand.vim : 乱数生成ファンクション
==============================================================================
$VIMRUNTIMEPATH/plugin/rand.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
乱数を生成するRand()ファンクションを定義。
expressionレジスタを利用して、

    Control-r = Rand(100)

というように使う。
現バージョンはPerlインターフェイスを使用。


------------------------------------------------------------------------------
Rand({max})
    {max}以下の乱数を生成して返します。


==============================================================================
" vim: set ts=4 sts=4 sw=4 et nowrap foldmethod=marker :
