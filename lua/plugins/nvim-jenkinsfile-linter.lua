-- See: https://github.com/ckipp01/nvim-jenkinsfile-linter

local function set_env_var(vim_var_name, os_env_var)
  local value = os.getenv(os_env_var)
  if value then
    vim.env[vim_var_name] = value
  else
    print(string.format("%s is not detected in OS environment.", os_env_var))
  end
end

-- Ensure required env vars are set
if os.getenv("JENKINS_USER_ID") == nil then
  print("Jenkins linting not configured, JENKINS_USER_ID is not detected.")
else
  set_env_var("JENKINS_USER_ID", "JENKINS_USER_ID")
  set_env_var("JENKINS_URL", "JENKINS_URL")
  if os.getenv("JENKINS_API_TOKEN") == nil then
    set_env_var("JENKINS_PASSWORD", "JENKINS_PASSWORD")
  else
    set_env_var("JENKINS_API_TOKEN", "JENKINS_API_TOKEN")
  end
end

-- [[ Lint Jenkinsfile after save ]]
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "Jenkinsfile",
  callback = function()
    require("jenkinsfile_linter").validate()
  end,
})

-- [[ Lint Jenkinsfile on keymap ]]
-- vim.keymap.set("n", "<leader>jl", function() require("jenkinsfile_linter").validate() end)

return {
  "ckipp01/nvim-jenkinsfile-linter",
  requires = { "nvim-lua/plenary.nvim" },
}
