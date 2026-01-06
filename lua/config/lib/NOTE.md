## Cache pertinence

### Effects of `git_exclude` module on `source.code` `binary` `exclude_file`

> First Idea: It builds and populate the exclude as expected. Just for
> testing I reset the exclude file and run a fresh build in the same vim
> session. Now I receive "No new file to exclude." It no longer repopulates
> the exclude file (for that buffer it seems) irrespective of my subsequent
> multiple rebuilds. It only works again after exit vim and new session. It
> smells some persistent state is lurking somewhere.

> Second Idea: In fact the persistence could come really handy for performance
> if there is any place in the code appropriate for "cache = {}" reset for it
> comes to performance

### Answer

You are absolutely right. In a complex rig, **performance vs. stale state**
is the classic tradeoff. If you were working on a massive monorepo with
thousands of ignored files, parsing that text file on every single `<Leader>ml`
keypress could eventually introduce a micro-stutter.

The most appropriate place to reset the cache is an
**Autocommand**. Specifically, you want to clear the cache whenever the
`.git/info/exclude` file itself is modified, or when you switch projects
(change directories).

### The "Smart Cache" Implementation

We can keep the `local cache = {}` but add a "watcher" or a reset mechanism.

#### 1. Modify the Module to allow Cache Clearing

Add a `M.clear_cache()` function to your module.

```lua
-- lua/config/lib/git_exclude.lua
local M = {}
local cache = {} -- The "lurking" state

function M.clear_cache()
  cache = {}
  -- Optional: trace for debugging
  -- vim.notify("GitExclude cache cleared", vim.log.levels.TRACE)
end

-- ... inside M.exclude ...
-- Change the check to use the cache again
function M.exclude(targets)
  -- ...
  -- Load from disk ONLY if not in cache
  local info = cache[root]
  if not info then
    local path = root .. "/.git/info/exclude"
    info = {
      path = path,
      set = load_excludes(path),
    }
    cache[root] = info
  end
  -- targets "for loop"
end

return M

```

---

### 2. When to trigger the Reset?

You should place these triggers in your `lua/config/autocmds.lua` or at the
bottom of your module.

#### A. The "Manual Edit" Reset

If you open `.git/info/exclude` in Neovim and save a change, the cache is now
"wrong." We should wipe it immediately on save.

```lua
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*/.git/info/exclude",
  callback = function()
    require("config.lib.git_exclude").clear_cache()
  end,
})

```

#### B. The "Project Switch" Reset

If you move from your APUE folder to a different project, the `root`
key in your cache changes, but the old project's data is still sitting in
memory. To keep the memory footprint low, you can clear it when changing
the working directory.

```lua
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    require("config.lib.git_exclude").clear_cache()
  end,
})

```

---

### Is Caching actually necessary here?

Let's look at the "Assembly/Systems Programmer" perspective on performance:

1. **File Size:** A typical `.git/info/exclude` is under 1KB.
2. **Lua Speed:** `vim.fn.readfile()` on a 1KB file takes roughly **0.1ms
   to 0.5ms**.
3. **Human Perception:** You don't feel "lag" until about **50ms**.

**The Verdict:** While the cache is elegant, the **risk of a "vicious bug"**
is high, and the **performance gain is invisible**.

### My Recommendation for your Rig:

Keep the **stateless** (no cache) version for now. In your APUE studies, you
are likely creating and deleting binaries frequently. A stateless module is
"bulletproof"—it doesn't matter if you edit the file with `sed`, `echo`,
or another editor; Neovim will always be in sync.

If you eventually find that your exclude file has **5,000+ lines**, _then_
implement the cache with the `BufWritePost` autocommand reset.

**Would you like me to help you finalize the `remove` (Include) logic now
that we've settled on the stateless/stateful debate?**
