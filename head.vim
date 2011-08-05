:scriptencoding utf-8
" 1度スクリプトを読み込んだら、2度目は読み込まない
:if exists('g:loaded_head')
    :finish
:endif
:let g:loaded_head = 1

" g:head_file_splitterオプションが設定されていたら、、
" そのオプションの値を使用する
" g:head_file_splitterオプションが設定されていなかったら、、
" スクリプトで定義したデフォルト値を使用する
:if exists('g:head_file_splitter')
    :let s:spc = g:head_file_splitter
:else
    :if has('win32')
        :let s:spc = ";"
    :else
        :let s:spc = ":"
    :endif
:endif

" g:head_display_linesオプションが設定されていたら、その値を使用する
" 設定されていなかったら、スクリプトのデフォルト値を使用する
:if exists('g:head_display_lines')
    :let s:viewsize = g:head_display_lines
:else
    :let s:viewsize = 10
:endif

" 渡された値で、s:viewsizeを更新する
:function! s:UpdateViewSize(size)
    :let s:viewsize = a:size
:endfunction

" head:sample.txt、もしくは、head;sample.txt
" というファイル名を渡されるので、
" このファイルの上の方だけを読み込む
:function! s:HeadRead(path)
    " <afile>ならexpand()で展開する
    " そうでないなら渡されたファイル名を使用する
    :if a:path == "<afile>"
        :let l:file = expand(a:path)
    :else
        :let l:file = a:path
    :endif

    " 実際に読む込むべきファイルのパスを取得
    :let l:prot = matchstr(l:file,'^\(head\)\ze' . s:spc)
    :if l:prot != ''
        :let l:file = strpart(l:file, strlen(l:prot) + 1)
    :endif

    " ファイルを読み込んで、バッファにセット
    :0,$d
    :call setline(1,"foo")
    :let l:lines = readfile(l:file, "", s:viewsize)
    :let l:i = 0
    :while l:i < len(l:lines)
        :call setline(l:i + 2, l:lines[l:i])
        :let l:i += 1
    :endwhile
    :1d

    " 編集中ではない状態にする
    :set nomodified
    " ファイルタイプを再判定
    :filetype detect
:endfunction

" head:sample.txt、もしくは、head;sample.txt
" というファイル名を渡されるので、
" このファイルの上の方だけをバッファのテキストで更新する
:function! s:HeadWrite(path)
    " <afile>ならexpand()で展開する
    " そうでないなら渡されたファイル名を使用する
    :if a:path == "<afile>"
        :let l:file = expand(a:path)
    :else
        :let l:file = a:path
    :endif

    " 実際に読む込むべきファイルのパスを取得
    :let l:prot = matchstr(l:file,'^\(head\)\ze' . s:spc)
    :if l:prot != ''
        :let l:file = strpart(l:file, strlen(l:prot) + 1)
    :endif

    " 更新しても良いか、ユーザに問い合わせ
    :let choice = confirm("Are you sure, update '".l:file."' head ?", "&Update\n&Cancel")
    :if choice == 1
        " 全行読み込んで、ファイルの上の方だけ更新
        " 最後に編集中状態をクリア。編集していない状態にする。
        :let l:lines = filereadable(l:file)? readfile(l:file): []
        :if len(l:lines) > s:viewsize
            :let l:i = 0
            :while l:i < s:viewsize
                :unlet l:lines[l:i- 1]
                :let l:i += 1
            :endwhile

            :let l:curbufs = getline(0, line("$"))
            :call extend(l:curbufs, l:lines)
            :call writefile(l:curbufs, l:file)
            :set nomodified
        :else
            :call writefile(getline(0, line("$")), l:file)
            :set nomodified
        :endif
        :return
    :else
        :return
    :endif
:endfunction

" tail:sample.txt、もしくは、tail;sample.txt
" というファイル名を渡されるので、
" このファイルの下の方だけをバッファに読み込む。
:function! s:TailRead(path)
    " <afile>ならexpand()で展開する
    " そうでないなら渡されたファイル名を使用する
    :if a:path == "<afile>"
        :let l:file = expand(a:path)
    :else
        :let l:file = a:path
    :endif

    " 実際に読む込むべきファイルのパスを取得
    :let l:prot = matchstr(l:file,'^\(tail\)\ze' . s:spc)
    :if l:prot != ''
        :let l:file = strpart(l:file, strlen(l:prot) + 1)
    :endif

    " ファイルを下の方だけ読み込んで、バッファにセットする
    :0,$d
    :call setline(1,"foo")
    :let l:lines = readfile(l:file)
    :if len(l:lines) > s:viewsize
        :let l:i = 0
        :while l:i < s:viewsize
            :call setline(l:i + 2, l:lines[len(l:lines) - s:viewsize + l:i])
            :let l:i += 1
        :endwhile
    :else
        :let l:i = 0
        :while l:i < len(l:lines)
            :call setline(l:i + 2, l:lines[l:i])
            :let l:i += 1
        :endwhile
    :endif
    :1d

    " 編集中ではない状態にする
    :set nomodified
    " ファイルタイプを再判定
    :filetype detect
