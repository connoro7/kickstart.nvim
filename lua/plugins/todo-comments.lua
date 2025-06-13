-- See: https://github.com/folke/todo-comments.nvim
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = true,      -- show icons in the signs column
    sign_priority = 8, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "FAILED", "ERROR", "BAD", "NO", "DANGER" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
        -- FIX:
        -- FIXME:
        -- BUG:
        -- FIXIT:
        -- ISSUE:
        -- FAILED:
        -- ERROR:
        -- BAD:
        -- NO:
        -- DANGER:
      },
      TODO = { icon = " ", color = "info", alt = { "HINT" } },
      -- TODO:
      -- HINT:
      SUCCESS = { icon = " ", color = "success", alt = { "GOOD", "PASSED", "DONE", "SEE", "See", "see" } },
      -- SUCCESS:
      -- GOOD:
      -- PASSED:
      -- DONE:
      -- SEE:
      -- See:
      -- see:
      HACK = { icon = " ", color = "warning", alt = { "INVALID" } },
      -- HACK:
      -- INVALID:
      WARN = { icon = " ", color = "warning", alt = { "CAUTION", "WARNING", "ATTENTION", "IMPORTANT" } },
      -- WARN:
      -- WARNING:
      -- CAUTION:
      -- ATTENTION:
      -- IMPORTANT:
      PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      -- PERF:
      -- PERFORMANCE:
      -- OPTIM:
      -- OPTIMIZE:
      NOTE = { icon = " ", color = "hint", alt = { "INFO", "EXAMPLE", "TIP", "SUMMARY", "TLDR", "tldr", "tl;dr" } },
      -- NOTE:
      -- INFO:
      -- EXAMPLE:
      -- TIP:
      -- SUMMARY:
      -- TLDR:
      -- tldr:
      -- tl;dr:
      TEST = { icon = "󰙨", color = "test", alt = { "TESTING", "CHECK", "VERIFY" } },
      -- TEST:
      -- TESTING:
      -- CHECK:
      -- VERIFY:
      LINK = { icon = " ", color = "default", alt = { "SOURCE" } },
      -- LINK:
      -- SOURCE:
      QUESTION = { icon = " ", color = "question", alt = { "HELP", "MISSING" } },
      -- QUESTION:
      -- HELP:
      -- MISSING:
      QUOTE = { icon = " ", color = "quote", alt = { "CITE", "CITATION" } },
      -- QUOTE:
      -- CITE:
      -- CITATION:
    },
    gui_style = {
      fg = "NONE",         -- The gui style to use for the fg highlight group.
      bg = "BOLD",         -- The gui style to use for the bg highlight group.
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      multiline = true,                -- enable multine todo comments
      multiline_pattern = "^.",        -- lua pattern to match the next multiline from the start of the matched keyword
      multiline_context = 10,          -- extra lines that will be re-evaluated when changing a line
      before = "",                     -- "fg" or "bg" or empty
      keyword = "wide",                -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
      after = "fg",                    -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
      comments_only = true,            -- uses treesitter to match keywords in comments only
      max_line_len = 400,              -- ignore lines longer than this
      exclude = {},                    -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of highlight groups or use the hex color if hl not found as a fallback
    colors = {
      -- error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      -- warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      -- info = { "DiagnosticInfo", "#2563EB" },
      -- hint = { "DiagnosticHint", "#10B981" },
      -- success = { "Identifier", "#50cf50" },
      -- default = { "Identifier", "#7C3AED" },
      -- test = { "Identifier", "#FF00FF" }
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      success = { "#50cf50" },
      default = { "#7C3AED" },
      test = { "#FF00FF" },
      question = { "#FFFF00" },
      quote = { "#FFFFFF" }
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
  },
}
