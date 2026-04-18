return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        use_treesitter = true,
        chars = { right_arrow = "─" },
        style = "#75A1FF",
        duration = 50,
        delay = 10,
      },
      indent = { enable = true },
      line_num = { enable = true },
      exclude_filetypes = { "help", "git", "markdown", "snippets", "text", "gitconfig", "alpha", "dashboard" },
    })
  end,
}
