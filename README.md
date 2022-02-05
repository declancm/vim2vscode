# vim2vscode

Open all active vim buffers (files) in vscode for when you need that visual\
studio debugging power.

The plugin will also transfer your working directory and even your current cursor\
location in your current buffer from vim into vscode.

## Demo Video

<https://user-images.githubusercontent.com/90937622/152325955-17417cef-12b7-4a41-ae3b-1202e622aa6e.mp4>

The three files which were open on screen were opened within vscode, and the\
working directory in vscode changed to match vim.

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

Enter the command `:CodeCurrent` to open only the current buffer in code. The code\
instance will be loaded without the current directory to stop unnecessary loading.

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
