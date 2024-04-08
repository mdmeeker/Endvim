return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "c",
        "cmake",
        "cpp",
        "cuda",
        "fortran",
        "gitcommit",
        "gitignore",
        "go",
        "haskell",
        "julia",
        "latex",
        "llvm",
        "lua",
        "make",
        "markdown",
        "meson",
        "ninja",
        "nix",
        "ocaml",
        "org",
        "python",
        "rust",
        "sql",
      })
    end,
  },
}
