local function autogroup(name)
  return vim.api.nvim_create_augroup("rigae_" .. name, { clear = true })
end

