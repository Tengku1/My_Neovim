return {
  {
    "karb94/neoscroll.nvim",
    config = function()
      local neoscroll = require("neoscroll")

      neoscroll.setup({
        easing = "quadratic",
      })

      local keymap = {
        -- Use the "sine" easing function
        ["<C-u>"] = function()
          neoscroll.ctrl_u({ duration = 250, easing = "sine" })
        end,
        ["<C-d>"] = function()
          neoscroll.ctrl_d({ duration = 250, easing = "sine" })
        end,
        -- Use the "circular" easing function
        ["<C-b>"] = function()
          neoscroll.ctrl_b({ duration = 300, easing = "circular" })
        end,
        ["<C-f>"] = function()
          neoscroll.ctrl_f({ duration = 300, easing = "circular" })
        end,
        -- When no value is passed the `easing` option supplied in `setup()` is used
        ["<C-y>"] = function()
          neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
        end,
        ["<C-e>"] = function()
          neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
        end,
      }

      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },
}
