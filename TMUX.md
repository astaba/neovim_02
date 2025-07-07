# **🟨 Tmux**

---

## **🔶 Tmux Shortcuts Cheat Sheet**  

---

### **🔹 Most Useful Commands**  
| Shortcut         | Action |
|-----------------|----------------------------------|
| `C-j ?`         | List key bindings |
| `C-j :`         | Prompt for a command |
| `C-j C`         | Customize options |
| `C-j f`         | Search for a pane |
| `C-j i`         | Display window information |
| `C-j r`         | Source config file |
| `C-j t`         | Show a clock |
| `C-j ~`         | Show messages |

### **🔹 Window Management**  
| Shortcut         | Action |
|-----------------|----------------------------------|
| `C-S-Left`      | Swap with previous window |
| `C-S-Right`     | Swap with next window |
| `C-j &`         | Kill current window |
| `C-j $`         | Rename current session |
| `C-j ,`         | Rename current window |
| `C-j .`         | Move the current window |
| `C-j c`         | Create a new window |
| `C-j n`         | Select the next window |
| `C-j p`         | Select the previous window |
| `C-j ' `        | Prompt for window index to select |
| `C-j !`         | Break pane to a new window |
| `C-j w`         | Choose a window from a list |

### **🔹 Direct Window Selection**  
| Shortcut         | Action |
|-----------------|----------------------------------|
| `C-j 0`         | Select window 0 |
| `C-j 1`         | Select window 1 |
| `C-j 2`         | Select window 2 |
| `C-j 3`         | Select window 3 |
| `C-j 4`         | Select window 4 |
| `C-j 5`         | Select window 5 |
| `C-j 6`         | Select window 6 |
| `C-j 7`         | Select window 7 |
| `C-j 8`         | Select window 8 |
| `C-j 9`         | Select window 9 |

### **🔹 Pane Management**  
| Shortcut         | Action |
|-----------------|----------------------------------|
| `C-j "`         | Split window **vertically** |
| `C-j %`         | Split window **horizontally** |
| `C-j Space`     | Select next layout |
| `C-j x`         | Kill the active pane |
| `C-j z`         | Zoom the active pane |
| `C-j {`         | Swap the active pane with the pane above |
| `C-j }`         | Swap the active pane with the pane below |
| `C-j E`         | Spread panes out evenly |
| `C-j o`         | Select the next pane |
| `C-j M-o`       | Rotate through the panes **in reverse** |
| `C-j y`         | Toggle synchronize panes |

### **🔹 Session Management**  
| Shortcut         | Action |
|-----------------|----------------------------------|
| `C-j s`         | Choose a session from a list |
| `C-j D`         | Choose and detach a client from a list |
| `C-j d`         | Detach the current client |
| `C-j L`         | Switch to the last client |
| `C-j ( `        | Switch to previous client |
| `C-j ) `        | Switch to next client |

#### **From The Shell CLI**

```bash
tmux list-sessions
# replace session_name by the left-most name in the list
tmux new -s session_name
tmux attach -t session_name
tmux kill-session -t session_name
```

#j## **🔹 Clipboard & Paste Buffers**  
| Shortcut         | Action |
|-----------------|----------------------------------|
| `C-j [`         | Enter copy mode |
| `C-j PPage`     | Enter copy mode and scroll up |
| `C-<Space>`     | **In COPY MODE:** Enter highlight selection mode |
| `C-W`           | **In COPY MODE:** Yank (copy) |
| `C-j ]`         | Paste the most recent paste buffer |
| `C-j #`         | List all paste buffers |
| `C-j -`         | Delete the most recent paste buffer |
| `C-j =`         | Choose a paste buffer from a list |
| `C-j C-p`       | Paste and run (if EOL included).|

>**WARNING:** As you paste with this command in tmux, each new line character is interpreted by the shell and inmmediately run before doing the same for the next line. **Potentially wrecking havoc in your shell**

### **🔹 Navigation & Selection**

| Shortcut         | Action |
|-----------------|----------------------------------|
| `C-j h`         | Select left pane |
| `C-j j`         | Select down pane |
| `C-j k`         | Select up pane |
| `C-j l`         | Select right pane |
| `C-j ;`         | Move to the previously active pane |
| `C-j Up`        | Select the pane above the active pane |
| `C-j Down`      | Select the pane below the active pane |
| `C-j Left`      | Select the pane to the left of the active pane |
| `C-j Right`     | Select the pane to the right of the active pane |

### **🔹 Resizing Panes**  
| Shortcut         | Action |
|-----------------|----------------------------------|
| `C-j M-Up`      | Resize the pane **up** by 5 |
| `C-j M-Down`    | Resize the pane **down** by 5 |
| `C-j M-Left`    | Resize the pane **left** by 5 |
| `C-j M-Right`   | Resize the pane **right** by 5 |
| `C-j C-Up`      | Resize the pane **up** |
| `C-j C-Down`    | Resize the pane **down** |
| `C-j C-Left`    | Resize the pane **left** |
| `C-j C-Right`   | Resize the pane **right** |

