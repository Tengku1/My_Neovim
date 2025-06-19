return {
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				size = vim.o.columns * 0.4,
				direction = "vertical",
				hide_numbers = true,
				start_in_insert = true,
				auto_scroll = true,
				persist_mode = true, -- Keep terminal open after command completes
				close_on_exit = false, -- Don't close when command finishes
			})
			local terminal = require("toggleterm.terminal").Terminal
			lazygit = terminal:new({
				cmd = "lazygit",
				hidden = true,
				direction = "float",
				float_opts = {
					border = "double",
				},
			})
			lazydocker = terminal:new({
				cmd = "lazydocker",
				hidden = true,
				direction = "float",
				float_opts = {
					border = "double",
				},
			})

			vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>:ToggleTerm<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap(
				"n",
				"<leader>tg",
				"<cmd>lua lazygit:toggle()<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>td",
				"<cmd>lua lazydocker:toggle()<CR>",
				{ noremap = true, silent = true }
			)

			local Terminal = require("toggleterm.terminal").Terminal

			local float_config = {
				direction = "float",
				float_opts = {
					border = "rounded",
					width = math.min(100, vim.o.columns - 10),
					height = math.min(30, vim.o.lines - 10),
					winblend = 15,
					title = "Maven Test Results (Fish)",
					title_pos = "center",
				},
				hidden = true,
				shell = "fish",
			}

			local test_terminal = Terminal:new(float_config)

			-- Function to create and manage temporary files safely
			local function create_temp_script(content)
				local temp_dir = vim.fn.expand("~/.cache/nvim/tmp/")
				vim.fn.mkdir(temp_dir, "p") -- Ensure directory exists
				local temp_path = temp_dir .. "maven_test_" .. os.time() .. ".fish"
				local file = io.open(temp_path, "w")
				file:write(content)
				file:close()
				return temp_path
			end

			local function run_maven_test(command)
				if not test_terminal:is_open() then
					test_terminal:toggle()
				end

				-- Create Fish script with proper shebang
				local script_content = string.format(
					[[
					#!/usr/bin/env fish

					function cleanup
					  rm -f "%s"
					end

					begin
					  clear
					  echo "RUNNING: %s\n"
					  %s
					  set -g last_status $status
					  echo "\n\nCOMMAND FINISHED (status: $last_status)"
					  echo "Press ENTER to close terminal"
					  read -P ""
					  cleanup
					end
					]],
					"TEMP_FILE_PLACEHOLDER",
					command,
					command
				)

				local script_path = create_temp_script(script_content)
				script_content = script_content:gsub("TEMP_FILE_PLACEHOLDER", script_path)

				-- Write the final version with actual path
				local file = io.open(script_path, "w")
				file:write(script_content)
				file:close()

				-- Make script executable
				vim.loop.spawn("chmod", { args = { "+x", script_path } }, function() end)

				test_terminal:send(script_path, false)
				test_terminal:focus()
			end

			-- View last results
			local function show_last_results()
				if not test_terminal:is_open() then
					test_terminal:toggle()
				end
				test_terminal:send('clear; echo "LAST TEST RESULTS:\n"; echo "$last_output"', false)
				test_terminal:focus()
			end

			-- -- Filetype-specific setup
			-- vim.api.nvim_create_autocmd('FileType', {
			--   pattern = { 'java', 'kotlin' },
			--   callback = function()
			--     -- Test commands
			--     vim.keymap.set('n', '<leader>ta', function()
			--       run_maven_test 'mvn test'
			--     end, { buffer = true, desc = 'Run all tests' })
			--
			--     vim.keymap.set('n', '<leader>tf', function()
			--       run_maven_test('mvn test -Dtest=' .. vim.fn.expand '%:t:r')
			--     end, { buffer = true, desc = 'Run current file tests' })
			--
			--     vim.keymap.set('n', '<leader>tm', function()
			--       run_maven_test('mvn test -Dtest=' .. vim.fn.expand '%:t:r' .. '#' .. vim.fn.expand '<cword>')
			--     end, { buffer = true, desc = 'Run current test method' })
			--
			--     -- View last results
			--     vim.keymap.set('n', '<leader>to', show_last_results, { buffer = true, desc = 'Show last test results' })
			--   end,
			-- })
		end,
	},
}
