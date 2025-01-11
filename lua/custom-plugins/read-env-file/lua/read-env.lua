local function load_env(file_path)
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

return load_env