### **🔹 Layout Selection**  
| Shortcut         | Action |
|-----------------|----------------------------------|
| `C-j M-1`       | Set **even-horizontal** layout |
| `C-j M-2`       | Set **even-vertical** layout |
| `C-j M-3`       | Set **main-horizontal** layout |
| `C-j M-4`       | Set **main-vertical** layout |
| `C-j M-5`       | Select **tiled** layout |

---

## **🔶 Tmux Commands Cheat Sheet**  

---

### **🔹 Session Management**  
| Command                  | Action |
|--------------------------|----------------------------------|
| `attach-session` (`attach`) | Attach to a tmux session |
| `detach-client` (`detach`) | Detach the current client |
| `kill-session` (`kill`) | Kill a tmux session |
| `has-session` (`has`) | Check if a session exists |
| `new-session` (`new`) | Start a new tmux session |
| `rename-session` (`rename`) | Rename the current session |
| `switch-client` (`switchc`) | Switch between tmux clients |
| `kill-server` | Kill the tmux server |
| `list-sessions` (`ls`) | List all tmux sessions |
| `lock-session` (`locks`) | Lock the session |
| `lock-client` (`lockc`) | Lock a client |

### **🔹 Window Management**  
| Command                  | Action |
|--------------------------|----------------------------------|
| `new-window` (`neww`) | Create a new window |
| `kill-window` (`killw`) | Kill the current window |
| `rename-window` (`renamew`) | Rename the current window |
| `select-window` (`selectw`) | Switch to a specific window |
| `next-window` (`next`) | Switch to the next window |
| `previous-window` (`prev`) | Switch to the previous window |
| `swap-window` (`swapw`) | Swap two windows |
| `move-window` (`movew`) | Move the current window |
| `unlink-window` (`unlinkw`) | Unlink a window |
| `link-window` (`linkw`) | Link a window to another session |
| `rotate-window` (`rotatew`) | Rotate windows in session |
| `list-windows` (`lsw`) | List all windows |

### **🔹 Pane Management**  
| Command                  | Action |
|--------------------------|----------------------------------|
| `split-window` (`splitw`) | Split window into panes |
| `kill-pane` (`killp`) | Kill the active pane |
| `swap-pane` (`swapp`) | Swap panes |
| `select-pane` (`selectp`) | Switch to a specific pane |
| `resize-pane` (`resizep`) | Resize the active pane |
| `pipe-pane` (`pipep`) | Pipe pane output to a command |
| `move-pane` (`movep`) | Move the current pane |
| `display-panes` (`displayp`) | Show pane numbers |
| `last-pane` (`lastp`) | Switch to last active pane |
| `list-panes` (`lsp`) | List all panes |
| `next-layout` (`nextl`) | Switch to next pane layout |
| `previous-layout` (`prevl`) | Switch to previous pane layout |

### **🔹 Clipboard & Buffers**  
| Command                  | Action |
|--------------------------|----------------------------------|
| `copy-mode` | Enter copy mode |
| `paste-buffer` (`pasteb`) | Paste from buffer |
| `delete-buffer` (`deleteb`) | Delete a buffer |
| `list-buffers` (`lsb`) | List all buffers |
| `save-buffer` (`saveb`) | Save buffer content to a file |
| `set-buffer` (`setb`) | Set buffer content manually |
| `show-buffer` (`showb`) | Show buffer content |

### **🔹 Key Bindings & Commands**

Tmux allows users to customize and manage keybindings for enhanced productivity. Here’s how the key commands work:

| Command                  | Description |
|--------------------------|----------------------------------|
| `bind-key` (`bind`) | **Bind a key to a tmux command** 🔹 This allows you to assign custom actions to specific keys inside tmux. For example, binding `Ctrl-b e` to open a split window vertically: `bind e split-window -v`. This makes navigation and management easier without manually typing tmux commands. |
| `unbind-key` (`unbind`) | **Remove an existing key binding** 🔹 If you want to free up a key that is already assigned to a tmux function, `unbind e` removes the `e` shortcut from tmux bindings. This is useful when customizing your workflow or resetting built-in key assignments. |
| `list-keys` (`lsk`) | **List all key bindings in tmux** 🔹 Running `list-keys` in command mode displays every active key binding, including default shortcuts and custom ones you've set up. If you've customized tmux bindings, this helps you track what keys do what. |
| `send-keys` (`send`) | **Send keystrokes to a pane** 🔹 This allows tmux to type commands into a pane automatically. For example, `send-keys 'ls -la' Enter` will send `"ls -la"` to the current pane and execute it. It’s useful for automation and scripting inside tmux without manual input. |
| `send-prefix` | **Send the tmux prefix key manually** 🔹 This command sends the tmux prefix (`Ctrl-b` by default) into a pane. It’s useful in cases where nested tmux sessions or unusual input handling requires manually triggering the prefix before another command. |

