local M = {}

-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}

M.project_files = function()
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    require("telescope.builtin").git_files({
        show_untracked = true,
        git_command = {
            "git","ls-files","--exclude-standard","--cached",
            "--",".", ":!:*.png", ":!:*.jpg", ":!:*.jpeg"
        },
    })
  else
    require("telescope.builtin").find_files()
  end
end

return M
