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

function M.to_camel_case()
    -- Save cursor position
    local cursor = vim.fn.getpos(".")

    -- Get current line
    local line = vim.fn.getline(".")

    -- Replace _x with X
    line = line:gsub("_(%l)", function(c) return c:upper() end)

    -- First letter lowercase
    line = line:gsub("^%u", function(c) return c:lower() end)

    -- Set the line
    vim.fn.setline(".", line)

    -- Restore cursor
    vim.fn.setpos(".", cursor)
end

function M.to_snake_case()
    -- Save cursor position
    local cursor = vim.fn.getpos(".")

    -- Get current line
    local line = vim.fn.getline(".")

    -- Replace camelCase with camel_case
    line = line:gsub("(%l)(%u)", function(l, u) return l .. "_" .. u:lower() end)

    -- Convert any remaining uppercase to lowercase
    line = line:lower()

    -- Set the line
    vim.fn.setline(".", line)

    -- Restore cursor
    vim.fn.setpos(".", cursor)
end

return M
