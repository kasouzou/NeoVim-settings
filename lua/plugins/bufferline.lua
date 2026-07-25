return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    init = function()
        -- 本家ドキュメントにある、bufferlineの動作に必要なカラー設定っす！
        vim.opt.termguicolors = true

        -- ウィンドウ分割時にタブがそれぞれのウィンドウ上に重複して出るのを防ぐ設定っす！
        vim.opt.winbar = ""     -- ウィンドウごとのバー（winbar）を完全に空っぽにして無効化する設定っす
        vim.opt.showtabline = 2 -- タブバー（tabline）を画面最上部に常に表示（2）させる設定っす
    end,
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",              -- タブにファイル名（バッファ）を表示する設定っす
                always_show_bufferline = true, -- ファイルが1つでも常にタブバーを出す設定っす

                -- 左側のNvimTreeと重ならないように、ツリーの真上を綺麗に避ける設定っす！
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "left",
                        separator = true
                    }
                },
            }
        })
    end
}