### **🔹 Customization & Options**  
| Command                  | Action |
|--------------------------|----------------------------------|
| `set-option` (`set`) | Set a tmux option |
| `show-options` (`show`) | Show tmux options |
| `set-window-option` (`setw`) | Set window-specific options |
| `show-window-options` (`showw`) | Show window options |
| `set-environment` (`setenv`) | Set environment variables |
| `show-environment` (`showenv`) | Show environment variables |
| `customize-mode` | Enter customization mode |
| `set-hook` | Set custom hooks for automation |

### **🔹 Display & Interface**  
| Command                  | Action |
|--------------------------|----------------------------------|
| `display-menu` (`menu`) | Show a menu with options |
| `display-message` (`display`) | Display a custom message |
| `display-popup` (`popup`) | Open a popup window |
| `display-panes` (`displayp`) | Show pane numbers |
| `choose-buffer` | Choose a buffer |
| `choose-client` | Choose a client |
| `choose-tree` | Visually browse sessions/panes |

### **🔹 Process & Shell Management**  
| Command                  | Action |
|--------------------------|----------------------------------|
| `run-shell` (`run`) | Run a shell command |
| `if-shell` (`if`) | Run a command conditionally |
| `refresh-client` (`refresh`) | Refresh tmux client UI |
| `lock-server` (`lock`) | Lock the tmux server |

---

## **🔶 Tmux configuration**

---

The config is sourced either from the `~/.tmux.conf` file, or from the `~/.tmux/` directory.

```tmux
# Initial setup
set -g status-keys vi

# use C-j as leader key and keep the default
set-option -g prefix C-j
set-option -g prefix2 C-b
unbind-key C-j
bind-key C-j send-prefix

# Set the base-index to 1 rather than 0
set -g base-index 1
set-window-option -g pane-base-index 1

# set-option -g status-position top

# Source config on the fly
unbind r
bind -N "source config file" r source-file ~/.tmux.conf \; display-message "tmux config RELOADED"

# enable mouse
set -g mouse on
set -g default-terminal xterm-256color

# Select pane
bind -N "select left pane" h select-pane -L
bind -N "select down pane" j select-pane -D
bind -N "select up pane" k select-pane -U
bind -N "select right pane" l select-pane -R

# Bind 'P' to paste from the system clipboard
bind-key C-p run "xclip -o -selection clipboard | tmux load-buffer - && tmux paste-buffer"

# ============================================================================
# Easily reorder windows with CTRL+SHIFT+Arrow
bind-key -n -N "swap with previous windows" C-S-Left swap-window -t -1
bind-key -n -N "swap with next windows" C-S-Right swap-window -t +1

# Synchronize panes
bind -N "toggle synchronize panes" y set-window-option synchronize-panes\; display-message "synchronize mode toggled."

# # Easy clear history
# bind-key L clear-history
# 
# # Key bindings for copy-paste
# setw -g mode-keys vi
# unbind p
# bind p paste-buffer
# bind-key -T copy-mode-vi 'v' send -X begin-selection
# bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel


# Lengthen the amount of time status messages are displayed
set-option -g display-time 3000
set-option -g display-panes-time 3000


# 
# 
# # Automatically set window title
# set-window-option -g automatic-rename on
# set-option -g set-titles on
# 
# 
# # Allow the arrow key to be used immediately after changing windows.
# set-option -g repeat-time 0
# 
# 
# No delay for escape key press
set -sg escape-time 0
# 
# 
# # Disable bell
# setw -g monitor-bell off
# 
# 
# # Disable visual text box when activity occurs
# set -g visual-activity off
# # ============================================================================

# INFO: Press <prefix>I to unstall all tmux plugins listed below

# List of plugins
set -g @plugin 'tmux-plugins/tpm'

set -g @plugin 'christoomey/vim-tmux-navigator'
# Configure the vim-navigator plugin
# set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
set -g @vim_navigator_mapping_left "C-j-h C-b-h"  # use C-h and C-Left
set -g @vim_navigator_mapping_right "C-j-l C-b-l"
set -g @vim_navigator_mapping_up "C-j-k C-b-k"
set -g @vim_navigator_mapping_down "C-j-j C-b-j"
set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding

set -g @plugin 'jimeh/tmux-themepack'
# Configure the tmux-themepack plugin
# set -g @themepack 'basic' (default)
# set -g @themepack 'powerline/block/blue'
set -g @themepack 'powerline/double/yellow'
# set -g @themepack 'powerline/default/green'
# set -g @themepack 'powerline/double/magenta'

set -g @plugin 'tmux-plugins/tmux-resurrect'
# Key bindings
# prefix + Ctrl-s - save
# prefix + Ctrl-r - restore

# set -g @plugin 'catppuccin/tmux#v2.1.0' # See https://github.com/catppuccin/tmux/tags for additional tags
# Configure the catppuccin plugin
# set -g @catppuccin_flavor "mocha"
# set -g @catppuccin_window_status_style "rounded"

# Other examples:
# set -g @plugin 'tmux-plugins/tmux-sensible'
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'github_username/plugin_name#branch'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'

```

If you don’t have a config file, you can create one using:

```bash
tmux show -g > ~/.tmux.conf
```
✅ This dumps the current tmux settings into a new config file.

---

