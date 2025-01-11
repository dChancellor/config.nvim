local M = {}

function M.find_repo_root()
  local cwd = vim.loop.cwd() -- Get the current working directory
  while cwd do
    if vim.loop.fs_stat(cwd .. "/.git") then
      return cwd
    end
    local parent = cwd:match("^(.*)/[^/]+$")
    if parent == cwd then
      break
    end
    cwd = parent
  end
  error("Could not find the repository root (missing .git directory)")
end

function M.load_env(file_path)
  -- If no file path is provided, default to <repo_root>/.env
  file_path = file_path or (M.find_repo_root() .. "/.env")

  local env = {}
  local file = io.open(file_path, "r")

  if not file then
    error("Could not open .env file: " .. file_path)
  end

  for line in file:lines() do
    local key, value = line:match("^([%w_]+)%s*=%s*(.+)$")
    if key and value then
      env[key] = value
    end
  end

  file:close()
  return env
end

function M.utf8len(str)
  local len = 0
  for _ in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
    len = len + 1
  end
  return len
end

function M.clip_text(text, width)
  local r_len = M.utf8len(text)
  if r_len > width then
    text = text:sub(1, (width - r_len) - 4) .. "..."
  end
  return text
end

function M.create_floating_window(opts)
  local gheight = vim.api.nvim_list_uis()[1].height
  local gwidth = vim.api.nvim_list_uis()[1].width

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = opts.width,
    height = opts.height,
    row = (gheight - opts.height) / 2,
    col = (gwidth - opts.width) / 2,
    style = "minimal",
    border = "rounded",
    title = opts.title,
    title_pos = "center",
  })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Hello, world!" })
  return buf, win
end

return M
