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

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- 1. まずはデフォルト設定を読み込む
      api.config.mappings.default_on_attach(bufnr)

      -- 2. 【安全な削除】pcall を使って、エラーが出ても無視するようにする
      local function safe_del(key)
        pcall(vim.keymap.del, "n", key, { buffer = bufnr })
      end

      safe_del("s")
      safe_del("n")
      safe_del("t")
      safe_del("h")

      -- 3. 大西配列の「tnsh」を上書き設定
      vim.keymap.set("n", "n", "k", opts("Up"))   -- n = 上
      vim.keymap.set("n", "s", "j", opts("Down")) -- s = 下

      -- t=左（閉じる）, h=右（開く）
      vim.keymap.set("n", "t", api.node.navigate.parent_close, opts("Close Directory"))
      vim.keymap.set("n", "h", api.node.open.edit,            opts("Open"))
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
        dotfiles = false,
      },
      git = {
        enable = true,
        ignore = false,
      },
      on_attach = on_attach,
    })

    -- Toggle nvim-tree with <leader>e
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
  end,
}
