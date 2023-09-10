require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    ee500 = "~/college/ee500/notes",
                },
            },
        },
        ["core.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
    },
})
