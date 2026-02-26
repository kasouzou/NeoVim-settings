return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- Optional for better UI
  },
  config = function()
    require("flutter-tools").setup({
      lsp = {
        color_capabilities = true,
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
        },
      },
      widget_guides = {
        enabled = true,
      },
    })
  end,
}
