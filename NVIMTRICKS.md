# Neovim

## **Neovim Hacks Cheat Sheet**  

```bash
# Run vim with no config
nvim -u NONE
```

### **🔹 File Navigation**
- `CTRL-^` (`SHIFT-CTRL-^`) → **Toggle between two files** quickly.  
- `@:` → **Repeat the last command** in normal mode without pressing `:` again.  

### **🔹 Efficient Text Manipulation**
- `"xp"` → **Exchange two characters** if the cursor is on the first character.  
- `"ddp"` → **Swap two lines** when the cursor is on the upper line.  
- `"deep"` → **Swap two words** when the cursor is on the space preceding the first word.  
- `"yl"` → **Yank a single character** (like `yy` yanks an entire line).  
- `"g~{motion}"` → **Toggle case** for selected `{motion}` text.  
- `"g~~"` → **Toggle case** for the entire current line.  
- `"gUU"` → **Make the current line uppercase**.  

### **🔹 Smart Copy & Put (paste)**
- `["x]zy"` → **Yank text in visual mode**, ensuring trailing spaces are left out.  
- `["x]zp"` → **Put (paste) yanked text** while preserving its original formatting.  
- `["x]gp"` → **Put (paste) and move the cursor after the inserted text**.  
  - _If you forgot `g`_, use `"[`, "`[`, `']`, or `']` to correct the cursor position.  
- `["x]]p` or `["x][p` → **Adjust the indentation** while pasting.  

### **🔹 Search & Replace with g[nN]**
- `"dgn"` → **Delete the next occurrence of the last search pattern match** (`*dgn*`).  
- Let's say you searched all occurence of `foo` and just updated it with the command `ciwbar` which changed it to `bar`. Then in **n mode** `cgn` will delete the next occurence and usher you in **i mode**. Again you enter `bar` to update the second occurence. Here comes the magic: to change all remaining occurence you just press `.` as many times as needed.

### **🔹 Autocomplete & Keywords**
- `CTRL-X CTRL-N` → **Autocomplete keywords from the current file** (`|i_CTRL-X_CTRL-N|`).  

### **🔥 Vim's Hidden Life-Saver: Rescuing Deleted Files**  

- If deleted files were open inside **Vim**, use this to recover them: `:bufdo w`
- `:ls` → This shows which files are **still loaded** in Vim’s memory.  

### **🔹 Insert surroundings**

You want to insert text right from the middle of surroundings `{}[]()...` ???

`|` is the final position of the cursor in insert mode.

```vim
(`i`): `<C-G>s<surrounding>` yields:
<surrounding> | <surrounding>

(`i`): `<C-G>S<surrounding>` yields:
<surrounding>
              |
<surrounding>
```


- `CTRL-X CTRL-N` → **Autocomplete keywords from the current file** (`|i_CTRL-X_CTRL-N|`).  

---

## **📝 Neovim `%` Modifiers Cheat Sheet**

### **🔹 Basic `%` Modifiers**
| Modifier | Description | Example (`chap09/hexdump/sandbox.asm`) | Output |
|-----------|----------------------|-----------------------------|----------------|
| `%`       | Full file path | `:echo expand("%")` | `chap09/hexdump/sandbox.asm` |
| `%:t`     | Tail (Filename only) | `:echo expand("%:t")` | `sandbox.asm` |
| `%:r`     | Root name (no extension) | `:echo expand("%:r")` | `chap09/hexdump/sandbox` |
| `%:e`     | Extension only | `:echo expand("%:e")` | `asm` |
| `%:p`     | Absolute path | `:echo expand("%:p")` | `/home/user/chap09/hexdump/sandbox.asm` |
| `%:p:h`   | Parent directory | `:echo expand("%:p:h")` | `/home/user/chap09/hexdump` |

---

### **🎯 Smart Combinations**
You can **chain multiple modifiers** together to customize filename extraction.

| Combination | Meaning | Example Output |
|--------------|----------------------|----------------|
| `expand("%:p:h:t")` | Get the **directory name** | `hexdump` |
| `expand("%:t:r")` | Get filename **without extension** | `sandbox` |
| `expand("%:p:h:h")` | Go **two levels up** | `chap09` |
| `expand("%:p:h:h:t")` | Get the **grandparent folder name** | `chap09` |

### **🔹 Practical Use Cases**
- Use `:echo expand("%:t")` to get **just the filename** in scripts.
- Use `:echo expand("%:p:h")` to reference the **parent directory** in file operations.
- Use `:echo expand("%:t:r")` for **auto-generating names** without extensions.

---

✅ **Echo command in Neovim's command mode (`:`) is super handy for testing filename manipulation!** 🚀  

### **🔹 Debugging with verbose**

Totally understandable—Vim's mapping namespaces can be a bit obscure at first! Here's a quick cheat sheet you might like, especially since you work across multiple modes:

- `nmap` → normal mode mappings  
- `imap` → insert mode mappings  
- `vmap` → visual + select mode  
- `xmap` → visual-only  
- `omap` → operator-pending mode  
- `tmap` → terminal mode  
- `map` → all the above modes combined (can be noisy)

When debugging, `:verbose` with the **specific mode’s map** command is your best friend. And if a key isn’t bound because Lazy hasn’t loaded the plugin yet—that’s the trap! Load it first, then `:verbose nmap <leader>...` will tell the full story.

### **🔹 Extracting Messages**

Sometimes the need arises to copy the notification messages in vim cmd line bar.

Enter the command `:redir @+>` with the `+` register or any register you want to send messages to (the chevron `>` is optional). From then on until the end of the session all notification message is concatenated to that register.

If, as it's usually the case, you just need a punctual extraction, after running the `:redir @<register>` command, trigger messages with `:messages` command and terminate the redirection with `:redir END` command lest you want to collapse some register.

### **🔹 Useful Insert**

When you need to insert some computation while in `Insert Mode`: `CTRL-R`, `=`, e.g.: `5+6`, `<Enter>`

Insert the date from `bash` `date` command: `:read!date`, `<Enter>`

### **🔹 Force tab expansion**

`:%retab! 2`
