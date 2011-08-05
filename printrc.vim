scriptencoding utf-8
"---------------------------------------------------------------------------
" 印刷のフォント
"---------------------------------------------------------------------------
" 印刷で使用するフォント
let &printfont=&guifont
"set printfont=MS_Mincho:h12

" postscript printer
if has('postscript')
    if has('win32')                          " Windows
    elseif has('mac')                        " Mac OSX
        set printencoding=euc-jp
        set printmbcharset=JIS_X_1990

        set printmbfont=

        " 普通文字のフォント
        set printmbfont+=r:Osaka-Mono
        " 太字 (bold) のフォント
        set printmbfont+=,b:Osaka-Mono
        " 斜体文字 (italic) のフォント。未設定時はrフラグを使用する。
        set printmbfont+=,r:Osaka-Mono
        " 太字斜体文字 (bold-italic) のフォント。未設定時はbフラグを使用する。
        set printmbfont+=,b:Osaka-Mono

        set printmbfont+=,c:yes              " ASCII 文字を Courier フォントで出力
        "set printmbfont+=,c:no              " デフォルト
        set printmbfont+=,a:yes              " ASCIIコードの範囲を ASCII 文字セットで出力
        "set printmbfont+=,a:no              " デフォルト

    else                                     " その他の環境
    endif
endif


"---------------------------------------------------------------------------
" ヘッダー
"---------------------------------------------------------------------------
set printheader=
set printoptions=

"set printoptions+=header:0  " ヘッダーを印刷しない
"set printoptions+=header:1  " ヘッダー、本文間にスペースを空けない
set printoptions+=header:2   " ヘッダー、本文間に1行入れる

"set printheader=-%N-                                     " -ページ-
"set printheader=%t                                       " ファイル名
"set printheader=%F                                       " ファイル名（パス含む）
set printheader=%t\ -%N-                                  " ファイル名 -ページ-
"set printheader=%{strftime('%Y/%m/%d\ %H:%M')}           " 最終印刷日時
"set printheader=山田\ 太郎                               " 最終保存者、作成者
"set printheader=山田\ 太郎\ %N\ %{strftime('%Y/%m/%d')}  " 作成者 ページ 日付
"set printheader=社外秘\ %N\ %{strftime('%Y/%m/%d')}      " 社外秘 ページ 日付

" ヘッダーの位置
let &printheader = &printheader . "%="   " 左寄せ
"let &printheader = "%=" . &printheader  " 右寄せ


"---------------------------------------------------------------------------
" 印刷設定
"---------------------------------------------------------------------------
" 余白スペース
" [left 左]  [right 右]  [top 上]  [bottom 下]
" [in インチ]  [pt 1/72インチ]  [mm ミリメートル]  [pc 用紙サイズに対する割合]
set printoptions+=left:10pc,right:5pc,top:5pc,bottom:5pc

" 本文の折り返し
if &wrap                       " wrapの設定に会わせる
    set printoptions+=wrap:y
else
    set printoptions+=wrap:n
endif
"set printoptions+=wrap:y      " 右端で折り返す
"set printoptions+=wrap:n      " 折り返さない

" 行番号
if &number                     " numberの設定に会わせる
    set printoptions+=number:y
else
    set printoptions+=number:n
endif
"set printoptions+=number:y    " 行番号付きで印刷
"set printoptions+=number:n    " 行番号を付けない

" Syntaxハイライト
"set printoptions+=syntax:y    " Syntaxハイライト有効で印刷
"set printoptions+=syntax:n    " Syntaxハイライト無効で印刷
set printoptions+=syntax:a     " カラー印刷可能ならSyntaxハイライト有効

" 改ページ文字
set printoptions+=formfeed:y   " 改ページ文字で、改ページする
"set printoptions+=formfeed:n  " 改ページ文字を印刷する。改ページ文字があっても改ページしない。


"---------------------------------------------------------------------------
" プリンタ設定
"---------------------------------------------------------------------------
" 紙の向き
set printoptions+=portrait:y   " 縦方向に印刷
"set printoptions+=portrait:n  " 横向きに印刷

" 用紙サイズ
"set printoptions+=paper:10x14
"set printoptions+=paper:A3
set printoptions+=paper:A4
"set printoptions+=paper:A5
"set printoptions+=paper:B4
"set printoptions+=paper:B5
"set printoptions+=paper:executive
"set printoptions+=paper:folio
"set printoptions+=paper:ledger
"set printoptions+=paper:legal
"set printoptions+=paper:letter
"set printoptions+=paper:quarto
"set printoptions+=paper:statement
"set printoptions+=paper:tabloid

" 印刷の方法
set printoptions+=duplex:off     " 片面印刷
"set printoptions+=duplex:long   " 両面印刷。綴じ方向縦。長い辺で閉じる。
"set printoptions+=duplex:short  " 両面印刷。綴じ方向横。短い辺で閉じる。

" 印刷単位
set printoptions+=collate:y      " 部単位で印刷（1,2,3,4,1,2,3,4,1,2,3,4）
"set printoptions+=collate:n     " ページ単位で印刷（1,1,1,1,2,2,2,2,3,3,3,4,4,4,4）

" 印刷ジョブ
"set printoptions+=jobsplit:y    " 印刷ジョブを分ける
set printoptions+=jobsplit:n     " 印刷ジョブを分けない

" 印刷で使用するプリンタ（空はシステム標準のプリンタ）
set printdevice=
"set printdevice="CutePDF Writer"

finish

==============================================================================
vimエディタ 印刷用カスタム設定ファイル
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/macros/printrc.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
標準でない印刷をvimエディタで行う場合に、
このファイルを改変後、「source %」コマンドで読み込んで、
印刷設定を変更する。
プリンタ、印刷部数は、hardcopyコマンドで表示される
GUIダイアログで設定した方が楽で良い。
（see more :help print.txt）

1. この印刷設定ファイル変更
2. 保存
3. 次のコマンドで設定読込
   :source %
4. 印刷したいファイルで、次のコマンド実行で印刷
   :hardcopy
5. 印刷の範囲指定は次のように
   :5,90hardcopy

==============================================================================
" vim: set et nowrap ff=unix ft=vim :
