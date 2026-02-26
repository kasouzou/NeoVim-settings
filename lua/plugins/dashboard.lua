return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    -- お洒落なグラデーションカラーの定義
    local colors = {
      '#89ddff', -- Cyan
      '#82aaff', -- Light Blue
      '#bb80ff', -- Purple
      '#f07178', -- Red/Pink
      '#ffcb6b', -- Orange
      '#c3e88d', -- Green
    }

    for i, color in ipairs(colors) do
      vim.api.nvim_set_hl(0, 'DashboardHeader' .. i, { fg = color })
    end

    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = {
          [[██╗  ██╗ █████╗ ███████╗ ██████╗ ██╗   ██╗███████╗ ██████╗ ██╗   ██╗]],
          [[██║ ██╔╝██╔══██╗██╔════╝██╔═══██╗██║   ██║╚══███╔╝██╔═══██╗██║   ██║]],
          [[█████╔╝ ███████║███████╗██║   ██║██║   ██║  ███╔╝ ██║   ██║██║   ██║]],
          [[██╔═██╗ ██╔══██║╚════██║██║   ██║██║   ██║ ███╔╝  ██║   ██║██║   ██║]],
          [[██║  ██╗██║  ██║███████║╚██████╔╝╚██████╔╝███████╗╚██████╔╝╚██████╔╝]],
          [[╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝]],
        },
        -- ヘッダーの色指定（1行目から順に適用）
        header_hl = {
          "DashboardHeader1",
          "DashboardHeader2",
          "DashboardHeader3",
          "DashboardHeader4",
          "DashboardHeader5",
          "DashboardHeader6",
        },
        shortcut = {
          { icon = '󰊄 ', icon_hl = 'DashboardHeader1', desc = 'Update', group = 'DashboardHeader1', action = 'Lazy update', key = 'u' },
          { icon = '󰈞 ', icon_hl = 'DashboardHeader2', desc = 'Files', group = 'DashboardHeader2', action = 'Telescope find_files', key = 'f' },
          { icon = '󰈚 ', icon_hl = 'DashboardHeader3', desc = 'Recent', group = 'DashboardHeader3', action = 'Telescope oldfiles', key = 'r' },
          { icon = ' ', icon_hl = 'DashboardHeader4', desc = 'Config', group = 'DashboardHeader4', action = 'edit $MYVIMRC', key = 'c' },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
