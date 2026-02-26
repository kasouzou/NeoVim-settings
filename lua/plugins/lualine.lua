return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto", -- Automatically matches the colorscheme
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
      },
    })
  end,
}
