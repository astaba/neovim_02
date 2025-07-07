# 📝 Rig Manifest

Modular, extensible, and blazing fast Neovim setup — engineered for mastery through discipline, deep filetype workflows, lazy-loaded plugins, and programmable build pipelines.

---

## 🧠 Core Philosophy

* 🧩 Each plugin is isolated under `lua/plugins/`, lazily loaded for performance
* 📦 Plugin toggles are managed via a clean, gitignored manifest: `~edict.lua`
* 🛠 Filetype-specific automations live in `lua/config/ft/<filetype>.lua`, loaded on demand
* 🧙🏽 Plugin eligibility is decided through `grimoire.lua`, a credential gateway
* 🎨 Colorscheme changes persist into `~colorscheme-lock.lua` via `ColorScheme` events
* ⚖️ **Respect the Realm**: Default Vim keybindings are **sacred**. Avoid remapping them unless absolutely necessary.

---

## ⚔️ Why Defaults Matter

You chose Vim to level up — not to bend it to an old editor’s habits. This rig honors the customs of the realm: Vim’s defaults are powerful, time-tested, and deeply integrated into its grammar of motion and control.

Trading with the Remapping Wizard may grant temporary comfort, but beware:

> **“If you stubbornly refuse to come to terms with the Realm’s customs — and instead strike a pact with the Remapping Galore Wizard — you may find short-lived comfort. But mark this: on the bleak day your rig defaults you in some faraway land,  Vim the legitimate Ruler shall rise again, and you’ll stand unarmed in foreign soil, betrayed by muscle memory and forsaken mappings.”**

Use the defaults. Learn the ways. Become fluent.

---


## 🔨 Plugin Management

Using [lazy.nvim](https://github.com/folke/lazy.nvim) via `config/lazy.lua`:

- Load plugins from `lua/plugins/*.lua`
- Plugin activation respects the `enabled` flag
- Toggle plugin states via `~edict.lua`:

```lua
  return {
    ["nvim-cmp"] = true,
    ["codeium"] = false,
    ...
  }
```

---

## 🔁 Filetype-specific Auto Commands

Each filetype gets its own modular file in:

```lua
lua/config/ft/
  ├── c-cpp.lua
  ├── shell.lua
  ├── makefile.lua
  ├── text.lua
  └── ...
```

Dynamically loaded on first use via:

```lua
vim.api.nvim_create_autocmd("FileType", {
  callback = function(event)
    require("config.ft." .. event.match)
  end,
})
```

---

## 🧙 Special Files

| Path                      | Role                                    |
| ------------------------- | --------------------------------------- |
| `~/.config/nvim/init.lua` | Top-level entrypoint                    |
| `lua/config/~edict.lua`   | Plugin permission registry (gitignored) |
| `lua/config/grimoire.lua` | Authorization proxy for `enabled` flags |
| `lua/config/ft/*.lua`     | Filetype-specific logic (lazy-loaded)   |
| `lua/config/core/*`       | General editor config                   |
| `lua/plugins/*.lua`       | Lazy plugin specs                       |
| `~colorscheme-lock.lua`   | Persisted theme after session           |

---

## ✅ Requirements

* `git`, `curl`, `rg`, `fd`, `make`, `tmux` (for full feature support)
* Neovim ≥ 0.9.1 with LuaJIT

---

## 💡 Tip

Use `sort` to maintain `~edict.lua`:

```sh
sort lua/config/~edict.lua -o lua/config/~edict.lua
```

---

My rig. My realm. Rule it cleanly 👑.

## 😩 Lazy performance.rtp.disabled_plugins

**A big start aiming on the wrong path: disappointment**  
Lazy.nvim’s `performance.rtp.disabled_plugins` **seems promising**, but in reality:

### ⚠️ It **doesn’t disable Lazy-managed plugins** — only **non-Lazy** ones:

These are things like:

* Built-in Vim plugins (`gzip`, `matchit`, `netrw`, etc.)
* Runtime plugins outside Lazy’s plugin tree

So trying to disable **Lazy-managed plugins like `nvim-cmp`, `lualine`, `neo-tree`, etc.** using `performance.rtp.disabled_plugins` just **won’t work reliably** — unless you're manually hacking the runtime path, which defeats Lazy’s purpose.

---

### ✅ Why `~edict.lua` Wins

My approach with `~edict.lua` **solves the right problem**:

| Feature                      | Lazy `disabled_plugins` | `~edict.lua` toggle system |
| ---------------------------- | ----------------------- | -------------------------- |
| Disables Lazy-managed plugin | ❌ No                    | ✅ Yes                      |
| Supports per-plugin toggles  | ❌ Hard to manage        | ✅ Clean & semantic         |
| Git-clean solution           | ✅                       | ✅                          |
| Easy to maintain             | ❌ Regex-prone           | ✅ Alphabetic table         |
| Works with dependencies too  | ❌ No                    | ✅ Recursively possible     |

My `grimoire.lua` as a credential proxy is **clean**, **declarative**, and **highly maintainable**. The `.toml` or Lua file acts as a **regal manifest** and solves the one thing `lazy.nvim` doesn't want to solve: *feature flags for plugin specs*.

---

### 🔮 TL;DR Recommendation

* Keep using `~edict.lua` toggle system
* Don’t rely on `performance.rtp.disabled_plugins` for plugin toggling — it’s misleading
* Could wrap a CLI utility (`:RigToggle <plugin>`) later for on-the-fly toggling with `vim.notify()` feedback

I am not just avoiding Lazy’s shortcomings — I am **designing a more powerful plugin governance layer**. That’s next-level rig mastery.
