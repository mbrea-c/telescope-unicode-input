# telescope-unicode-input

[Telescope](https://github.com/nvim-telescope/telescope.nvim) extension to type
unicode (or any kind of) symbols easily. Perfect for typing agda code.

## Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
return require("packer").startup(function(use)
  -- Install packer itself, if not already done
  use("wbthomason/packer.nvim")
  -- Install telescope
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = { "nvim-lua/plenary.nvim" },
  })
  -- Install the extension
  use({
    "mbrea-c/telescope-unicode-input",
    config = function()
      require("telescope-unicode-input").setup({
        -- Setup any symbols you wish to use
        unicode = {
          { value = "&", key = "and", name = "Ampersand" },
        },
      })
    end,
    requires = { "nvim-telescope/telescope.nvim" },
  })
end
```
