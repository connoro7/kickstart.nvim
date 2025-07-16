--[[
=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

If you don't know anything about Lua, I recommend taking some time to read through
a guide. One possible example:
- https://learnxinyminutes.com/docs/lua/

And then you can explore or search through `:help lua-guide`
- https://neovim.io/doc/user/lua-guide.html

-- Install `lazy.nvim` plugin manager:
-- https://github.com/folke/lazy.nvim
-- `:help lazy.nvim.txt` for more info
--]]

require("set")
require("remap")
require("cmd")
require("autocmd")

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Silence these warnings
local notify_original = vim.notify
--- @diagnostic disable-next-line
vim.notify = function(msg, ...) -- override notify
  if
      msg
      and (
        msg:match 'position_encoding param is required'
        or msg:match 'Defaulting to position encoding of the first client'
        or msg:match 'multiple different client offset_encodings'
        or msg:match 'vim.tbl_islist is deprecated'
      )
  then
    return
  end
  return notify_original(msg, ...)
end

require('lazy').setup('plugins')

function R(name)
  require("plenary.reload").reload_module(name)
end

-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.diagnostic.config({ jump = { float = true } }) -- See: https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.Opts.jump, and https://github.com/neovim/neovim/pull/29067
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end,
  { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float,
  { desc = 'Open [v]im [d]iagnostic message' })
vim.keymap.set('n', '<leader>vq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    file_ignore_patterns = {
      "DC/sc*",
      "DC/net*",
      "poetry.lock*",
      "ui-paths/migration*",
      "*pycache*",
      "*.sql*",
      "*.qcow2",
      "*.iso",
      "*.img",
      "*.vmdk",
      "*.vdi",
      "*.vhd",
      "*.vhdx",
    }
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[s]earch [/] in open files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[s]earch [s]elect telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'search [g]it [f]iles' })
-- vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, { desc = 'gre[C-p] git files'})
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[s]earch [f]iles' })
vim.keymap.set('n', '<leader>pf', require('telescope.builtin').find_files, { desc = 'gre[p] [f]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch current [w]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[s]earch by [g]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[s]earch by grep on [G]it root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[s]earch [r]esume' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[s]earch [c]ommands ' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[s]earch [k]eymaps' })
vim.keymap.set('n', '<leader>si', require('telescope.builtin').lsp_implementations,
  { desc = 'tele[s]cope [i]mplementations' })
