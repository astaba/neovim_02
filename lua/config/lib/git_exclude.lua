-- lua/config/lib/git_exclude.lua

-- Description: Add to $REPO/.git/info/exclude extensionless binaries path
-- defined relative to .git root directory ($REPO) in order to locally ignore
-- all ephemeral compilation artifacts specifically targeted while class
-- artifacts like "*.out" or "*.o" can be globally ignored through
-- $REPO/.gitignore file.

local M = {}

-- FIX: CONCEPTUAL GROUND:
-- The make command is for building. It builds from the content of the
-- active directory which originates from the current active buffer.
-- Then `make all` is assumed to be in the context of the active buffer.
-- To ensure relative path is resolved against the current buffer don't ever
-- define `vim.fn.expand("%:p:h")` in  the exact scope where M is defined.
-- As you reuse "%:p" in module functions incremental ancestors are returned.
-- WEIRD and NASTY bugs entail!

-- vim.notify("Line 40", vim.log.levels.DEBUG, { title = "Debugging" })

function M.get_git_root()
  local result = vim.system({ "git", "-C", vim.fn.expand("%:p:h"), "rev-parse", "--show-toplevel" }, { text = true })
      :wait()

  if result.code ~= 0 then
    return nil
  end

  return vim.trim(result.stdout)
end

local function load_excludes(path)
  local set = {}

  if vim.fn.filereadable(path) == 1 then
    for _, raw in ipairs(vim.fn.readfile(path)) do
      local line = vim.trim(raw)
      if (line ~= "") and (not line:match("^#")) then
        line = line:gsub("%s+#.*$", "")
        if line ~= "" then
          set[line] = true
        end
      end
    end
  end
  return set
end

---@param targets string[]
function M.exclude(targets)
  local root = M.get_git_root()
  if not root then
    vim.notify("Not inside a git  repository", vim.log.levels.INFO)
    return
  end

  local exlcude_path = root .. "/.git/info/exclude"
  local set = load_excludes(exlcude_path)

  local new_entries = {}
  local notified = {}

  for _, file_path in ipairs(targets) do
    local full_path = vim.fs.normalize(vim.fn.expand("%:p:h") .. "/" .. file_path)

    if vim.fn.filereadable(full_path) == 0 then
      vim.notify("Unknown path: " .. full_path, vim.log.levels.ERROR, { title = "Git Local Exclude" })
      goto continue
    end

    local rel_path = vim.fs.relpath(root, full_path) or file_path
    if not set[rel_path] then
      table.insert(new_entries, rel_path)
      set[rel_path] = true
      table.insert(notified, rel_path)
    end
    ::continue::
  end

  if #new_entries > 0 then
    vim.fn.writefile(new_entries, exlcude_path, "a")
    local max_visible = 5
    local message = ""
    if #notified <= max_visible then
      message = "Excluded:\n" .. table.concat(notified, "\n")
    else
      local truncated = {}
      for i = 1, max_visible do
        table.insert(truncated, notified[i])
      end
      message = string.format(
        "Excluded (%d files total):\n%s\n...\n(See .git/info/exclude)",
        #notified,
        table.concat(truncated, "\n")
      )
    end
    vim.notify(message, vim.log.levels.INFO, { title = "Git Local Exclude" })
  else
    vim.notify("No new file to exclude.", vim.log.levels.DEBUG, { title = "Git Local Exclude", timeout = 1000 })
    -- vim.log.levels.DEBUG("GitLocalExclude: No new file to exclude.")
  end
end

function M.exclude_recent_binaries()
  local results = vim.system(
    { "git", "-C", vim.fn.expand("%:p:h"), "ls-files", "--others", "--exclude-standard" },
    { text = true }
  ):wait()

  if results.code ~= 0 then
    return nil
  end

  local bins = {}
  for _, path in ipairs(results) do
    if not path:match("%.") then -- extensionless
      table.insert(bins, path)
    end
  end

  M.exclude(bins)
end

return M
