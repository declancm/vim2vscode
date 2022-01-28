# vim2vscode

Open all active buffers (files) in vim into vscode for when you need that visual\
studio debugging power.

The plugin will also transfer your working directory and even your current cursor\
location in your current buffer from vim into vscode.

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
code. The code instance will be loaded with the current working directory and\
the current file will be opened at the same cursor position.

Enter the command `:CodeCurrent` to open the current buffer in code. The code\
instance will be loaded with the current working directory and the file will be\
opened at the same cursor position.

### Default Mappings

- `<leader>oc` "Open in Code"\
  Equivalent to using the `:Code` command.
- `<leader>occ` "Open Current file in Code"\
  Equivalent to using the `:CodeCurrent` command.

### Custom Mappings

First disable the default mappings:

```vim
let g:vim2vscode_no_defaults = 1
```

Then add your keymaps:

```vim
" To open all active buffers in code:
nnoremap <leader>oc :Code<CR>

" To open the current buffer in code:
nnoremap <leader>occ :CodeCurrent<CR>
```

Source your config file and restart vim for the changes to take effect.
