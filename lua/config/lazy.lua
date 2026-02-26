-- ~/.config/nvim/lua/config/lazy.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 【基本設定】
vim.opt.termguicolors = true   -- フルカラーを有効にする
vim.opt.number = true         -- 行番号を表示
vim.opt.cursorline = true     -- 現在行をハイライト

-- 【大西配列・Esc対策マッピング】
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 1. ii で Esc (左手ホーム)
keymap('i', 'ii', '<Esc>', opts)

-- 2. tnsh で hjkl 移動 (右手ホーム)
keymap('n', 't', 'h', opts) -- 左
keymap('n', 'n', 'j', opts) -- 下
keymap('n', 's', 'k', opts) -- 上
keymap('n', 'h', 'l', opts) -- 右

-- 3. 機能を逃がす (k, j, l)
keymap('n', 'k', 't', opts) -- till
keymap('n', 'j', 'n', opts) -- next (検索)
keymap('n', 'l', 's', opts) -- substitute

-- 4. 視覚モードでも移動を共通化
keymap('v', 't', 'h', opts)
keymap('v', 'n', 'j', opts)
keymap('v', 's', 'k', opts)
keymap('v', 'h', 'l', opts)

-- 【表示・検索系】
vim.opt.ignorecase = true  -- 検索時に大文字小文字を区別しない
vim.opt.smartcase = true   -- 検索文字に大文字が含まれていたら区別する
vim.opt.incsearch = true   -- 検索文字を入力してるそばからヒットさせる
vim.opt.wrapscan = true    -- ファイルの最後まで検索したら最初に戻る
vim.opt.hlsearch = true    -- 検索結果をハイライトする（消したい時は :noh）
vim.opt.guicursor = "n-i:ver25" -- ノーマルモードでのカーソルを補足して文字のどちら側にいるのかわかるようにする。

-- 【編集系】
vim.opt.expandtab = true   -- タブ入力を空白に変換
vim.opt.shiftwidth = 4     -- 自動インデントの幅
vim.opt.tabstop = 1        -- タブが占める幅
vim.opt.smartindent = true -- 改行時に自動でインデントを入れる
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