:endfunction

" tail:sample.txt、もしくは、tail;sample.txt
" というファイル名を渡されるので、
" このファイルの下の方だけをバッファのテキストで更新する
:function! s:TailWrite(path)
    " <afile>ならexpand()で展開する
    " そうでないなら渡されたファイル名を使用する
    :if a:path == "<afile>"
        :let l:file = expand(a:path)
    :else
        :let l:file = a:path
    :endif

    " 実際に読む込むべきファイルのパスを取得
    :let l:prot = matchstr(l:file,'^\(tail\)\ze' . s:spc)
    :if l:prot != ''
        :let l:file = strpart(l:file, strlen(l:prot) + 1)
    :endif

    " 更新しても良いか、ユーザに問い合わせ
    :let choice = confirm("Are you sure, update '".l:file."' tail ?", "&Update\n&Cancel")
    :if choice == 1
        " 全行読み込んで、ファイルの下の方だけ更新
        " 最後に編集中状態をクリア。編集していない状態にする。
        :let l:lines = filereadable(l:file)? readfile(l:file): []
        :if len(l:lines) > s:viewsize
            :let l:i = 0
            :while l:i < s:viewsize
                :unlet l:lines[len(l:lines) - 1]
                :let l:i += 1
            :endwhile
            :call extend(l:lines, getline(0, line("$")))
            :call writefile(l:lines, l:file)
            :set nomodified
        :else
            :call writefile(getline(0, line("$")), l:file)
            :set nomodified
        :endif
        :return
    :else
        :return
    :endif
:endfunction

" autocmdのグループを定義
" head、tailで始まるファイルは、他のスクリプトに操作させたくないので、
" autocmd!で、設定されたautocmdを消してしまう。
:augroup Head
    :autocmd!
    :execute ":autocmd BufReadCmd   head" .s:spc. "*,head" .s:spc. "*/* HeadRead  <afile>"
    :execute ":autocmd FileReadCmd  head" .s:spc. "*,head" .s:spc. "*/* HeadRead  <afile>"
    :execute ":autocmd BufWriteCmd  head" .s:spc. "*,head" .s:spc. "*/* HeadWrite <afile>"
    :execute ":autocmd FileWriteCmd head" .s:spc. "*,head" .s:spc. "*/* HeadWrite <afile>"
:augroup END
:augroup Tail
    :autocmd!
    :execute ":autocmd BufReadCmd   tail" .s:spc. "*,tail" .s:spc. "*/* TailRead  <afile>"
    :execute ":autocmd FileReadCmd  tail" .s:spc. "*,tail" .s:spc. "*/* TailRead  <afile>"
    :execute ":autocmd BufWriteCmd  tail" .s:spc. "*,tail" .s:spc. "*/* TailWrite <afile>"
    :execute ":autocmd FileWriteCmd tail" .s:spc. "*,tail" .s:spc. "*/* TailWrite <afile>"
:augroup END

" ファイルの読み書き用のコマンドを定義
:command! -nargs=1 HeadRead  :call s:HeadRead(<f-args>)
:command! -nargs=1 HeadWrite :call s:HeadWrite(<f-args>)
:command! -nargs=1 TailRead  :call s:TailRead(<f-args>)
:command! -nargs=1 TailWrite :call s:TailWrite(<f-args>)

" プロパティ更新用のコマンドを定義
:command! -nargs=1 Head      :call s:UpdateViewSize(<f-args>)

" スクリプトはここまで
:finish

==============================================================================
head.vim : ファイルの上か下、限定された行数のみ読み込むスクリプト
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/plugin/head.vim
==============================================================================
author  : 小見 拓
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2009/12/19 16:00:00
==============================================================================
"head;"（Windows以外ではhead:）をファイル名に付けると、
ファイルの上から10行のみを読み込み、
"tail;"（Windows以外ではtail:）をファイル名に付けると、
ファイルの下から10行のみを読み込む。
sudo.vimのような処理を行う。

(Windows)
:e head;sample.txt
:r head;sample.txt
:w head;sample.txt
:e tail;sample.txt
:r tail;sample.txt
:w tail;sample.txt

(Windows以外)
:e head:sample.txt
:r head:sample.txt
:w head:sample.txt
:e tail:sample.txt
:r tail:sample.txt
:w tail:sample.txt

==============================================================================
" vim: set et nowrap ft=vim :
