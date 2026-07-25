-- ~/.config/nvim/lua/config/lazy.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- 【基本設定】
vim.opt.termguicolors = true  -- フルカラーを有効にする
vim.opt.number = true         -- 行番号を表示
vim.opt.relativenumber = true -- 現在行からの相対的な番号を表示
vim.opt.cursorline = true     -- 現在行をハイライト

-- 【キーマップ共通設定】
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 【Esc対策マッピング】
-- QWERTY配列の右手ホームポジションで最もスムーズに抜けられる設定っす！
keymap('i', 'jj', '<Esc>', opts)

-- 【表示・検索系】
vim.opt.ignorecase = true -- 検索時に大文字小文字を区別しない
vim.opt.smartcase = true  -- 検索文字に大文字が含まれていたら区別する
vim.opt.incsearch = true  -- 検索文字を入力してるそばからヒットさせる
vim.opt.wrapscan = true   -- ファイルの最後まで検索したら最初に戻る
vim.opt.hlsearch = true   -- 検索結果をハイライトする（消したい時は :noh）
-- vim.opt.guicursor = "n-i:ver25" -- ノーマルモードでのカーソルを補足して文字のどちら側にいるのかわかるようにする。

-- 【編集系】
vim.opt.expandtab = true          -- タブ入力を空白に変換
vim.opt.shiftwidth = 4            -- 自動インデントの幅
vim.opt.tabstop = 4               -- タブが占める幅
vim.opt.smartindent = true        -- 改行時に自動でインデントを入れる
vim.opt.clipboard = "unnamedplus" -- クリップボードをOS（Mac/Ubuntu）と共有
-- ビジュアルモード（選択中）で Tab を押すと右へ、S-Tab で左へ（選択範囲を維持）
keymap('v', '<Tab>', '>gv', opts)
keymap('v', '<S-Tab>', '<gv', opts)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
})

-- set transparent background for floats/terminal buffers
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Terminal", { bg = "NONE" })


-- 【VS Code風ファイルタブ切り替え】
keymap('n', '<S-h>', ':bprevious<CR>', opts) -- 左のファイルタブへ移動
keymap('n', '<S-l>', ':bnext<CR>', opts)     -- 右のファイルタブへ移動
keymap('n', 'tc', function()
    local current_buf = vim.api.nvim_get_current_buf()

    -- NvimTreeの上で誤爆したときは何もしないガードっす
    if vim.bo[current_buf].filetype == "NvimTree" then
        return
    end

    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    if #buffers <= 1 then
        vim.cmd("enew")
        vim.cmd("bd " .. current_buf)
    else
        vim.cmd("bnext")
        vim.cmd("bd " .. current_buf)
    end
end, opts) -- 現在のファイルタブを閉じる

----------------------------------------------------
-- 【NEW】ファイルタブの並び順を入れ替える設定っす！
----------------------------------------------------
-- Alt + h で、今見ているタブを「左」に移動させるっす
keymap('n', '<A-h>', ':BufferLineMovePrev<CR>', opts)
-- Alt + l で、今見ているタブを「右」に移動させるっす
keymap('n', '<A-l>', ':BufferLineMoveNext<CR>', opts)

-- テキスト変更時やインサートモードを抜けた時に自動保存

-- 【自動保存 ＆ LilyPondコンパイルの一体化設定】
-- LilyPondは楽譜を書くためのフリーソフトです
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    callback = function()
        -- 1. 変更があり、かつ通常のファイルバッファの場合のみ保存を実行
        if vim.bo.modified and vim.bo.buftype == "" then
            vim.cmd("write")

            -- 2. もし保存したファイルがLilyPond(.ly)だった場合、その直後に非同期コンパイルを実行
            if vim.fn.expand("%:e") == "ly" then
                local file = vim.fn.expand("%")
                vim.fn.jobstart({ "lilypond", file }, {
                    on_exit = function(_, code)
                        if code == 0 then
                            vim.notify("LilyPond: コンパイル成功！", vim.log.levels.INFO)
                        else
                            vim.notify("LilyPond: エラーが発生しました", vim.log.levels.WARN)
                        end
                    end
                })
            end
        end
    end,
})
