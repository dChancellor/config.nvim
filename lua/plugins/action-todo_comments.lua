-- TODO: this is a todo comment
-- HACK: this is a hack comment
-- WARN: this is a warning
-- FIX: this is a fix comment
-- PERF: this is a perf comment
-- NOTE: this is a note comment
-- TEST: this is a test comment

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      DEPRECATED = {
        icon = "",
        color = "error",
        alt = { "DEPRECATED", "OBSOLETE" },
      }
    }
  }
}
