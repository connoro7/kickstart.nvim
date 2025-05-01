-- -@diagnostic disable: undefined-field

local M = {}

local function create_floating_window(config)
  local buf = vim.api.nvim_create_buf(false, true) -- no file, scratch buffer
  local win = vim.api.nvim_open_win(buf, true, config)
  return { buf = buf, win = win }
end

local defaults = {}

---@type slides.Options
local options = {}

---@class slides.Options

---@param opts slides.Options
M.setup = function(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {})
end

---@class slides.Slides
---@fields slides slides.Slide[]: "slides" within file

---@class slides.Slide
---@field title string: title of slide
---@field body string[]: body content of slide

---@param lines string[]: lines in buffer
---@return slides.Slides
local parse_slides = function(lines)
  local slides = { slides = {} }
  local curr_slide = {
    title = "",
    body = {},
  }

  local separator = "^#"

  for _, line in ipairs(lines) do
    -- print(line, "find:", line:find(separator), "|")
    if line:find(separator) then
      if #curr_slide.title > 0 then
        table.insert(slides.slides, curr_slide)
      end
      curr_slide = {
        title = line,
        body = {},
      }
      table.insert(curr_slide, line)
    else
      table.insert(curr_slide.body, line)
    end
  end
  if #curr_slide.title > 0 then
    table.insert(slides.slides, curr_slide)
  end
  return slides
end

M.start_presentation = function(opts)
  opts = opts or {}
  opts.bufnr = opts.bufnr or 0
  local lines = vim.api.nvim_buf_get_lines(opts.bufnr, 0, -1, false)
  local parsed = parse_slides(lines)

  ---@type vim.api.keyset.win_config[]
  local width = vim.o.columns
  local height = vim.o.lines
  local body_inset = 8
  local windows = {
    background = {
      relative = "editor",
      width = width,
      height = height,
      style = "minimal",
      col = 0,
      row = 0,
      zindex = 1,
    },
    header = {
      relative = "editor",
      width = width,
      height = 1,
      style = "minimal",
      border = "rounded",
      col = 0,
      row = 0,
      zindex = 2,
    },
    body = {
      relative = "editor",
      width = width - body_inset,
      height = height - 5,
      style = "minimal",
      border = { " ", " ", " ", " ", " ", " ", " ", " ", },
      col = body_inset,
      row = 4
    },
    -- footer = {},
  }
  local background_float = create_floating_window(windows.background)
  local header_float = create_floating_window(windows.header)
  local body_float = create_floating_window(windows.body)

  vim.bo[header_float.buf].filetype = "markdown"
  vim.bo[body_float.buf].filetype = "markdown"


  local set_slide_contents = function(idx)
    local slide = parsed.slides[idx]

    local padding = string.rep(" ", (width - #slide.title) / 2)
    local title = padding .. slide.title
    vim.api.nvim_buf_set_lines(header_float.buf, 0, -1, false, { title })
    vim.api.nvim_buf_set_lines(body_float.buf, 0, -1, false, slide.body)
  end

  local curr_slide = 1
  vim.keymap.set("n", "n", function()
    curr_slide = math.min(curr_slide + 1, #parsed.slides)
    set_slide_contents(curr_slide)
  end, {
    buffer = body_float.buf,
  })
  vim.keymap.set("n", "p", function()
    curr_slide = math.max(curr_slide - 1, 1)
    set_slide_contents(curr_slide)
  end, {
    buffer = body_float.buf,
  })
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(body_float.win, true)
  end, {
    buffer = body_float.buf,
  })

  local restore = {
    cmdheight = {
      initial = vim.o.cmdheight,
      present = 0,
    }
  }

  -- set opts for presentation
  for option, config in pairs(restore) do
    vim.opt[option] = config.present
  end

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = body_float.buf,
    callback = function()
      -- restore user options on quit
      for option, config in pairs(restore) do
        vim.opt[option] = config.initial
      end
      pcall(vim.api.nvim_win_close, header_float.win, true)
      pcall(vim.api.nvim_win_close, background_float.win, true)
    end
  })
  set_slide_contents(curr_slide)
end

-- M.start_presentation { bufnr = vim.api.nvim_get_current_buf() }
M._parse_slides = parse_slides
return M
