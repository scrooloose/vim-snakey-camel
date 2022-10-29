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

let s:CYCLED_CASE_ORDER = [s:SNAKE, s:CAMEL, s:KEBAB]

function! s:CreateMapsFor(convertTo, key)
    exec "nnoremap <plug>SnakeyCamelTo" . a:convertTo .
        \ " :call <SID>Convert(\"" . a:convertTo . "\")<cr>"

    let mapLHS = "<leader>s" . a:key
    let mapRHS = "<plug>SnakeyCamelTo" . a:convertTo
    if !hasmapto(mapRHS, 'n') && maparg(mapLHS) == ""
        exec "nmap ". mapLHS . " " . mapRHS
    endif
endfunction

call s:CreateMapsFor(s:SNAKE, 's')
call s:CreateMapsFor(s:SCREAMING_SNAKE, 'S')
call s:CreateMapsFor(s:CAMEL, 'c')
call s:CreateMapsFor(s:UPPER_CAMEL, 'C')
call s:CreateMapsFor(s:KEBAB, 'k')
call s:CreateMapsFor(s:SCREAMING_KEBAB, 'K')
call s:CreateMapsFor(s:NEXT_IN_CYCLE, '.')

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

function! s:CycledCaseFor(word) abort
    let wordCase = s:GetCaseFor(a:word)
    let idx = index(s:CYCLED_CASE_ORDER, wordCase)

    if idx == -1
        return s:CYCLED_CASE_ORDER[0]
    endif

    if idx + 1 >= len(s:CYCLED_CASE_ORDER)
        return s:CYCLED_CASE_ORDER[0]
    endif

    return s:CYCLED_CASE_ORDER[idx + 1]
endfunction
