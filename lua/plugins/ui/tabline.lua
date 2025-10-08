return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    themable = true,
                    numbers = "none",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    middle_mouse_command = nil,
                    indicator = {
                        icon = "▎",
                        style = "icon",
                    },
                    buffer_close_icon = "󰅖",
                    modified_icon = "●",
                    close_icon = "󰅖",
                    left_trunc_marker = "󰝦",
                    right_trunc_marker = "󰝦",
                    max_name_length = 30,
                    max_prefix_length = 30,
                    tab_size = 21,
                    diagnostics = "nvim_lsp",
                    diagnostics_update_in_insert = false,
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local icon = level:match("error") and "󰅚 " or "󰀪 "
                        return " " .. icon .. count
                    end,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            text_align = "left",
                            separator = true,
                        },
                    },
                    color_icons = true,
                    show_buffer_icons = true,
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    show_duplicate_prefix = true,
                    persist_buffer_sort = true,
                    move_wraps_at_ends = false,
                    separator_style = "thin",
                    enforce_regular_tabs = false,
                    always_show_bufferline = true,
                    sort_by = "insert_after_current",
                },
            })
        end,
    },
}