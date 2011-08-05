scriptencoding utf-8
if &cp || exists('g:loaded_rargs')
    finish
endif
let g:loaded_rargs = 1

" escape user configuration
let s:save_cpo = &cpo
set cpo&vim

" exist when catch error option. default not exit.
let s:exit_when_error = '0'
if exists('g:rargs_exit_when_error')
    let s:exit_when_error = g:rargs_exit_when_error
else

" read file at insertat
function! s:RArgs(insertat,...)
    " get option and file list.
    let [l:optlist, l:filelist] = s:GetOpt(a:000)

    " file readable check
    for l:f in l:filelist
        let l:hasError = '0'
        if ! filereadable(l:f)
            echohl WarningMsg | echo 'rargs.vim Warning : selected file "' . l:f . '" is not readable' | echohl None
            let l:hasError = '1'
        endif

        " error is found.
        if l:hasError !=# '0'
            if s:exit_when_error !=# '0'
                return
            else
                continue
            endif
        endif
    endfor

    " reverse filelist
    call reverse(l:filelist)

    for l:f in l:filelist
        if filereadable(l:f)
            try
                let l:cmd = ':' . a:insertat . 'r ' . join(l:optlist, ' ') . ' ' . l:f
                silent execute l:cmd | " comment
            catch
                echohl WarningMsg | echo 'rargs.vim Warning : catch error when reading "' .l:f. '". ' . v:exception | echohl None
                if s:exit_when_error !=# '0'
                    return
                else
                    continue
                endif
            endtry
        endif
    endfor
endfunction

" return file list, and command option.
" [optionlist, filelist]
function! s:GetOpt(paramlist)
    let l:optlist = []
    let l:filelist = []

    for l:argv in a:paramlist
        " option, ++ started
        if strpart(l:argv, 0, 2) == '++'
            call add(l:optlist, l:argv)
        " file list
        else
            call extend(l:filelist, split(expand(l:argv), '\n'))
        endif
    endfor

    return [l:optlist, l:filelist]
endfunction

command! -narg=* -range=1 -complete=file RArgs :call s:RArgs(<line1>,<f-args>)

" recover user configuration
let &cpo = s:save_cpo
finish

==============================================================================
rargs.vim : 指定した複数のファイルを一度に読み込む
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/plugin/rargs.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/09/17 14:00:00
==============================================================================
パラメータとして与えたファイルを読み込むコマンド「:RArgs」を定義しています。
「:RArgs」は「:read」コマンドの拡張で、Unixで良く行われるファイルをまとめる操作、

    cat file1 file2 file3 > some.txt

を書き込まれる側のファイルから制御します。


------------------------------------------------------------------------------
[コマンドフォーマット]

    " コマンドフォーマット
    :[N]RArgs [++opt] {filename1} [{filename2} {filename3}...]

    [N]
        テキストを流し込む位置。省略可能。

    [++opt]
        ファイル読み込みの際に指定するオプション。
        詳しくは、 ':help ++opt' 参照。

    {filename1} [{filename2} {filename3}...]
        読み込むファイル。複数指定可能。同じファイル指定可能。
        ワイルドカード使用可能。
        Vimのファイル系特殊キーワード（'#2', '%'）など使用可能。


------------------------------------------------------------------------------
[ファイル指定]

:RArgsコマンドは、ファイル名のリストを受け取りますが、
単純なファイル名だけでなく、ワイルドカードによるファイル指定や、
Vimのファイル系の特殊キーワードを使用したファイル指定、
同じファイルの複数回の読み込みも受け入れられます。

    " 複数ファイルの読み込み
    :RArgs sample1.txt sample2.txt sample3.txt

    " ワイルドカード
    :RArgs sample*

    " Vimのファイル系特殊キーワード
    :RArgs #2 #4 #6<.bak

    " 同じファイルの複数回読み込み
    :RArgs sample1.txt sample1.txt sample1.txt

    " エンコード、ファイルフォーマット指定
    :RArgs ++enc=utf-8 ++ff=unix sample1.txt sample2.txt sample3.txt


------------------------------------------------------------------------------
[読み込み位置]

ファイルを読み込む位置は、未指定ならカーソル行、
指定したなら、その指定行になります。

    " カーソル行に読み込み
    :RArgs sample1.txt sample2.txt sample3.txt

    " 200行に読み込み
    :200RArgs sample1.txt sample2.txt sample3.txt

ファイルの先頭に、読み込みファイルを流し込むには、
行数指定に0を指定してください。

    " ファイルの先頭に読み込んだファイルを流し込む
    :0RArgs sample1.txt sample2.txt sample3.txt


------------------------------------------------------------------------------
[設定]

'g:rargs_exit_when_error'

    ファイル読み込みの際、エラーが発生した、もしくは、指定したファイルが読み込めない場合、
    プラグインの処理を中止するかしないかを 'g:rargs_exit_when_error' で設定できます。
    「デフォルトはエラーがあっても、残りのファイルを継続して処理する」です。

    エラー発見時に、プラグインの処理を中止するには、Vimの設定ファイルで次のように
    設定してください。

        let g:rargs_exit_when_error = '1'


------------------------------------------------------------------------------
[History]
2009/09/16  0.1
    - initial version.

2009/09/17  0.2
    - add exception handling logic.
    - ++opt parameter is supported.
    - option 'g:rargs_exit_when_error' is supported.


==============================================================================
" vim: set ff=unix et ft=vim nowrap :
