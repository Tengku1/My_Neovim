return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {
				week_header = {
					enable = true,
				},
				center = {
					{
						icon = "  ",
						desc = "New File",
						key = "n",
						action = "enew",
					},
					{
						icon = "  ",
						desc = "Recent Projects",
						key = "p",
						action = "Telescope project",
					},
					{
						icon = "  ",
						desc = "Recent Files",
						key = "r",
						action = "Telescope oldfiles",
					},
					{
						icon = "  ",
						desc = "Find File",
						key = "f",
						action = "Telescope find_files",
					},
					{
						icon = "  ",
						desc = "Find Text",
						key = "g",
						action = "Telescope live_grep",
					},
					{
						icon = "⚙️  ",
						desc = "Settings",
						key = "s",
						action = "edit ~/.config/nvim/init.lua",
					},
					{
						icon = "󰒲 ", -- Ikon baru (gear 3, atau kamu bisa pilih lainnya)
						desc = "Lazy",
						key = "l",
						action = ":Lazy",
					},
					{
						icon = " ", -- Ikon untuk tools/packages
						desc = "Mason",
						key = "m",
						action = ":Mason",
					},
					{
						icon = "  ",
						desc = "Quit",
						key = "q",
						action = "qa",
					},
				},
			},
		})
	end,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-telescope/telescope.nvim" },
		{
			"nvim-telescope/telescope-project.nvim",
			config = function()
				require("telescope").load_extension("project")
			end,
		},
	},
}
