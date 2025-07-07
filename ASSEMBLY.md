# Assembly

## **Configure Build and Run Commands**

Add shortcuts to assemble, link, and run your assembly programs directly from Neovim.

### Key Mapping for Workflow
Add these mappings to your `init.vim` or `init.lua`:
- **For `init.vim`:**
  ```vim
  nnoremap <leader>as :!nasm -f elf64 % -o %:r.o<CR>
  nnoremap <leader>al :!ld %:r.o -o %:r<CR>
  nnoremap <leader>ar :!./%:r<CR>
  ```
  - `<leader>as`: Assembles the current file into an object file.
  - `<leader>al`: Links the object file into an executable.
  - `<leader>ar`: Runs the executable.

- **For `init.lua`:**
  ```lua
  vim.api.nvim_set_keymap('n', '<leader>as', ':!nasm -f elf64 % -o %:r.o<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>al', ':!ld %:r.o -o %:r<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>ar', ':!%:r<CR>', { noremap = true })
  ```

### Explanation:
- `%` refers to the current file.
- `%:r` refers to the file name without the extension.
- `:!` runs a shell command.

## **Source a command from the current directory**

Allowing each project to have its own custom commands **without modifying your global configuration**. 🚀  

### **🔹 Solution: Use a Local `.vimrc` or `.nvimrc` in Each Directory**
You can create **a local configuration file** (`.vimrc` or `.nvimrc`) in each project directory and make Neovim automatically source it when opening files from that directory.

#### **1️⃣ Enable Local Vimrc Sourcing**
Add the following to your **global** `init.vim` or `init.lua`:
- **For `init.vim`:**
  ```vim
  set exrc        " Enable per-directory config files
  set secure      " Prevent unsafe commands in local vimrc files
  ```
- **For `init.lua`:**
  ```lua
  vim.opt.exrc = true   -- Enable per-directory config files
  vim.opt.secure = true -- Restrict unsafe commands
  ```

✅ **Now, when Neovim enters a directory containing a `.vimrc` or `.nvimrc`, it will automatically load that config!**  
✅ Each directory can have **custom commands, shortcuts, or settings** that override global ones.

#### **2️⃣ Define Custom Assembly Commands in Each Directory**
Inside your **project directory**, create a `.nvimrc` file with **custom shortcuts**:
```vim
nnoremap <leader>as :!./assemble.sh<CR>
nnoremap <leader>al :!./link.sh<CR>
nnoremap <leader>ar :!./run.sh<CR>
```
Now:
- **Each directory** can define its own `assemble.sh`, `link.sh`, and `run.sh` scripts with custom behavior.
- **Same key mappings (`<leader>as`, etc.)** work across all projects **without modifying Neovim’s global config**. 🎯

#### **3️⃣ Alternative: Source a Custom Script Based on Directory**
Instead of `.vimrc`, you can **source a local shell script dynamically**:
```vim
autocmd BufEnter * if filereadable("./.nvim_commands.vim") | source .nvim_commands.vim | endif
```
✅ This automatically loads `.nvim_commands.vim` in the **current directory** when entering any file within it.

---

### **🔹 Summary**
✔ **Each project can have its own commands** in `.vimrc` or `.nvimrc`.  
✔ **No need to manually update the global config** for different directories.  
✔ **Same shortcuts (`<leader>as`, etc.) work across all projects**, but **execute different commands** based on the current directory.  

## **Automate compilation and linking**

In Neovim every time you save a `*.nsam` file using an **autocommand**. Plus, I'll make it **togglable**, so you can turn it on/off when needed. 🚀  

---

### **🔹 Step 1: Define the Auto-Compile Command**  
Place this in your `init.vim` or `init.lua`:  

#### **For `init.vim` (Vimscript version)**
```vim
let g:asm_auto_compile = 1 " Toggle Flag (1 = On, 0 = Off)

autocmd BufWritePost *.nsam if g:asm_auto_compile | execute "!nasm -f elf64 % -o %:r.o && ld %:r.o -o %:r" | endif
```

#### **For `init.lua` (Lua version)**
```lua
vim.g.asm_auto_compile = true -- Toggle Flag (true = On, false = Off)

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.nsam",
  callback = function()
    if vim.g.asm_auto_compile then
      vim.fn.system("nasm -f elf64 " .. vim.fn.expand("%") .. " -o " .. vim.fn.expand("%:r") .. ".o && ld " .. vim.fn.expand("%:r") .. ".o -o " .. vim.fn.expand("%:r"))
    end
  end
})
```

---

### **🔹 Step 2: Add Toggle Commands**  
This allows you to **turn the auto-compile feature on or off** without restarting Neovim.

#### **For `init.vim` (Vimscript)**
```vim
command! ToggleAutoCompile let g:asm_auto_compile = !g:asm_auto_compile | echo "Auto Compile: " . (g:asm_auto_compile ? "Enabled" : "Disabled")
```

#### **For `init.lua` (Lua)**
```lua
vim.api.nvim_create_user_command("ToggleAutoCompile", function()
  vim.g.asm_auto_compile = not vim.g.asm_auto_compile
  print("Auto Compile: " .. (vim.g.asm_auto_compile and "Enabled" or "Disabled"))
end, {})
```

---

### **🔹 Usage**
1️⃣ **Auto-compilation is enabled by default** when you save a `*.nsam` file.  
2️⃣ To **toggle it ON/OFF**, run:  
   ```vim
   :ToggleAutoCompile
   ```
   ✅ It will show `"Auto Compile: Enabled"` or `"Auto Compile: Disabled"` in the status bar.

---

### **🔹 Summary**
✔ **Automatically compiles & links** when saving `*.nsam` files.  
✔ **Togglable feature** via `:ToggleAutoCompile`.  
✔ **Works in both Vimscript (`init.vim`) & Lua (`init.lua`).**  

---

## ✅ x86-64 Memory Addressing Modes

| **SCHEME**                       | **EXAMPLE**              | **DESCRIPTION**                               |
| -------------------------------- | ------------------------ | --------------------------------------------- |
| `[BASE]`                         | `[rdx]`                  | Base register only                            |
| `[DISPLACEMENT]`                 | `[0F3h]` or `[variable]` | Displacement (literal or label)               |
| `[BASE + DISPLACEMENT]`          | `[rcx + 0x33]`           | Base plus displacement                        |
| `[BASE + INDEX]`                 | `[rax + rcx]`            | Base plus index (same size: 64-bit)           |
| `[INDEX * SCALE]`                | `[rbx * 4]`              | Index times scale (no base or displacement)   |
| `[INDEX * SCALE + DISPLACEMENT]` | `[rsi * 8 + 65]`         | Index times scale plus displacement           |
| `[BASE + INDEX * SCALE]`         | `[rsp + rdi * 2]`        | Base plus index times scale                   |
| `[BASE + INDEX * SCALE + DISP]`  | `[rsi + rbp * 4 + 9]`    | Base plus index times scale plus displacement |

---

### ⚠️ Key Rules Recap

* ✅ **All registers must be the same size**: either all 32-bit or all 64-bit.
* ❌ **Do not mix sizes**, e.g., `[rax + ecx]` is invalid (64-bit + 32-bit).
* ✅ You **can omit any component** (base, index, scale, displacement).
* ✅ Allowed scale values: `1`, `2`, `4`, or `8` only.
* ❌ You **cannot use 8-bit or 16-bit registers** in effective addresses.

---

Would you like this formatted for a Markdown document or a printable cheatsheet?
