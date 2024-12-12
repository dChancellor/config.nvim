local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values

local filetype_search_string = " |"

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end
      local pieces = vim.split(prompt, filetype_search_string)
      local args = { 'rg' }
      if pieces[1] then
        table.insert(args, '-e')
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, '-g')
        table.insert(args, pieces[2])
      end

      return vim.tbl_flatten {
        args,
        { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' }
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }
  pickers.new(opts, {
    debounce = 100,
    prompt_title = 'Multi Grep - use "'
        ..
        filetype_search_string
        ..
        '" for glob',
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require('telescope.sorters').empty()
  }):find()
end


return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup {
      pickers = {
        help_tags = {
          theme = 'ivy'
        }
      },
      extensions = {
        fzf = {}
      }
    }

    require('telescope').load_extension('fzf')

    local builtins = require('telescope.builtin')

    vim.keymap.set('n', '<space>sf', builtins.find_files, { desc = '[S]earch [f]iles' })
    vim.keymap.set('n', '<space>sg', live_multigrep, { desc = '[S]earch [g]rep' })
    vim.keymap.set('n', '<space>sh', builtins.help_tags, { desc = '[S]earch [h]elp' })
    vim.keymap.set('n', '<space>sn', function()
      builtins.find_files {
        cwd = vim.fn.stdpath('config')
      }
    end, { desc = '[S]earch [n]vim' })
    vim.keymap.set('n', '<space>sp', function()
      builtins.find_files {
        cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
      }
    end, { desc = '[S]earch in nvim [p]lugins' })
  end
}
