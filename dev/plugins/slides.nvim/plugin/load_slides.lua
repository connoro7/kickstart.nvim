vim.api.nvim_create_user_command("SlidesStart", function()
  package.loaded["slides"] = nil
  if not pcall(require, "slides") then
    vim.notify("Slides module not found. Please ensure it is installed.", vim.log.levels.ERROR)
    return
  end
  -- buffer type must be markdown
  if vim.bo.filetype ~= "markdown" then
    vim.notify("Slides can only be started from a markdown file.", vim.log.levels.ERROR)
    return
  end
  require("slides").start_presentation()
end, {})