vim.keymap.set('n', '<leader>ps', function()
  require('telescope.builtin').grep_string({
    search = vim.fn.input("Grep > ")
  })
end)


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  ---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'json', 'markdown', 'query', 'regex', 'yaml' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    autotag = {
      enable = true,
      filetypes = { "html", "xml" }
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<S-space>',
        node_incremental = '<S-space>',
        scope_incremental = '<S-s>',
        node_decremental = '<C-S-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ['],'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_next_end = {
          [']>'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_end = {
          ['[<'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>ai'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>Ai'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  vim.diagnostic.config({ virtual_text = true })
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  local vmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('v', keys, func, { buffer = bufnr, desc = desc })
  end
  local imap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc })
  end


  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>vca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-K>', vim.lsp.buf.signature_help, 'Signature Documentation')
  -- imap('<C-K>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
  nmap('<leader>cwf', function()
    -- [[BROKEN]]
    local workspaceFolders = vim.lsp.buf.list_workspace_folders()
    -- Check if workspaceFolders is not nil before inspecting
    if workspaceFolders then
      local workspaceFoldersStr = vim.inspect(workspaceFolders)
      workspaceFoldersStr = workspaceFoldersStr:gsub('([%^%$%(%)%%%.%[%]*%+%-%?])', '%%%1')
      vim.cmd("let g:copilot_workspace_folders = " .. workspaceFoldersStr)
    else
      print("No workspace folders found.")
    end
  end, 'Copilot [W]orkspace [F]older')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  -- Disable hover in favor of Pyright
  -- if client.name == "ruff_lsp" then
  --   client.server_capabilities.hoverProvider = false
  -- end
end

-- document existing key chains
local wk = require('which-key')
wk.add({
  { "<leader>a",  group = "[A]vante" },
  { "<leader>a_", hidden = true },
  { "<leader>b",  group = "[B]uffer" },
  { "<leader>b_", hidden = true },
  { "<leader>c",  group = "[C]ode, [C]opilot-[C]hat" },
  { "<leader>c_", hidden = true },
  { "<leader>d",  group = "[D]ocument" },
  { "<leader>d_", hidden = true },
  -- e UNUSED
  -- f UNUSE
  { "<leader>g",  group = "[G]it" },
  { "<leader>g_", hidden = true },
  { "<leader>h",  group = "Git [Hunk]" },
  { "<leader>h_", hidden = true },
  { "<leader>i",  group = "[I]nsert" },
  { "<leader>i_", hidden = true },
  -- j
  -- k
  { "<leader>l",  group = "[L]sp" },
  { "<leader>l_", hidden = true },
  { "<leader>m",  group = "[M]essages" },
  { "<leader>m_", hidden = true },
  -- n UNUSED
  { "<leader>O",  group = "[O]pen" },
  { "<leader>O_", hidden = true },
  -- p MISC
  { "<leader>q",  group = "[Q]uickfix" },
  { "<leader>q_", hidden = true },
  { "<leader>r",  group = "[R]ename" },
  { "<leader>r_", hidden = true },
  { "<leader>s",  group = "[S]earch, [S]lide windows" },
  { "<leader>s_", hidden = true },
  { "<leader>t",  group = "[T]oggle, [T]elescope, [T]reesitter" },
  { "<leader>t_", hidden = true },
  { "<leader>u",  desc = "[U]ndotree" },
  { "<leader>u_", hidden = true },
  { "<leader>v",  group = "[V]isual" },
  { "<leader>v_", hidden = true },
  { "<leader>w",  group = "[W]orkspace, [W]indow" },
  { "<leader>w_", hidden = true },
  { "<leader>X",  group = "[X] Execute" },
  { "<leader>X_", hidden = true },
  { "<leader>y",  group = "[Y]ank" },
  { "<leader>y_", hidden = false },
  { "<leader>Y",  group = "[Y]ank" },
  { "<leader>Y_", hidden = false },
  -- z UNUSED (<leader>zf currently for folding)
})
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
wk.add({
  { "<leader>",  group = "VISUAL <leader>",   mode = "v" },
  { "<leader>h", desc = "Git [H]unk",         mode = "v" },
  { "<leader>a", desc = "[A]fter selection",  mode = "v" },
  { "<leader>b", desc = "[B]efore selection", mode = "v" },
}

)
wk.add({
  { "T", group = "Todo" }, -- group
  {
    mode = { "n", "v" },
    group = "Todo",
    { "Tt", "<cmd>Checkmate toggle<CR>",                 desc = "[T]odo: Toggle item", },
    { "Tc", "<cmd>Checkmate check<CR>",                  desc = "[T]odo: Set item as checked (done)", },
    { "Tu", "<cmd>Checkmate uncheck<CR>",                desc = "[T]odo: Set item as unchecked (not done)", },
    { "Tn", "<cmd>Checkmate create<CR>",                 desc = "[T]odo: Create item", },
    { "TR", "<cmd>Checkmate remove_all_metadata<CR>",    desc = "[T]odo: Remove all metadata from a item", },
    { "Ta", "<cmd>Checkmate archive<CR>",                desc = "[T]odo: Archive checked/completed items (move to bottom section)", },
    { "Tv", "<cmd>Checkmate metadata select_value<CR>",  desc = "[T]odo: Update the value of a metadata tag under the cursor", },
    { "T]", "<cmd>Checkmate metadata jump_next<CR>",     desc = "[T]odo: Move cursor to next metadata tag", },
    { "T[", "<cmd>Checkmate metadata jump_previous<CR>", desc = "[T]odo: Move cursor to previous metadata tag", },
    { "Tp", "<cmd>Checkmate metadata priority<CR>",      desc = "[T]odo: Set or update the priority of a item", },
    { "Ts", "<cmd>Checkmate metadata started<CR>",       desc = "[T]odo: Set or update the started date/time of a item", },
    { "Td", "<cmd>Checkmate metadata done<CR>",          desc = "[T]odo: Set or update the done date/time of a item", },
  }
})

local function safe_require(name)
  local ok, mod = pcall(require, name)
  if not ok then
    vim.notify("Failed to load " .. name)
    return nil
  end
  return mod
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
-- require('mason').setup()
local mason = safe_require('mason')
if not mason then
  vim.notify("Cannot set up mason")
  return
else
  mason.setup()
end

-- require('mason-lspconfig').setup()
local mason_lspconfig = safe_require('mason-lspconfig')
if not mason_lspconfig then
  vim.notify("Cannot set up mason-lspconfig")
  return
else
  mason_lspconfig.setup()
end

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
---@class lsp.ClientCapabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())


--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  -- AVAILABLE SERVERS & THEIR NAMES: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
  bashls = {},
  clangd = {
    cmd = {
      "clangd",
      -- "--all-scopes-completion", -- If set to true, code completion will include index symbols that are not defined in the scopes (e.g. namespaces) visible from the code completion point. Such completions can insert scope qualifiers.
      -- "--suggest-missing-includes",
      "--background-index",
      -- "--pch-storage=disk",
      -- "--cross-file-rename",
      -- "--log=info",
      "--completion-style=detailed", -- [detailed | bundled] If set to detailed, code completion will include detailed information about the completion item.
      "--enable-config",             -- clangd 11+ supports reading from .clangd configuration file
      -- "--clang-tidy", -- enable clang-tidy diagnostics
      "--offset-encoding=utf-16",
      -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
      -- "--fallback-style=Google",
      -- "--header-insertion=never",
      -- "--query-driver=/usr/bin/g++",
      "--query-driver=/usr/bin/c++",
      "--compile-commands-dir=" .. vim.fn.getcwd(),
      -- "--compile-commands-dir=.",
      -- "--compile-commands-dir=" .. vim.fn.expand("%:p:h"),
    },
  },
  rust_analyzer = {
    -- settings = { -- see: https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
    --   ['rust-analyzer'] = {
    --     diagnostics = {
    --       enable = false,
    --       disabled = { "unresolved-proc-macro" },
    --     },
    --   }
    -- }
  },
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  -- tsserver = {},
  -- gopls = {
  --   hints = {
  --     assignVariableTypes = true,
  --     compositeLiteralFields = true,
  --     compositeLiteralTypes = true,
  --     constantValues = true,
  --     functionTypeParameters = true,
  --     parameterNames = true,
  --     rangeVariableTypes = true,
  --   },
  -- },
  -- basedpyright = {
  --   settings = {
  --     disableOrganizeImports = true,
  --     basedpyright = {
  --       analysis = {
  --       }
  --     }
  --   }
  -- },
  sqlls = {
    cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
    filetypes = { 'sql', 'plsql' },
    root_markers = { '.sqllsrc.json' },
    settings = {},
  },
  pyright = {
    -- enabled = false,
    settings = { -- see Microsoft's Pyright settings documentation: https://github.com/microsoft/pyright/blob/main/docs/settings.md
      pyright = {
        autoImportCompletion = true,
        -- disableOrganizeImports = true, -- set to true to use Ruff's import organizer
      },
      python = {
        analysis = {
          typeCheckingMode = "strict",   -- "off" | "basic" | "strict"
          autoSearchPaths = true,        -- set to true to use Ruff's import organizer
          useLibraryCodeForTypes = true, -- set to true to use Ruff's import organizer
          diagnosticMode = "workspace",  -- "openFilesOnly" | "workspace"
          indexing = true,               --
          -- indexing = { exclude = { "build", "dist", "env", ".venv", ".git", ".tox", ".mypy_cache", ".pytest_cache" } },
          ignore = { '*' }               -- ignore all files for analysis to exclusively use Ruff for linting, not formatting
        }
      }
    },
  },
  ruff = {
    -- init_options = {
    -- settings = { },
    -- capabilities = { }
    -- }
  },
  -- ruff_lsp = {
  --   cmd = { 'ruff-lsp' },
  --   filetypes = { 'python' },
  --   init_options = {
  --     settings = { -- see: https://github.com/astral-sh/ruff-lsp?tab=readme-ov-file#settings
  --       -- args = { "--config " .. vim.loop.os_homedir() .. "/dev/scale-qe/pyproject.toml" },
  --       -- lint = { args = { "--line-length=99" } },
  --       -- format = { args = { "--line-length=99" } },
  --     },
  --   },
  --   single_file_support = true
  -- },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim' },
        disable = { 'missing-fields' }
      },
    },
  },
}


mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
}

local lspconfig = require 'lspconfig'

mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      offset_encoding = 'utf-16',
      settings = (servers[server_name] or {}).settings,
      init_options = (servers[server_name] or {}).init_options,
      filetypes = (servers[server_name] or {}).filetypes,
      cmd = (servers[server_name] or {}).cmd,
      root_markers = (servers[server_name] or {}).root_markers,
    }
  end,
  -- Custom handler for lua_ls
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers.lua_ls.settings,
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.uv.fs_stat(path .. '/.luarc.json') and not vim.uv.fs_stat(path .. '/.luarc.jsonc') then
          client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME, vim.fn.stdpath('config') },
              },
              diagnostics = { globals = { 'vim' } },
            }
          })
          client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
        end
      end,
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load({ paths = os.getenv('HOME') .. '/.config/nvim/snippets' })
luasnip.config.setup {}
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-N>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- default mapping
    ['<C-P>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4), -- default mapping
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    -- ['<Tab>'] = nil,
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    -- ['<S-Tab>'] = nil,
  },
  sources = {
    {
      name = "luasnip",
      priority = 150,
      group_index = 1,
      option = { show_autosnippets = true, use_show_condition = false },
    },
    {
      name = "nvim_lsp",
      priority = 100,
      group_index = 1,
    },
    {
      name = "treesitter",
      max_item_count = 5,
      priority = 90,
      group_index = 5,
      entry_filter = function(entry, vim_item)
        if entry.kind == 15 then
          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          local line = vim.api.nvim_get_current_line()
          local next_char = line:sub(cursor_pos[2] + 1, cursor_pos[2] + 1)
          if next_char == '"' or next_char == "'" then
            vim_item.abbr = vim_item.abbr:sub(1, -2)
          end
        end
        return vim_item
      end,
    },
    {
      name = "rg",
      keyword_length = 5,
      max_item_count = 5,
      option = {
        additional_arguments = "--smart-case --hidden",
      },
      priority = 80,
      group_index = 3,
    },
    { name = "path",
      priority = 80,
      group_index = 3,
    },
    {
      name = "nvim_lsp_signature_help",
      priority = 70,
    },
    {
      name = "buffer",
      max_item_count = 5,
      keyword_length = 2,
      priority = 50,
      entry_filter = function(entry)
        return not entry.exact
      end,
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
      group_index = 4,
    },
    { name = "async_path", priority = 30, group_index = 5 },
    { name = "calc",       priority = 10, group_index = 9 },
    {
      name = "conventionalcommits",
      priority = 10,
      group_index = 9,
      max_item_count = 5,
      entry_filter = function()
        if vim.bo.filetype ~= "gitcommit" then
          return false
        end
        return true
      end,
    },
    {
      name = "emoji",
      priority = 10,
      group_index = 9,
      entry_filter = function()
        if vim.bo.filetype ~= "gitcommit" then
          return false
        end
        return true
      end,
    },
  },
}

