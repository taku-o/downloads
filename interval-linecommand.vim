:scriptencoding utf-8
:if &cp || exists("g:loaded_interval_linecommand")
    :finish
:endif
:let g:loaded_interval_linecommand = 1

" escape user setting
:let s:save_cpo = &cpo
:set cpo&vim

" return first line number
:function! g:IntervalLineCommand_GetFirstLine() range
    :return a:firstline
:endfunction

" cabbrev
:cabbrev ga  g/^/
:cabbrev ga2 g/^/ if ((line(".") - <C-R>=g:IntervalLineCommand_GetFirstLine()<CR> + 1) % 2 == 1) <BAR>
:cabbrev ga3 g/^/ if ((line(".") - <C-R>=g:IntervalLineCommand_GetFirstLine()<CR> + 1) % 3 == 1) <BAR>
:cabbrev ga4 g/^/ if ((line(".") - <C-R>=g:IntervalLineCommand_GetFirstLine()<CR> + 1) % 4 == 1) <BAR>
:cabbrev ga5 g/^/ if ((line(".") - <C-R>=g:IntervalLineCommand_GetFirstLine()<CR> + 1) % 5 == 1) <BAR>

:let &cpo = s:save_cpo
:finish

==============================================================================
interval-linecommand.vim : 一定間隔の行に、コマンド実行の準備を行うスクリプト。
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/plugin/interval-linecommand.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
一定間隔のバッファの行に対してコマンドを実行する準備を整えます。

1.   コマンドを実行したい範囲を指定してから、
    「:」を押下してコマンドモードになりましょう。

2.  用意されている機能はコマンドモード用の略称で
    ga、ga2、ga3、ga4、ga5と定義されています。
    ・選択行全てにコマンドを実行したい場合は、ga
    ・選択行に1行おきにコマンドを実行したい場合は、ga2
    ・選択行に3行ごとにコマンドを実行したい場合は、ga3
    ・選択行に4行ごとにコマンドを実行したい場合は、ga4
    ・選択行に5行ごとにコマンドを実行したい場合は、ga5
    と入力し、次にスペースを入力しましょう。
    略称が展開されます。

    :'<,'>ga<SPACE>
        "# => :'<,'>g/^/

    :'<,'>ga2<SPACE>
        "# => :'<,'>g/^/ if ((line(".") - 53 - 1) % 2 == 1) |

    :'<,'>ga3<SPACE>
        "# => :'<,'>g/^/ if ((line(".") - 53 - 1) % 3 == 1) |

    :'<,'>ga4<SPACE>
        "# => :'<,'>g/^/ if ((line(".") - 53 - 1) % 4 == 1) |

    :'<,'>ga5<SPACE>
        "# => :'<,'>g/^/ if ((line(".") - 53 - 1) % 5 == 1) |

3.  展開された略称の後に、実行したいコマンドを入力してください。

    " 例1. 1行間隔で置換
        :'<,'>g/^/ if ((line(".") - 53 - 1) % 2 == 1) | s/before/after/

    " 例2. 3行ごとに、ノーマルモードのコマンドで行を削除
        :'<,'>g/^/ if ((line(".") - 53 - 1) % 3 == 1) | norm D

    この説明がよくわからない場合は、
    次のページを見ると、このスクリプトの使い方がわかるかもしれません。

    " ファイル内の各行ごとに編集処理を実行する、何行かおきに編集処理を実行する。
    http://nanasi.jp/articles/howto/editing/global-head.html


==============================================================================
" vim: set et ft=vim nowrap :
