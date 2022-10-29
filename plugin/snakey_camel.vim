if exists('g:loaded_snakey_camel')
    finish
endif
let g:loaded_snakey_camel = 1

let s:SNAKE = "Snake"
let s:SCREAMING_SNAKE = "ScreamingSnake"
let s:CAMEL = "Camel"
let s:UPPER_CAMEL = "UpperCamel"
let s:KEBAB = "Kebab"
let s:SCREAMING_KEBAB = "ScreamingKebab"
let s:NEXT_IN_CYCLE = "NextInCycle"

exec "nnoremap <plug>SnakeyCamelToSnake " .
    \ ":call <SID>Convert(\"" . s:SNAKE . "\")<cr>"
exec "nnoremap <plug>SnakeyCamelToScreamingSnake " .
    \ ":call <SID>Convert(\"" . s:SCREAMING_SNAKE ."\")<cr>"

exec "nnoremap <plug>SnakeyCamelToCamel ".
    \ ":call <SID>Convert(\"" . s:CAMEL . "\")<cr>"
exec "nnoremap <plug>SnakeyCamelToUpperCamel " .
    \ ":call <SID>Convert(\"" . s:UPPER_CAMEL . "\")<cr>"

exec "nnoremap <plug>SnakeyCamelToKebab " .
    \ ":call <SID>Convert(\"" . s:KEBAB . "\")<cr>"
exec "nnoremap <plug>SnakeyCamelToScreamingKebab " .
    \ ":call <SID>Convert(\"" . s:SCREAMING_KEBAB . "\")<cr>"

exec "nnoremap <plug>SnakeyCamelToNextInCycle " .
    \ ":call <SID>Convert(\"" . s:NEXT_IN_CYCLE . "\")<cr>"

nmap <unique> <leader>ss <plug>SnakeyCamelToSnake
nmap <unique> <leader>sS <plug>SnakeyCamelToScreamingSnake
nmap <unique> <leader>sc <plug>SnakeyCamelToCamel
nmap <unique> <leader>sC <plug>SnakeyCamelToUpperCamel
nmap <unique> <leader>sk <plug>SnakeyCamelToKebab
nmap <unique> <leader>sK <plug>SnakeyCamelToScreamingKebab
nmap <unique> <leader>s. <plug>SnakeyCamelToNextInCycle

function! s:Convert(convertTo) abort
    let oldIskeyword = &iskeyword
    set iskeyword+=-
    let cword = expand("<cword>")
    let oldPos = getpos(".")

    try
        let replacement = s:ConvertWord(cword, a:convertTo)
        exec "normal ciw" . replacement
        call setpos(".", oldPos)
        silent! call repeat#set("\<plug>SnakeyCamelTo" . a:convertTo)
    finally
        exec 'set iskeyword=' . oldIskeyword
    endtry
endfunction

function! s:ConvertWord(word, to) abort
    let snaked = s:ConvertAnythingToSnake(a:word)

    if a:to == s:SNAKE
        return snaked
    elseif a:to == s:SCREAMING_SNAKE
        return toupper(snaked)
    elseif a:to == s:CAMEL
        return substitute(snaked, '_\(\U\)', '\u\1', 'g')
    elseif a:to == s:UPPER_CAMEL
        let result = substitute(snaked, '_\(\U\)', '\u\1', 'g')
        return substitute(result, '^\(\U\)', '\u\1', '')
    elseif a:to == s:KEBAB
        return substitute(snaked, '_', '-', 'g')
    elseif a:to == s:SCREAMING_KEBAB
        return toupper(substitute(snaked, '_', '-', 'g'))
    elseif a:to == s:NEXT_IN_CYCLE
        let nextCase = s:CycledCaseFor(a:word)
        return s:ConvertWord(a:word, nextCase)
    else
        throw "SnakeyCamel: Invalid 'to' param: " . a:to
    endif
endfunction

function! s:ConvertAnythingToSnake(word) abort
    let wordCase = s:GetCaseFor(a:word)

    if wordCase == s:SNAKE || wordCase == s:SCREAMING_SNAKE
        return tolower(a:word)
    endif

    if wordCase == "camel" || wordCase == s:UPPER_CAMEL
        let result = substitute(a:word, '\(\u\)', '_\L\1', 'g')
        let result = substitute(result, '^_', '', '')
        return result
    endif

    if wordCase ==  s:KEBAB|| wordCase == s:SCREAMING_KEBAB
        return tolower(substitute(a:word, '-', '_', 'g'))
    endif
endfunction

function s:GetCaseFor(word) abort
    if a:word =~ '\C^[a-z_]\+$' | return s:SNAKE | endif
    if a:word =~ '\C^[A-Z_]\+$' | return s:SCREAMING_SNAKE | endif
    if a:word =~ '\C^[A-Z][A-Za-z]\+$' | return s:UPPER_CAMEL | endif
    if a:word =~ '\C^[a-z][A-Za-z]\+$' | return s:CAMEL | endif
    if a:word =~ '\C^[a-z][A-Za-z\-]\+$' | return s:KEBAB | endif
    if a:word =~ '\C^[A-Z][A-Za-z\-]\+$' | return s:SCREAMING_KEBAB | endif

    throw 'SnakeyCamel: unrecognized word format'
endfunction

let s:cycledCaseOrder = [s:SNAKE, s:SCREAMING_SNAKE, s:CAMEL, s:KEBAB]
function! s:CycledCaseFor(word) abort
    let wordCase = s:GetCaseFor(a:word)
    let idx = index(s:cycledCaseOrder, wordCase)

    if idx == -1
        return s:cycledCaseOrder[0]
    endif

    if idx + 1 >= len(s:cycledCaseOrder)
        return s:cycledCaseOrder[0]
    endif

    return s:cycledCaseOrder[idx + 1]
endfunction
