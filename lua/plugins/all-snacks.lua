vim.g.dashboard_expanded = false

math.randomseed(os.time())

local function toggle_dashboard_expansion()
  local dashboard = require("snacks.dashboard")
  vim.g.dashboard_expanded = not vim.g.dashboard_expanded
  dashboard.update()
end

local function pick_header_image()
  local random_seed = math.random(3, 3)
  if random_seed == 1 then
    return "pokemon-colorscripts -r --no-title -b; sleep .1"
  -- elseif random_seed == 2 then
  --   -- Do ascii art
  --   return 'catimg -H 60 /mnt/c/Users/derek/Downloads/image0.png'
  elseif random_seed == 3 then
    local path = vim.fn.stdpath("config") .. "/lua/header_images/images"
    local header_images = vim.fn.globpath(path, "*", false, true)
    local random_index = math.random(1, #header_images)
    return "catimg -H 60 " .. header_images[random_index] .. "; sleep .1"
    -- elseif random_seed == 4 then
    --   -- Do normal image
    --   return 'catimg -H 60 /mnt/c/Users/derek/Downloads/image0.png'
  end
  return "catimg -H 10 /mnt/c/Users/derek/Downloads/image0.png"
end

local dashboard_opts = {
  sections = {
    { section = "terminal", cmd = pick_header_image(), height = 30, padding = 4, indent = 4, random = 10 },
    { section = "recent_files", title = "Recent files", limit = 3, padding = 1, indent = 2 },
    {
      section = "projects",
      padding = 1,
      limit = 4,
      title = "Projects",
      indent = 2,
      enabled = function()
        return vim.g.dashboard_expanded
      end,
    },
    {
      section = "terminal",
      icon = " ",
      title = "Git Status",
      enabled = function()
        local has_diff = vim.fn.system("git diff --quiet --exit-code")
        return vim.fn.isdirectory(".git") == 1 and vim.g.dashboard_expanded and not has_diff
      end,
      cmd = "git diff --stat -B -M -C",
      height = 8,
      padding = 2,
      indent = 0,
    },
  },
}
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Helps with with performance on big files
    bigfile = { enabled = true },
    -- Shows the initial loading dashboard
    dashboard = dashboard_opts,
    -- Gives blame line
    git = { enabled = true },
    -- Opens the git repo in the browser
    gitbrowse = { enabled = true },
    -- Quick notification wrapper around vim.notify
    notify = { enabled = true },
    -- Improves UI for notifications
    notifier = { style = "fancy", top_down = false },
    -- Smooth scrolling
    scroll = {
      filter = function(buf)
        -- Don't scroll in dashboard
        return vim.bo[buf].buftype ~= "nofile" or vim.bo[buf].filetype ~= "terminal"
      end,
    },
    -- Enhanced statuscolumn
    statuscolumn = { folds = { open = true } },
    -- Highlight LSP references
    words = { enabled = true },
  },
  init = function()
    vim.keymap.set("n", "<leader>de", toggle_dashboard_expansion, { desc = "[D]ashboard [e]xpand" })
    vim.keymap.set("n", "<leader>vd", function()
      if vim.bo.filetype ~= "snacks_dashboard" then
        local new_dashboard = vim.tbl_extend("force", dashboard_opts, { win = 0 })
        Snacks.dashboard(new_dashboard)
      end
    end, { desc = "[V]iew [d]ashboard" })
    vim.keymap.set("n", "<leader>gb", function()
      Snacks.git.blame_line()
    end, { desc = "[G]it [b]lame" })
    vim.keymap.set("n", "<leader>gg", function()
      Snacks.gitbrowse.open()
    end, { desc = "[G]oto [g]it" })
    vim.keymap.set("n", "<leader>mn", function()
      Snacks.words.jump(vim.v.count1)
    end, { desc = "[M]ove to [n]ext" })
    vim.keymap.set("n", "<leader>mp", function()
      Snacks.words.jump(-vim.v.count1)
    end, { desc = "[M]ove to [p]revious" })
    vim.keymap.set("n", "<leader>vm", function()
      Snacks.notifier.show_history()
    end, { desc = "[V]iew [m]essage history" })

    -- Gives progress on loading the LSP
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(vim.lsp.status(), "info", {
          id = "lsp_progress",
          title = "LSP Progress",
          opts = function(notif)
            notif.icon = ev.data.params.value.kind == "end" and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
