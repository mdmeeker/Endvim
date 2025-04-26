return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cond = not vim.g.vscode,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 1.0
    end
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    cond = not vim.g.vscode,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("git_worktree")
    end,
  },
}
