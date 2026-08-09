vim.cmd[[set completeopt=menuone,noselect,fuzzy complete=.,w,b,o tabstop=2 shiftwidth=2 softtabstop=2 cmdheight=0 signcolumn=no guicursor=a:block nowrap noshowmode noswapfile nobackup nowritebackup smartcase ignorecase smartindent autoindent expandtab showmatch autocomplete]]
vim.g.mapleader = ' '
vim.g.vimtex_view_method = 'zathura'
vim.keymap.set('n', 'gn', ':bn<CR>')
vim.keymap.set('n', 'gp', ':bp<CR>')
vim.keymap.set('n', 'go', ':lua vim.lsp.buf.workspace_symbol()<CR>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('c', '<C-j>', '<Down>')
vim.keymap.set('c', '<C-k>', '<Up>')
vim.keymap.set('c', '<C-h>', '<Left>')
vim.keymap.set('c', '<C-l>', '<Right>')
vim.keymap.set('n', '<leader>l', ':cn<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>h',  ':cp<CR>', {silent = true, noremap = true})
vim.keymap.set("n", "q", "<nop>", {})
vim.keymap.set({'n', 'v', 'i', 'c' }, 'ş', '<Esc>')
vim.keymap.set('t', 'ş', '<C-\\><C-N>')
vim.diagnostic.config({ virtual_text = true })
vim.cmd('au TextYankPost * silent! lua vim.hl.on_yank {higroup="IncSearch", timeout=500}')
vim.pack.add({"https://codeberg.org/andyg/leap.nvim", "https://github.com/lervag/vimtex", "https://github.com/neovim/nvim-lspconfig"})
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n',               'S', '<Plug>(leap-from-window)')
vim.lsp.inlay_hint.enable(true)
vim.lsp.enable({'pylsp', 'texlab', 'clangd'})
vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_hl(0, 'Normal', {bg='#000000'})
vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter" }, {
  pattern = "*",
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
    for _, line in ipairs(lines) do
      local make_cmd = line:match("cc:%s*(.+)")
      if make_cmd then
        vim.bo.makeprg = vim.trim(make_cmd)
      end
      local run_cmd = line:match("rc:%s*(.+)")
      if run_cmd then
        vim.b.rc = vim.trim(run_cmd)
      end
    end
  end,
})
local function build_and_run()
  vim.cmd("write")
  vim.cmd("make")
  local qf_list = vim.fn.getqflist()
  local has_errors = false
  for _, item in ipairs(qf_list) do
    if item.valid == 1 and item.type == 'E' then
      has_errors = true
      break
    end
  end
  if has_errors then
    vim.api.nvim_err_writeln("Build failed! Check the quickfix list for errors.")
    return
  end
  local run_command = vim.b.rc
  if not run_command or run_command == "" then
    local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
    for _, line in ipairs(lines) do
      local match = line:match("rc:%s*(.+)")
      if match then
        run_command = vim.trim(match)
        vim.b.rc = run_command
        break
      end
    end
  end
  local ui_segments = vim.api.nvim_list_uis()
  if #ui_segments == 0 then return end
  local stats = ui_segments[1]
  local width = math.floor(stats.width * 0.8)
  local height = math.floor(stats.height * 0.6)
  local row = math.floor((stats.height - height) / 2)
  local col = math.floor((stats.width - width) / 2)
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, { relative = "editor", width = width, height = height, row = row, col = col, style = "minimal", border = "rounded", title = " Program Output (Press ESC to close) ", title_pos = "center" })
  vim.fn.termopen(run_command)
  vim.cmd("startinsert")
  vim.keymap.set({ "n", "t" }, "<Esc>", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, silent = true, desc = "Close output window" })
end
vim.keymap.set("n", "<leader>r", build_and_run, { desc = "Build and run in floating window" })
vim.keymap.set("n", "<C-c>", "<cmd>mak<CR>", { desc = "Build" })
