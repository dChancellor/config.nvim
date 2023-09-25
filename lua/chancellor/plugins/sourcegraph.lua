local is_work_laptop = os.getenv("IS_WORK_LAPTOP")

if is_work_laptop == "true" then
  return {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  }
else
  return {}
end
