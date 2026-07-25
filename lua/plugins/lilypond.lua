return {
    'martineausimon/nvim-lilypond-suite',
    ft = 'lilypond', -- .lyファイルを開いた時だけ超軽量に読み込む
    opts = {
        lilypond = {
            mappings = {
                compile = "<F5>",  -- F5キーで手動コンパイルも可能
                open_pdf = "<F6>", -- F6キーでPDFビューアを開く設定
                player = "<F3>",   -- F3キーでMIDI再生（必要なら）
            },
            options = {
                errors = {
                    diagnostics = true,    -- ★これ！LSPのようにエラー箇所に赤波線を出します
                    quickfix = "external", -- エラーリストをQuickfixに流し込みます
                },
            },
        },
    }
}
