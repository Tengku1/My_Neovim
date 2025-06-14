return {
  'ojroques/nvim-bufdel',
  config = function()
    -- Set default options (optional)
    vim.g.bufdel_preserve_window_layout = 1
    vim.g.bufdel_show_quickfix = 0

    -- Keymap to delete current buffer safely
    vim.keymap.set('n', '<leader>q', ':BufDel<CR>', { desc = 'BufDel current buffer safely' })
    vim.keymap.set('n', '<leader>Q', ':BufDelAll<CR>', { desc = 'Close All Buffer' })
  end,
}
