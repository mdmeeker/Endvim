return {
    -- Parinfer Rust backend
    {
      "eraserhd/parinfer-rust",
      build = "cargo build --release",
      lazy = true,
    },
    
    -- Neovim parinfer integration
    {
      "harrygallagher4/nvim-parinfer-rust",
      dependencies = { "eraserhd/parinfer-rust" },
      ft = { "fennel", "clojure", "lisp", "racket", "scheme", "janet", "guile" },
      config = function()
        require("parinfer").setup({
          trail_higlight = false,
        })
      end,
    },
  }