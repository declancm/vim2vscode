# vim2vscode

Open all active buffers (files) in vim into vscode for when you need that visual\
studio debugging power.

## Installation

Use a vim plugin. Here are some examples:

### Vim-Plug

```vim
Plug 'declancm/vim2vscode'
```

### Packer

```vim
use 'declancm/vim2vscode'
```

## Usage

Enter the command `:Code` to open all buffers (files) open on the screen in\
code. The current file will be opened in code at the same cursor position.

Enter the command `:CodeCurrent` to open the current buffer in code. The file\
will be opened in code at the same cursor position.

### Default Mappings

- `<leader>oc` "Open in Code"\
  Equivalent to using the `:Code` command.
- `<leader>occ` "Open Current file in Code"\
  Equivalent to using the `:CodeC` command.

### Custom Mappings

First disable the default mappings:

```vim
let g:vim2vscode_no_defaults = 1
```

- Open all active buffers in vscode:

  ```vim
  nnoremap <leader>oc :Code<CR>
  ```

- Open current buffer in vscode:

  ```vim
  nnoremap <leader>occ :CodeCurrent<CR>
  ```

