local M = {}

local utils = require("utils")

local env = utils.load_env()

local token = env.JIRA_API_TOKEN
local assignee = env.JIRA_USER_NAME
local base_url = env.JIRA_BASE_URL

local url = base_url .. "/rest/api/3/search"

local headers = {
  ["Authorization"] = "Basic " .. token,
  ["Content-Type"] = "application/json",
}

local query = {
  jql = 'assignee="' .. assignee .. '" and resolution="unresolved"',
  maxResults = 5,
  fields = "id,key,summary,description,status",
}

vim.cmd("highlight HeaderText gui=bold guifg=#ff0000")
vim.cmd("highlight SubText guifg=#aaaaaa")

local function set_highlight(bufnr, line, group)
  local ns_id = vim.api.nvim_create_namespace("header_highlight")
  vim.api.nvim_buf_add_highlight(bufnr, ns_id, group, line, 0, -1)
end

local create_ticket_section = function(buf, header, text)
  local indent = "  "
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, { header, "=========" })
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, { indent .. text, "" })
end

local create_ticket_window = function(issue)
  local buf, win = utils.create_floating_window({ title = issue.key, width = 100, height = 40 })
  vim.api.nvim_set_option_value("wrap", true, { win = win })
  vim.api.nvim_set_option_value("linebreak", true, { win = win })

  create_ticket_section(buf, "Summary", issue.fields.summary)
  create_ticket_section(buf, "Description", issue.fields.description)
  set_highlight(buf, 0, "HeaderText")
  -- vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "Description: ", "", indent .. issue.fields.description, "" })
end

create_ticket_window({
  key = "TEST-123",
  fields = {
    summary = "Do this thing real quick",
    description = "This is a test ticket with a much longer description and I'm not sure what else to write here but here I go and I'm just still writing a bunch of stuff",
  },
})

local parse_active_tickets = function(issues)
  local parsed_table = {}
  for i, issue in ipairs(issues) do
    local header = {
      -- TODO: Stop hardcoding 50 and calculate vim columns instead
      desc = utils.clip_text(issue.key .. ": " .. issue.fields.summary, 50),
      key = "i" .. tostring(i),
      action = function()
        create_ticket_window(issue)
      end,
    }
    table.insert(parsed_table, header)
  end
  return parsed_table
end

local get_active_tickets = function()
  local data = {}
  local file, _ = io.open("./cached_tasks.txt", "r")
  if not file then
    local curl = require("plenary.curl")

    local response = curl.get(url, { query = query, headers = headers })
    if response.status ~= 200 then
      vim.notify("There was an error pulling Jira tickets", vim.log.levels.ERROR)
    end

    file = io.open("./cached_tasks.txt", "w")
    if file then
      file:write(response.body)
    else
      vim.notify("There was an error creating the cached file", vim.log.levels.ERROR)
    end
  end

  if file then
    local content = file:read("*all")

    data = vim.json.decode(content)
    file:close()
  end

  local parsed_issues = parse_active_tickets(data.issues)
  M.issues = parsed_issues
  return parsed_issues
end

function M.setup() end

M.get_active_tickets = get_active_tickets

return M
