# Android/Jetpack Compose Neovim Setup Plan - STATUS: COMPLETED

The following components have been configured:

## 1. LSP (Language Server Protocol)
- [x] **Kotlin**: `kotlin_language_server` added to Mason and `nvim-lspconfig`.
- [x] **Gradle**: `gradle_ls` added to Mason and `nvim-lspconfig`.

## 2. Syntax Highlighting
- [x] **Treesitter**: `kotlin` parser added to `ensure_installed`.

## 3. Formatting & Linting
- [x] **conform.nvim**: Added with `ktlint` for Kotlin files. Format on save is enabled. Keymap: `<leader>f`.

## 4. Completion & Snippets
- [x] **friendly-snippets**: Added to provide Kotlin and other language snippets.
- [x] **LuaSnip**: Configured to load VSCode-style snippets.

---

### Instructions for User:
1. **Restart Neovim**: After these changes, restart Neovim to let `lazy.nvim` install the new plugins and Mason install the LSPs.
2. **Mason Installation**: If the servers are not automatically installed, run `:Mason` and manually install `kotlin-language-server`, `gradle-language-server`, and `ktlint`.
3. **Android SDK**: Ensure that the `ANDROID_HOME` environment variable is set in your shell and that Java is installed on your system.
4. **Project Setup**: When you open a Kotlin file in an Android project, the `kotlin_language_server` should start automatically.
5. **Formatting**: You can manually format with `<leader>f` or it will happen automatically on save.

### Limitations:
- **Preview**: Neovim does not support Jetpack Compose's `@Preview` natively. You will still need Android Studio for visual layout previews.
- **Resource Management**: Editing `xml` resources and `strings.xml` is possible but won't have the same level of tooling as Android Studio.
