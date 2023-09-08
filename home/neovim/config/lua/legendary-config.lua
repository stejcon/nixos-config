require('legendary').setup({
    keymaps = {
        { "<leader>do", { n = vim.diagnostic.open_float }, description = "Diagnostic: Open Float" },
        {
            "<leader>dp",
            { n = vim.diagnostic.goto_prev },
            description = "Diagnostic: Go To Previous Issue",
        },
        { "<leader>dn", { n = vim.diagnostic.goto_next },  description = "Diagnostic: Go To Next Issue" },
        { "<leader>G",  { n = "<cmd>G<cr>" },              description = "Git: Open Git View" },
        { "<leader>Gb", { n = "<cmd>G blame<cr>" },        description = "Git: Git Blame" },
        { "<leader>Gd", { n = "<cmd>Gvdiffsplit!<cr>" },   description = "Git: Git Diff View" },
        { "<C-h>",      { n = "<C-w>h" },                  description = "Window: Focus Left" },
        { "<C-j>",      { n = "<C-w>j" },                  description = "Window: Focus Down" },
        { "<C-k>",      { n = "<C-w>k" },                  description = "Window: Focus Up" },
        { "<C-l>",      { n = "<C-w>l" },                  description = "Window: Focus Right" },
        { "-",          { n = require("oil").open },       description = "Oil: Open parent directory" },
    },
})
