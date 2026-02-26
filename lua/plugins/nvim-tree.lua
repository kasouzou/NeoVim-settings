return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      api.config.mappings.default_on_attach(bufnr)

      -- "s" is mapped to system_open by default; remap to move up.
      vim.keymap.del("n", "s", { buffer = bufnr })
      vim.keymap.set("n", "s", "k", { buffer = bufnr, noremap = true, silent = true })
    end

    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      on_attach = on_attach,
    })

    -- Toggle nvim-tree with <leader>e
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
  end,
}
