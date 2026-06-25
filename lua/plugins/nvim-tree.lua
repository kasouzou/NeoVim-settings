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
            -- QWERTY配列に戻ったので、これだけで最強の標準移動（hjkl）が自動展開されるっす！
            api.config.mappings.default_on_attach(bufnr)

            -- 2. 【安全な削除】pcall を使って、エラーが出ても無視するようにする
            -- 通常配列に戻したため、大西配列用のキー削除（safe_del）の処理は丸ごと不要になったっす！

            -- 3. 大西配列の「tnsh」を上書き設定
            -- t=左（閉じる）, h=右（開く）
            -- 標準の hjkl（h=左で閉じる, j=下, k=上, l=右で開く）がそのまま動くので、手動上書きも不要っすね！
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
