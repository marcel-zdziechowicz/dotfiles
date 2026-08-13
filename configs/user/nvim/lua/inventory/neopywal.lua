return {
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("neopywal").setup({
        use_palette = "wallust",
        dim_inactive = true,
        show_split_lines = true,
      })
      vim.cmd.colorscheme("neopywal")
    end,
  },
}
