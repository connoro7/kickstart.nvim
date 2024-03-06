vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local fugitive_group = vim.api.nvim_create_augroup("fugitive_group", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
  group = fugitive_group,
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "fugitive" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>p", function()
      vim.cmd.Git('push')
    end, opts)

    -- merge always
    vim.keymap.set("n", "<leader>P", function()
      vim.cmd.Git({ 'pull', '--merge' })
    end, opts)

    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
    -- needed if i did not set the branch up correctly
    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
    -- remap <C-w>w to sx
    vim.keymap.set("n", "ss", "<C-w>w", opts)
    vim.keymap.set("n", "sx", "<C-w>q", opts)
  end,

})


return {
  {
    'tpope/vim-fugitive',
    config = function()
    end
  },
  {
    'tpope/vim-rhubarb',
    config = function()
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
    -- config = function()
    --   require('gitsigns').setup()
    -- end
  },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
      require('git-conflict').setup {
        default_mappings = false,    -- disable the default mappings
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        list_opener = 'copen',       -- command or function to open the conflicts list
        highlights = {               -- They must have background color, otherwise the default color will be used
          incoming = 'DiffAdd',
          current = 'DiffText',
        },

        signs = {
          use_decoration_api = true,
          signs = {
            top_delete = { hl = 'GitConflictDeleteTop' },
            top_add = { hl = 'GitConflictAddTop' },
            middle_delete = { hl = 'GitConflictDeleteMiddle' },
            middle_add = { hl = 'GitConflictAddMiddle' },
            bottom_delete = { hl = 'GitConflictDeleteBottom' },
            bottom_add = { hl = 'GitConflictAddBottom' },
          },
        },
        vim.keymap.set('n', 'cr', '<Plug>(git-conflict-ours)', { desc = "[c]hoose [r]ed" }),
        vim.keymap.set('n', 'cb', '<Plug>(git-conflict-theirs)', { desc = "[c]hoose [b]lue" }),
        vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)', { desc = "[c]hoose [b]oth" }),
        vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)', { desc = "[c]hoose [n]one" }),
        vim.keymap.set('n', 'gp', '<Plug>(git-conflict-prev-conflict)', { desc = "[g]oto prev" }),
        vim.keymap.set('n', 'gn', '<Plug>(git-conflict-next-conflict)', { desc = "[g]oto next" }),
        -- Default:
        -- vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)'),
        -- vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)'),
        -- vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)'),
        -- vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)'),
        -- vim.keymap.set('n', 'gp', '<Plug>(git-conflict-prev-conflict)'),
        -- vim.keymap.set('n', 'gn', '<Plug>(git-conflict-next-conflict)'),

      }
    end
  }
}
