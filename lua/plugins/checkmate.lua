return {
  "bngarren/checkmate.nvim",
  ft = "markdown",
  opts = {
    enabled = true,
    notify = true,
    files = {
      "todo",
      "TODO",
      "todo.md",
      "TODO.md",
      "*.todo",
      "*.todo.md",
    },
    log = {
      level = "info",
      use_file = false,
      use_buffer = false,
    },
    keys = {
      ["Tt"] = {
        rhs = "<cmd>Checkmate toggle<CR>",
        desc = "Toggle todo item",
        modes = { "n", "v" },
      },
      ["Tc"] = {
        rhs = "<cmd>Checkmate check<CR>",
        desc = "Set todo item as checked (done)",
        modes = { "n", "v" },
      },
      ["Tu"] = {
        rhs = "<cmd>Checkmate uncheck<CR>",
        desc = "Set todo item as unchecked (not done)",
        modes = { "n", "v" },
      },
      ["Tn"] = {
        rhs = "<cmd>Checkmate create<CR>",
        desc = "Create todo item",
        modes = { "n", "v" },
      },
      ["TR"] = {
        rhs = "<cmd>Checkmate remove_all_metadata<CR>",
        desc = "Remove all metadata from a todo item",
        modes = { "n", "v" },
      },
      ["Ta"] = {
        rhs = "<cmd>Checkmate archive<CR>",
        desc = "Archive checked/completed todo items (move to bottom section)",
        modes = { "n" },
      },
      ["Tv"] = {
        rhs = "<cmd>Checkmate metadata select_value<CR>",
        desc = "Update the value of a metadata tag under the cursor",
        modes = { "n" },
      },
      ["T]"] = {
        rhs = "<cmd>Checkmate metadata jump_next<CR>",
        desc = "Move cursor to next metadata tag",
        modes = { "n" },
      },
      ["T["] = {
        rhs = "<cmd>Checkmate metadata jump_previous<CR>",
        desc = "Move cursor to previous metadata tag",
        modes = { "n" },
      },
    },
    default_list_marker = "-",
    todo_markers = {
      unchecked = "□",
      checked = "✔",
    },
    -- style = {}, -- override defaults
    todo_action_depth = 1,         --  Depth within a todo item's hierachy from which actions (e.g. toggle) will act on the parent todo item
    enter_insert_after_new = true, -- Should enter INSERT mode after :CheckmateCreate (new todo)
    smart_toggle = {
      enabled = true,
      check_down = "direct_children",
      uncheck_down = "none",
      check_up = "direct_children",
      uncheck_up = "direct_children",
    },
    show_todo_count = true,
    todo_count_position = "eol",
    todo_count_recursive = true,
    use_metadata_keymaps = true,
    metadata = {
      -- Example: A @priority tag that has dynamic color based on the priority value
      priority = {
        style = function(context)
          local value = context.value:lower()
          if value == "top" or value == "first" then
            return { fg = "#ff79c6", bold = true }
          elseif value == "high" then
            return { fg = "#ff5555", bold = true }
          elseif value == "medium" or value == "med" then
            return { fg = "#ffb86c" }
          elseif value == "low" then
            return { fg = "#8be9fd" }
          else -- fallback
            return { fg = "#8be9fd" }
          end
        end,
        get_value = function()
          return "medium" -- Default priority
        end,
        choices = function()
          return { "low", "medium", "high" }
        end,
        key = "Tp",
        sort_order = 10,
        jump_to_on_insert = "value",
        select_on_insert = true,
      },
      -- Example: A @started tag that uses a default date/time string when added
      started = {
        aliases = { "init" },
        style = { fg = "#9fd6d5" },
        get_value = function()
          return tostring(os.date("%m/%d/%y %H:%M"))
        end,
        key = "Ts",
        sort_order = 20,
      },
      -- Example: A @done tag that also sets the todo item state when it is added and removed
      done = {
        aliases = { "completed", "finished" },
        style = { fg = "#96de7a" },
        get_value = function()
          return tostring(os.date("%m/%d/%y %H:%M"))
        end,
        key = "Td",
        on_add = function(todo_item)
          require("checkmate").set_todo_item(todo_item, "checked")
        end,
        on_remove = function(todo_item)
          require("checkmate").set_todo_item(todo_item, "unchecked")
        end,
        sort_order = 30,
      },
    },
    archive = {
      heading = {
        title = "Archive",
        level = 2,        -- e.g. ##
      },
      parent_spacing = 0, -- no extra lines between archived todos
      newest_first = true,
    },
    linter = {
      enabled = true,
    },
  },

}
