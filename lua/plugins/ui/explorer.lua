return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "DaikyXendo/nvim-material-icon" },
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        keys = {
            { "<leader>ft", ":NvimTreeToggle<CR>", desc = "Toggle nvim-tree sidebar" },
            { "<leader>fT", ":NvimTreeFocus<CR>", desc = "Focus nvim-tree sidebar" },
        },
        config = function()
            require("nvim-tree").setup({
                disable_netrw = true,
                hijack_netrw = true,
                filters = {
                    dotfiles = false,
                    git_ignored = false,
                },
                git = {
                    enable = true,
                },
                actions = {
                    open_file = {
                        quit_on_open = false,
                    },
                },
            })

            vim.api.nvim_create_autocmd("BufEnter", {
                nested = true,
                callback = function()
                    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
                        vim.cmd("quit")
                    end
                end,
            })
        end
    },
}