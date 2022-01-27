# vim2vscode

Open all active buffers (files) in vs code for when you need that visual studio\
debugging power. Opens the current file at the exact same cursor position.

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
code. The current file will be opened in code at the exact same cursor position.

### Default Mapping

- `<leader>oc` is the same as using the `:Code` command. It opens all buffers\
  open on the screen in code. The current file will be opened in vscode at the\
  exact same cursor position.
- `<leader>occ` opens the current buffer in code. The file will be opened at the\
  same cursor position as in vim.
