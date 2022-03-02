" vim2vscode - Open files in vscode
" Maintainer: Declan Mullen https://github.com/declancm

" Check if the plugin has already been loaded.
if exists('g:loaded_vim2vscode')
  finish
endif
let g:loaded_vim2vscode = 1

" COMMANDS_AND_KEYMAPS:

command! CodeCurrent :call <SID>OpenCurrentBufferInCode()
command! Code :call <SID>OpenAllBuffersInCode()

nnoremap <Plug>vim2vscodeCurrent :call <SID>OpenCurrentBufferInCode()<CR>
nnoremap <Plug>vim2vscodeAll :call <SID>OpenAllBuffersInCode()<CR>

if !exists("g:vim2vscode_no_defaults")
    let g:vim2vscode_no_defaults = 0
endif

if g:vim2vscode_no_defaults != 1
    " The default keymaps.
    nmap <silent> <leader>occ <Plug>vim2vscodeCurrent
    nmap <silent> <leader>oc <Plug>vim2vscodeAll
endif

" FUNCTIONS:

function! s:OpenCurrentBufferInCode()

    " Save the current buffer.
    silent execute("w")

    " Get the name of the current buffer.
    let l:file = bufname()
    let l:fullPath = fnamemodify(l:file, ":p")

    " Get the cursor position.
    let l:cursorPos = getpos('.')

    echom "Opening '" . l:file . "' in vscode..."

    " Open the file in vscode at the saved cursor position.
    silent execute("!code -n -g " . l:fullPath . ":" . l:cursorPos[1] . ":"
                \ . l:cursorPos[2])

endfunction

function! s:OpenAllBuffersInCode()

    " Save all buffers.
    silent execute("wa")

    " Get the current working directory.
    let l:currentDirectory = getcwd()

    " Get the name of current buffer.
    let l:currentFile = bufname()
    let l:currentFullPath = fnamemodify(l:currentFile, ":p")

    " Get the cursor position.
    let l:currentCursorPos = getpos('.')

    echom "Opening your active buffers in vscode..."

    " Load the current directory into vscode.
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

            " Open all buffers but the current.
            if l:fullPath != l:currentFullPath
                " silent execute("!code " . l:fullPath)
                silent execute("!code -g " . l:fullPath . ":" . l:lineNumber)
            endif
        endif
        let l:i += 1
    endwhile

    " Open the current file at current cursor position.
    silent execute("!code -g " . l:currentFullPath . ":" . l:currentCursorPos[1]
                \ . ":" . l:currentCursorPos[2])
    " Needs to be run twice to fix a bug with vscode not opening to cursor
    " position sometimes.
    silent execute("!code -g " . l:currentFullPath . ":" . l:currentCursorPos[1]
                \ . ":" . l:currentCursorPos[2])

endfunction
