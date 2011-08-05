" 1�x�����ǂݍ��܂��Ȃ��B {{{
" �J�����̓R�����g�A�E�g���Ă����Ɗy�ł��B
"if exists('g:loaded_sample')
"    finish
"endif
"let g:loaded_sample = 1

" cpo�I�v�V�����𓦂����B
let s:save_cpo = &cpo
set cpo&vim

" OutCommandViewer�R�}���h�����s����ƁAs:OutCommandViewer()���Ăяo���܂��B
command! -nargs=0 OutCommandViewer :call s:OutCommandViewer()


" OutCommandViewer�R�}���h����Ăяo����܂��B
function! s:OutCommandViewer()

    " World�I�u�W�F�N�g�𐶐�
    let l:world = tlib#World#New()

    " World�I�u�W�F�N�g�̑�����ݒ�

    " �X�N���b�`�̖��O
    let l:world.scratch = "SCRATCH_NAME"

    " �E�B���h�E���c�ɕ������邩�A���ɕ������邩
    let l:world.scratch_vertical = 1

    " ���X�g��I��������A�ǂ����������ɂ����邩
    " key      ���̓L�[
    " key_name �w���v�Ŏg�p����
    " help     �w���v�Ŏg�p����
    " agent    �ǂ̃t�@���N�V�������Ăяo����
    let l:world.key_handlers = [
    \    {'key':1,  'key_name':'<c-a>', 'help':'push Control-A.', 'agent':'g:CallCtrlA' },
    \    {'key':16, 'key_name':'<c-p>', 'help':'push Control-P.', 'agent':'g:CallCtrlP' },
    \    {'key':21, 'key_name':'<c-u>', 'help':'push Control-U.', 'agent':'g:CallCtrlU' }
    \ ]


    " �J�����X�N���b�`�E�B���h�E�ŕ\������ꗗ
    " �������̃R�����g�A�E�g
    " let l:world.base = [ "A", "B", "C" ]

    " �O���R�}���h�����s
    let l:ls_result = system('ls')

    " ���ʂ�ҏW���ă��X�g�ɕϊ�
    let l:ls_list = split(l:ls_result, '\n')

    " base�L�[�ɃZ�b�g����
    let l:world.base = l:ls_list


    " �n���ꂽWorld�I�u�W�F�N�g�̃p�����[�^�����ɁA
    " �X�N���b�`�E�B���h�E���J���܂��B
    call tlib#input#ListW(l:world)

endfunction


" Control-A�������ƌĂяo�����
function! g:CallCtrlA(world, selected)
    " �I�������e�L�X�g���擾
    let l:entry = a:selected[0]

    " �p�^�[��1 �P���ɃR�}���h�����s����
    let l:files = system('ls')
    echo l:files
" }}}
    return a:world
endfunction


" Control-P�������ƌĂяo�����
function! g:CallCtrlP(world, selected)
    " �I�������e�L�X�g���擾
    let l:entry = a:selected[0]

    " �p�^�[��2 ���̃E�B���h�E�ŉ����R�}���h�����s����
    let l:sb = a:world.SwitchWindow('win')

    " SwitchWindow()���s��ɏ��������s
    "let l:files = system('ls')
    "echo l:files


    " �I�������t�@�C����ǂ�
    for l:line in readfile(l:entry)
        " �Ō�̍s�̌�ɒǉ�.
        call append(line("$"), l:line)
    endfor


    " �������I�������ASwitchWindow()��return value�����s����
    execute l:sb

    return a:world
endfunction


" Control-U�������ƌĂяo�����
function! g:CallCtrlU(world, selected) " {{{
    " �I�������e�L�X�g���擾
    let l:entry = a:selected[0]

    " �p�^�[��3 �R�}���h���s��A�E�B���h�E�����
    let l:files = system('ls')
    echo l:files

    " CloseScratch()�ŃE�B���h�E�����B
    silent call a:world.CloseScratch()

    return a:world
endfunction


" cpo�I�v�V���������ɖ߂��B
let &cpo = s:save_cpo
finish

" TITLE: ���s���鏈����ύX
" vim:set ft=vim ff=unix fenc=cp932 nolist number hlsearch nowrap foldmethod=marker : }}}
