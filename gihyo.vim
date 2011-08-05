scriptencoding utf-8

" pattern match
syntax match   gihyoTitle       '^###[^#]*$'
syntax match   gihyoSubTitle    '^##[^#]*$'
syntax match   gihyoSubSubTitle '^#[^#]*$'
syntax match   gihyoStrong      '\*..\{-}\*'
syntax region  gihyoTable       start=/\n\n\s*+\([-=]\|+\)\+/ms=s+2 end=/+\([-=]\|+\)\+\n\s*\n/me=e-2
syntax match   gihyoRuler       "\(=\|-\|+\)\{3,120}"
syntax match   gihyoURL         "\(http\|https\|ftp\):[-!#%&+,./0-9:;=?@A-Za-z_~]\+"
syntax match   gihyoTodo        '^TODO.*'
syntax match   gihyoPoint       '^・.*'
syntax match   gihyoNotUseChar  '[.,()Ａ-Ｚａ-ｚ０-９、。]'
syntax match   gihyoNotUseBar   'ー\>'

" highlight link
highlight link gihyoStrong      PreProc
highlight link gihyoTable       Special
highlight link gihyoRuler       Special
highlight link gihyoURL         Underlined
highlight link gihyoTitle       Constant
highlight link gihyoSubTitle    Type
highlight link gihyoSubSubTitle Statement
highlight link gihyoTodo        Todo
highlight link gihyoPoint       Question
highlight link gihyoNotUseChar  Error
highlight link gihyoNotUseBar   Error

" decorate highlight
highlight PreProc   term=bold cterm=bold gui=bold
highlight Constant  term=bold,underline cterm=bold,underline gui=bold,underline
highlight Type      term=bold,underline cterm=bold,underline gui=bold,underline
highlight Statement term=bold,underline cterm=bold,underline gui=bold,underline

finish

==============================================================================
技術評論社 記事執筆用 シンタックスハイライトファイル
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/syntax/gihyo.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
技術評論社の記事用のシンタックスファイル．

・見出しのレベルは#を使用する。最大3段階。
### 見出し大
## 見出し中
# 見出し小

・テキストを強調するには*で囲む。
*強調*

・表は線で描画する。
+-----+-------+------+
| abc | 12345 |      |
| def | 67890 |      |
+-----+-------+------+

・読点、句読点は「、」「。」ではなく、
・「，」「．」（全角カンマ、全角ピリオド）を使用する。
こんにちわ、せかい。
こんにちわ，せかい．

・括弧は全角括弧を使用する。
これは(かっこ)です．
これは（かっこ）です．

・アルファベット、数字は半角文字を使用する。
ＡＢＣ１２３
ABC123

・一般名詞の音引きは取る方で統一する。
コンピューター
ユーザー
コンピュータ
ユーザ

・特別な拡張
・(URL)
http://nanasi.jp/
https://nanasi.jp/
ftp://nanasi.jp/

・(TODO)
TODO

・(ルーラー)
====================================

------------------------------------

++++++++++++++++++++++++++++++++++++

・（注）

==============================================================================
" vim:set et syntax=vim nowrap :
