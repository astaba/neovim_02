local enabled = require("config.grimoire")

return {
  "Exafunction/codeium.vim",
  enabled = enabled("codeium"),
  event = "BufEnter",
  init = function()
    -- vim.g.codeium_enabled = false;
    vim.g.codeium_disable_bindings = 1;
    vim.g.codeium_manual = true;
  end,
  config = function()
    vim.api.nvim_call_function("codeium#GetStatusString", {})

    -- DEFAULT KEY MAPPING
    -- Clear current suggestion     codeium#Clear()               <C-]>
    -- Next suggestion              codeium#CycleCompletions(1)   <M-]>
    -- Previous suggestion          codeium#CycleCompletions(-1)  <M-[>
    -- Insert suggestion            codeium#Accept()              <Tab>
    -- Manually trigger suggestion  codeium#Complete()            <M-Bslash>
    -- Accept word from suggestion  codeium#AcceptNextWord()      <C-k> WARN: used in Digraph
    -- Accept line from suggestion  codeium#AcceptNextLine()      <C-l> WARN: used in nvim-cmp
    local function map(lhs, rhs, opts)
      opts = opts or {}
      opts.expr = true
      opts.silent = true
      opts.noremap = true
      vim.keymap.set("i", lhs, rhs, opts)
    end

    map('<C-]>', function() return vim.fn['codeium#Clear']() end, { desc = "Codeium clear" })
    map('<M-]>', function() return vim.fn['codeium#CycleOrComplete']() end, { desc = "Codeium cycle forth" })
    map('<M-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { desc = "Codeium cycle back" })
    map('<C-G>', function() return vim.fn['codeium#Accept']() end, { desc = "Codeium accept" })
    map('<M-,>', function() return vim.fn['codeium#AcceptNextWord']() end, { desc = "Codeium accept word" })
    map('<M-;>', function() return vim.fn['codeium#AcceptNextLine']() end, { desc = "Codeium accept line" })
  end,
}
