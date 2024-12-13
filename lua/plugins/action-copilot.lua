local is_work_laptop = os.getenv('IS_WORK_LAPTOP')

return {
  'github/copilot.vim',
  enabled = is_work_laptop == 'false'
}
