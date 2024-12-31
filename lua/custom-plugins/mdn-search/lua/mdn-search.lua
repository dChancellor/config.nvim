local M = {}

--- @param query_parameters string[]
local function search_mdn(query_parameters)
  local query = table.concat(query_parameters, "+")
  local url = "https://developer.mozilla.org/en-US/search?q=" .. query

  local response = curl.get(url)
  if response.code ~= 200 then
    print("Error: " .. response.code)
    return nil, response.code
  end
  return response.body, nil
end

function M.setup()
  local curl = require("plenary.curl")
  -- local parser = require("lua-htmlparser")
  -- local results = search_mdn({ "bold", "string" })
  -- print("MDN search plugin loaded")
end

return M
