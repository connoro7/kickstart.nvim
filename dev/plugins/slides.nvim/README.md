# slides.nvim

Present markdown files directly in neovim

Uses header lines (`#`, `##`, `###`, ...) to denote slide boundaries

## Usage

```lua
require("slides").start_presentation {}
```

## Defaults

Use `n`/`p` to go to next/previous slide, `q` to quit.
