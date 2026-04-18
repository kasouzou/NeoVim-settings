return {
  "dnlhc/glance.nvim",
  cmd = "Glance",
  keys = {
    { "gD", "<cmd>Glance definitions<cr>", desc = "Glance definitions" },
    { "gR", "<cmd>Glance references<cr>", desc = "Glance references" },
    { "gY", "<cmd>Glance type_definitions<cr>", desc = "Glance type definitions" },
    { "gM", "<cmd>Glance implementations<cr>", desc = "Glance implementations" },
  },
  config = function()
    local glance = require("glance")

    glance.setup({
      height = 18,
      zindex = 45,
      preserve_win_context = true,
      detached = function(winid)
        return vim.api.nvim_win_get_width(winid) < 100
      end,
      preview_win_opts = {
        cursorline = true,
        number = true,
        wrap = true,
      },
      border = {
        enable = false,
        top_char = "―",
        bottom_char = "―",
      },
      list = {
        position = "right",
        width = 0.33,
      },
      theme = {
        enable = true,
        mode = "auto",
      },
    })

    local map = vim.keymap.set
    local opts = { silent = true }
    map("n", "gD", "<cmd>Glance definitions<cr>", vim.tbl_extend("force", opts, { desc = "Glance definitions" }))
    map("n", "gR", "<cmd>Glance references<cr>", vim.tbl_extend("force", opts, { desc = "Glance references" }))
    map("n", "gY", "<cmd>Glance type_definitions<cr>", vim.tbl_extend("force", opts, { desc = "Glance type definitions" }))
    map("n", "gM", "<cmd>Glance implementations<cr>", vim.tbl_extend("force", opts, { desc = "Glance implementations" }))
  end,
}
