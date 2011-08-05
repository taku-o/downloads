
function! Rand(max)
    perl << EOF
        my $max = VIM::Eval('a:max');
        my $value = int(rand($max)), '\n';
        VIM::DoCommand("let l:r = $value")
EOF
    return l:r
endfunction


