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

    " save all buffers
    silent execute("wa")

    " get the current working directory
    let l:currentDirectory = getcwd()

    " get name of current buffer
    let l:file = bufname()
    let l:fullPath = fnamemodify(l:file, ":p")

    " get cursor position
    let l:cursorPos = getpos('.')

    echom "Opening '" . l:fullPath . "' in vscode..."

    " load the current directory into vscode
    " silent execute("!code -n")
    " silent execute("!code --add " . l:currentDirectory)
    silent execute("!code -n " . l:currentDirectory)

    " open file in vscode at current cursor position
    silent execute("!code -g " . l:fullPath . ":" . l:cursorPos[1] . ":" . l:cursorPos[2])
    " needs to be run twice to fix a bug with vscode not opening to cursor
    " position sometimes
    silent execute("!code -g " . l:fullPath . ":" . l:cursorPos[1] . ":" . l:cursorPos[2])

endfunction

function! s:OpenAllBuffersInCode()

    " save all buffers
    silent execute("wa")

    " get the current working directory
    let l:currentDirectory = getcwd()

    " get name of current buffer
    let l:currentFile = bufname()
    let l:currentFullPath = fnamemodify(l:currentFile, ":p")

    " get cursor position
    let l:currentCursorPos = getpos('.')

    echom "Opening your active buffers in vscode..."

    " load the current directory into vscode
    " silent execute("!code -n")
    " silent execute("!code --add " . l:currentDirectory)
    silent execute("!code -n " . l:currentDirectory)

    let l:activeBuffers = execute("buffers(a)")
    let l:lenActiveBuffers = len(l:activeBuffers)
    let l:i = 0
    while i < l:lenActiveBuffers
        if "\n" == l:activeBuffers[i]
            let l:bufferNumber = str2nr(l:activeBuffers[i+1:i+4])
            let l:bufferName = bufname(l:bufferNumber)
            let l:bufferDictionary = getbufinfo(l:bufferName)
            let l:lineNumber = (l:bufferDictionary[0]).lnum
            let l:fullPath = fnamemodify(l:bufferName, ":p")

            " open all buffers but the current
            if l:fullPath != l:currentFullPath
                " silent execute("!code " . l:fullPath)
                silent execute("!code -g " . l:fullPath . ":" . l:lineNumber)
            endif
        endif
        let l:i += 1
    endwhile

    " open the current file at current cursor position
    silent execute("!code -g " . l:currentFullPath . ":" . l:currentCursorPos[1] . ":" . l:currentCursorPos[2])
    " needs to be run twice to fix a bug with vscode not opening to cursor
    " position sometimes
    silent execute("!code -g " . l:currentFullPath . ":" . l:currentCursorPos[1] . ":" . l:currentCursorPos[2])

endfunction
