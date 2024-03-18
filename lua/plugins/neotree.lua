return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set('n', '<Leader>no', ':Neotree filesystem reveal left <CR>')
      vim.keymap.set('n', '<Leader>nc', ':Neotree filesystem close <CR>')
      require("neo-tree").setup({
        close_if_last_window = true,
          filesystem = {
            filtered_items = {
              visible = true,
            }
          }
      })
    end
  }
