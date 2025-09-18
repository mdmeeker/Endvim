return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",

            -- Extensions
            { "nvim-telescope/telescope-ui-select.nvim", optional = true },
            { "nvim-telescope/telescope-file-browser.nvim", optional = true },
            { "nvim-telescope/telescope-media-files.nvim", optional = true },
            { "nvim-telescope/telescope-project.nvim", optional = true },
            { "LukasPietzschmann/telescope-tabs.nvim", optional = true },
            { "jvgrootveld/telescope-zoxide", optional = true },

            -- FZF native for performance
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end
            },
        },
        config = function()
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    sorting_strategy = "ascending",
                    layout_strategy = "flex",
                    set_env = { COLORTERM = "truecolor" },
                    dynamic_preview_title = true,
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.8,
                        preview_cutoff = 120,
                    },
                },
                pickers = {
                    oldfiles = {
                        prompt_title = "Recent Files",
                    }
                }
            })

            local function safe_load_extension(name)
                local ok, err = pcall(telescope.load_extension, name)
                if not ok then
                    vim.notify(string.format("Telescope extension '" .. name .. "' not available", vim.log.levels.DEBUG))
                end
                return ok
            end

            safe_load_extension("ui-select")
            safe_load_extension("file_browser")
            safe_load_extension("project")
            safe_load_extension("fzf")
            safe_load_extension("tabs")

            -- Media files
            if vim.fn.executable("ueberzug") == 1 then
                telescope.load_extension("media_files")
            end

            -- Zoxide
            if pcall(require, "telescope._extensions.zoxide") then
                telescope.load_extension("zoxide")
            end

            -- Keybindings
            local builtin = require("telescope.builtin")

            -- LSP mappings
            vim.keymap.set("n", "<leader>ci", builtin.lsp_implementations, { desc = "LSP Find implementations" })
            vim.keymap.set("n", "<leader>cD", builtin.lsp_references, { desc = "LSP Jump to references" })
            vim.keymap.set("n", "<leader>cd", builtin.lsp_definitions, { desc = "LSP Jump to definition" })
            vim.keymap.set("n", "<leader>cj", builtin.lsp_document_symbols, { desc = "LSP Jump to symbol in file" })
            vim.keymap.set("n", "<leader>cJ", builtin.lsp_workspace_symbols, { desc = "LSP Jump to symbol in workspace" })
            vim.keymap.set("n", "<leader>*", builtin.lsp_workspace_symbols, { desc = "LSP Symbols in project" })
            
            -- Diagnostics mappings
            vim.keymap.set("n", "<leader>cx", function()
                builtin.diagnostics({ bufnr = 0 })
            end, { desc = "Local diagnostics" })
            vim.keymap.set("n", "<leader>cX", builtin.diagnostics, { desc = "Project diagnostics" })
            
            -- Common telescope mappings (you might want to add these)
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })

        end
    }
}