-- local colors = require("tokyonight.colors")
-- local util = require("tokyonight.util")
vim.cmd [[colorscheme tokyonight]]
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- override colors of Normal text
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.orange }) -- override colors of Normal text in floating windows

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
--


-- require("connor.set")
-- require("connor.remap")
--
--
--
--
-- -- Format after saving
-- autocmd({ "BufWritePost" }, {
-- 	group = connorGroup,
-- 	pattern = "*",
-- 	command = [[FormatWrite]],
-- })
--
-- -- Override ruler_column, shift_tab, colorcolumn rules in set.lua
-- local lang_settings = {
-- 	python = { ruler_column = 88 },
-- 	html = { ruler_column = 100 },
-- 	javascript = { ruler_column = 100 },
-- 	typescript = { ruler_column = 100 },
-- 	lua = { ruler_column = 80 },
-- 	markdown = { shift_tab = 2, ruler_column = 80 },
-- 	rst = { shift_tab = 3, ruler_column = 80 },
-- 	toml = { ruler_column = 99 },
-- 	yaml = { shift_tab = 2, ruler_column = 80 },
-- }
-- autocmd("FileType", {
-- 	group = connorGroup,
-- 	pattern = { "*" },
-- 	callback = function(args)
-- 		local ft_settings = lang_settings[vim.bo[args.buf].filetype] or {}
--
-- 		-- set the shiftwidth and tabstop to 4 unless stated otherwise
-- 		vim.opt.shiftwidth = ft_settings.shift_tab or 4
-- 		vim.opt.tabstop = ft_settings.shift_tab or 4
-- 		-- set a ruler column if specificed in lang_settings
-- 		vim.opt.colorcolumn = { ft_settings.ruler_column or 0 }
-- 	end,
-- })
--
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25
--
-- -- Enable nvim-tree:
-- -- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
