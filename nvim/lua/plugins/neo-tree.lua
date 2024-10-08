return {
  "nvim-neo-tree/neo-tree.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      -- follow your cwd with WD
      follow = true,
      filesystem = { 
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        }
      }
    })
  end,
}
