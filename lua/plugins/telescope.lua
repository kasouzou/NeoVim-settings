return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    -- スペース + ff でファイル検索
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    -- スペース + fg で文字列検索 (grep)
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  },
}
