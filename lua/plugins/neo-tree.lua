return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = false,
          hide_gitignored = false,
          hife_dotfiles = false
        }
      }
    },
    lazy = false,
    config = function()
      vim.keymap.set('n', '<C-e>', '<Cmd>Neotree toggle<CR>', { desc = 'Toggle Neotree' })
    end
  }
};
