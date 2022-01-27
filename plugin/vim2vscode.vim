command! Code :call <SID>OpenBuffersInCode()

" make it so if a variable g:vim2vscode_defaults then these defaults aren't set.
nnoremap <unique> <silent> <leader>occ :call <SID>OpenInCode()<CR>
nnoremap <unique> <silent> <leader>oc :call <SID>OpenBuffersInCode()<CR>

function! s:OpenInCode()

    " get name of current buffer
    let l:file = bufname()
    let l:fullpath = fnamemodify(l:file, ":p")

    echom "Opening '" . l:fullpath . "' in vscode..."

    " open file in vscode at current cursor position
    let l:cursorpos = getpos('.')
    silent execute("!code --goto " . l:fullpath . ":" . l:cursorpos[1] . ":" . l:cursorpos[2])

endfunction

function! s:OpenBuffersInCode()

    " get name of current buffer
    let l:currentFile = bufname()
    let l:currentFullPath = fnamemodify(l:currentFile, ":p")

    echom "Opening your active buffers in vscode..."

    let l:activeBuffers = execute("buffers(a)")
    let l:lenActiveBuffers = len(l:activeBuffers)
    let l:i = 0
    let l:number = 0
    while i < l:lenActiveBuffers
        if "\n" == l:activeBuffers[i]
            let l:number += 1
            let l:bufnr = str2nr(l:activeBuffers[i+1:i+4])
            let l:bufname = bufname(l:bufnr)
            let l:fullpath = fnamemodify(l:bufname, ":p")

            " open all buffers but the current
            if l:fullpath != l:currentFullPath
                silent execute("!code -r " . l:fullpath)
            endif
        endif
        let l:i += 1
    endwhile

    " open the current file at current cursor position
    let l:cursorpos = getpos('.')
    silent execute("!code --goto " . l:currentFullPath . ":" . l:cursorpos[1] . ":" . l:cursorpos[2])

endfunction
