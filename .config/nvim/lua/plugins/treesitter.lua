return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "c", "c_sharp", "cpp",
      "dockerfile",
      "go",
      "ini",
      "json", "json5",
      "lua",
      "python",
      "sql",
      "toml", "tmux",
      "vim", "vimdoc",
      "yaml",
    },
    auto_install = true,
    highlight = {
      enable = true,
    }
  }
}
