if vim.g.dhdiagnostic == true then
  return {
    'rktjmp/lush.nvim',
    "rktjmp/shipwright.nvim"
  }
else
  return {}
end
