" **array.vim**
" 
" ARRAY FUNCTIONS:
" 
" Use arrays of strings in vim. Make a new, empty array of length 0:
"
"      let arr=g:arrnew
" 
" or make an array containing some strings:
" 
"      let arr=Arr("first string", "second string", "etc")
"
" Set the string at the n-th index:
" 
"      let arr=ArrSet(arr,"the string",n)
"
" Retreive the string at the n-th index: 
"
"      let strn=ArrGet(arr,n)
" 
" Add a string to array arr:
"
"      let arr=ArrAppend(arr,"string to be added")
"
" Find the index of which the string exactly matches pattern pat:
" 
"      let n=ArrFindExact(arr,pat)
" 
" Find out the length of an array:
" 
"      let l=ArrLen(arr)
"
" Execute the contents of an array
"
"      call ArrExecute(arr)
" 
" Return the length of the longest string in the array:
" 
"      let maxl=ArrMaxLen(arr)
" 
" Print the contents of an array:
" 
"      call ArrPrint(arr)
"
" OTHER FUNCTIONS: 
"
" The file buffun.vim contains functions for getting an array that 
" contains the names and numbers of all currently loaded buffers:
"
"      let bufnamesarr=BufNamesArr()
"
"      let bufnumsarr=BufNumsArr()
"
" Source buffun.vim to acces them.
" 
"
" NOTE: 
" 
"   The array itself is also a string like:
" 
"         °2±first one°1±middle one°0±last one°-1±
" 
"   i.e. the strings stored in the array are separated by marks °n±.
"   This means that the strings stored in the array cannot contain °
"   or ±. If you do want to store ° or ±, you must define more complex 
"   separation marks, and the search pattern strings to find them.
"   (See global variables arropen, arropenexp etc. below.)
"

" ----------------------------------------------------------------------------- 
if !exists("_array_vim_sourced_") 
let _array_vim_sourced_=1 
" ----------------------------------------------------------------------------- 

" Global variables
let arropen="°"
let arropenexp="°"
let arrclose="±"
let arrcloseexp="±"
let arrstop="-1"
let arrstopexp="-1"
let arrnew=arropen.arrstop.arrclose

" Return length of array
function! ArrLen(array)
  return strpart(a:array,1,match(a:array,g:arrcloseexp)-1)+1
endfunction

" Ret length of longest string of array
function! ArrMaxLen(arr)
  let maxlen=0
  let n=ArrLen(a:arr)-1
  let i=0
  while i<=n
    let l=strlen(ArrGet(a:arr,i))
    if l>maxlen
      let maxlen=l
    endif
    let i=i+1
  endwhile
  return maxlen
endfunction

" Only need this file for ArrPrint()
" so txtfun.vim 
" Print the contents of an array linewise 
" function! ArrPrint(arr) 
"   let oc=col(".") 
"   let ol=line(".") 
"   let n=ArrLen(a:arr)-1 
"   let outstr="" 
"   let i=0 
"   while i<=n 
"     let s=ArrGet(a:arr,i) 
"     let outstr=outstr.s."\n" 
"     let i=i+1 
"   endwhile 
"   call PrintLineAfter(outstr) 
" endfunction 

function! ArrLinesStr(arr)
  let out=""
  let i=0
  while i<=(ArrLen(a:arr)-1)
    let out=out.ArrGet(a:arr,i)."\n"
    let i=i+1
  endwhile
  return out
endfunction

" Return string with value of array position nix set to setstr 
" function! ArrSet(oldarr,setstr,nix) 
"   if a:nix>(ArrLen(a:oldarr)-1) 
"     echo "ERROR in ArrSet(oldarr,setstr,nix): nix exceeds array length." 
"   else 
"     let n1=matchend(a:oldarr,g:arropenexp.a:nix.g:arrcloseexp) 
"     let n2=match(a:oldarr,g:arropenexp.(a:nix-1).g:arrcloseexp) 
"     let newarr=strpart(a:oldarr,0,n1).strpart(a:oldarr,n2,strlen(a:oldarr)) 
"     let n=matchend(newarr,g:arropenexp.a:nix.g:arrcloseexp) 
"     return strpart(newarr,0,n).a:setstr.strpart(newarr,n,strlen(newarr)-n) 
"   endif 
" endfunction 

" Return value of array position nix
function! ArrGet(arr,nix)
  let n1=matchend(a:arr,g:arropenexp.a:nix.g:arrcloseexp)
  let n2=match(a:arr,g:arropenexp.(a:nix-1).g:arrcloseexp)
  return strpart(a:arr,n1,n2-n1)
endfunction

" Return array with new entry containing str
function! ArrAppend(arr,str)
  return g:arropen.ArrLen(a:arr).g:arrclose.a:str.a:arr
endfunction

" Like strpart
function! ArrPart(arr,start,length)
  let newarr=g:arrnew
  let i=a:start
  while i<=(a:start+a:length-1)
    let newarr=ArrAppend(newarr,ArrGet(a:arr,i))
    let i=i+1
  endwhile
  return newarr
endfunction

" Concatination
function! ArrCon(arr1,arr2)
  let newarr=a:arr1
  let i=0
  while i<=(ArrLen(a:arr2)-1)
    let newarr=ArrAppend(newarr,ArrGet(a:arr2,i))
    let i=i+1
  endwhile
  return newarr
endfunction

" Delete entry n
function! ArrDelIx(arr,n)
  let a1=ArrPart(a:arr,0,a:n)
  let a2=ArrPart(a:arr,a:n+1,ArrLen(a:arr)-1-a:n)
  return ArrCon(a1,a2)
endfunction

" Return an array with contents ...
function! Arr(...)
  let newarr=g:arrnew
  let n=a:0
  let i=1
  while i<=n
    execute "let newarr=ArrAppend(newarr,a:".i.")"
    let i=i+1
  endwhile
  return newarr
endfunction

" Return ix if str matches on of entries of arr exactly
" else ret -1
function! ArrFindExact(arr,str)
  let n=match(a:arr,g:arrcloseexp.a:str.g:arropenexp)
  if n>-1
    let s=strpart(a:arr,0,n+1)
    let n1=match(s,g:arropenexp."[0-9\\(-1\\)]\*".g:arrcloseexp."$")
    return strpart(s,n1+1,n-n1-1)
  else
    return -1
  endif
endfunction

" str='test.xxx', seppat='\\.': return array with entries 'test' and 'xxx'
function! ArrGetItems(str,seppat)
  let arr=g:arrnew
  let str=a:str
  let n=match(str,a:seppat)
  while n>0
    let arr=ArrAppend(arr,strpart(str,0,n))
    let str=strpart(str,n+1,strlen(str)+n-1)
    let n=match(str,a:seppat)
  endwhile
  let arr=ArrAppend(arr,str)
  return arr
endfunction

" Execute the contents of an array, linewise. second arg: exec only 
" entry n
function! ArrExecute(arr,...)
  if a:0==0
    let n1=0
    let n2=ArrLen(a:arr)-1
  else
    let n1=a:1
    let n2=a:1
  endif
  let i=n1
  while i<=n2
    execute ArrGet(a:arr,i)
    let i=i+1
  endwhile
endfunction
" ----------------------------------------------------------------------------- 
endif 
" ----------------------------------------------------------------------------- 

