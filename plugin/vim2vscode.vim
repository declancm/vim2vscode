" vim2vscode - Open files in vscode
" Maintainer: Declan Mullen https://github.com/declancm
" Version: 1.1

" if exists('g:loaded_vim2vscode')
"   finish
" endif
" let g:loaded_vim2vscode = 1

command! CodeCurrent :call <SID>OpenCurrentBufferInCode()
command! Code :call <SID>OpenAllBuffersInCode()

" make it so if a variable g:vim2vscode_no_defaults then these defaults aren't set.
nnoremap <Plug>vim2vscodeCurrent :call <SID>OpenCurrentBufferInCode()<CR>
nnoremap <Plug>vim2vscodeAll :call <SID>OpenAllBuffersInCode()<CR>

if !exists("g:vim2vscode_no_defaults")
    let g:vim2vscode_no_defaults = 0
endif

if g:vim2vscode_no_defaults != 1
    nmap <silent> <leader>occ <Plug>vim2vscodeCurrent
    nmap <silent> <leader>oc <Plug>vim2vscodeAll
endif

function! s:OpenCurrentBufferInCode()

    " get the current working directory
    let l:currentDirectory = getcwd()

    " get name of current buffer
    let l:file = bufname()
    let l:fullPath = fnamemodify(l:file, ":p")

    echom "Opening '" . l:fullPath . "' in vscode..."

    " load the current directory into vscode
    silent execute("!code " . l:currentDirectory)

    " open file in vscode at current cursor position
    let l:cursorPos = getpos('.')
    silent execute("!code -r --goto " . l:fullPath . ":" . l:cursorPos[1] . ":" . l:cursorPos[2])

endfunction

function! s:OpenAllBuffersInCode()

    " get the current working directory
    let l:currentDirectory = getcwd()

    " get name of current buffer
    let l:currentFile = bufname()
    let l:currentFullPath = fnamemodify(l:currentFile, ":p")

    echom "Opening your active buffers in vscode..."

    " load the current directory into vscode
    silent execute("!code " . l:currentDirectory)

    let l:activeBuffers = execute("buffers(a)")
    let l:lenActiveBuffers = len(l:activeBuffers)
    let l:i = 0
    let l:number = 0
    while i < l:lenActiveBuffers
        if "\n" == l:activeBuffers[i]
            let l:number += 1
            let l:bufferNumber = str2nr(l:activeBuffers[i+1:i+4])
            let l:bufferName = bufname(l:bufferNumber)
            let l:fullPath = fnamemodify(l:bufferName, ":p")

            " open all buffers but the current
            if l:fullPath != l:currentFullPath
                silent execute("!code -r " . l:fullPath)
            endif
        endif
        let l:i += 1
    endwhile

    " open the current file at current cursor position
    let l:cursorPos = getpos('.')
    silent execute("!code -r --goto " . l:currentFullPath . ":" . l:cursorPos[1] . ":" . l:cursorPos[2])

endfunction
