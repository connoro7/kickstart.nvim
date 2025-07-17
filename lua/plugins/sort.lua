return {
  'sQVe/sort.nvim',
  --[[
  -- Basic usage: `:Sort`
  -- Help: `:h :sort`
  -- :[range]Sort[!] [delim][flags]
  --   [range]: Lines to sort, :1,10, :., :% for all lines
  --   !: Reverse sort order
  --   [delim]: Manually specify delim (any punctuation, `s` for space, `t` for tab)
  -- Flags:
  --   b: sort by binary numbers
  --   i: ignore case
  --   n: sort by decimal numbers
  --   o: sort by octal numbers
  --   u: keep only unique items
  --   x: sort by hexadecimal numbers
  --   z: natural sorting (handles numbers in strings properly, item1,item10,item2 -> item1,item2,item10)
  --]]
  config = function()
    require('sort').setup({
      {
        -- List of delimiters, in descending order of priority, to automatically
        -- sort on.
        delimiters = {
          ',',
          '|',
          ';',
          ':',
          's', -- Space.
          't'  -- Tab.
        },

        -- a 1 2 3 5 6 7 7 8 10 99
        -- Enable natural sorting for motion operations by default.
        -- When true, sorts "item1,item10,item2" as "item1,item2,item10".
        -- When false, uses lexicographic sorting: "item1,item10,item2".
        natural_sort = true,

        -- Whitespace handling configuration.
        whitespace = {
          -- When whitespace before items is >= this many characters, it's considered
          -- alignment and is preserved. Otherwise, whitespace is normalized to be
          -- consistent when sorting changes item order.
          alignment_threshold = 3,
        },

        -- Default keymappings (set to false to disable).
        mappings = {
          operator = false,
          textobject = false,
          motion = false,
        },
        -- mappings = {
        --   operator = 'go',
        --   textobject = {
        --     inner = 'io',
        --     around = 'ao',
        --   },
        --   motion = {
        --     next_delimiter = ']o',
        --     prev_delimiter = '[o',
        --   },
        -- },
      }
    })
  end,
}
