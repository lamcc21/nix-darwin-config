# Tmux User Guide

## What is Tmux?

Tmux (Terminal Multiplexer) lets you:
- Split your terminal into multiple panes
- Create multiple windows (like tabs)
- Detach/reattach sessions (keep programs running when you disconnect)
- Persist your work across terminal restarts

## Core Concepts

### Sessions
A session is a collection of windows. Think of it as a workspace.
- Sessions persist even if you close your terminal
- You can have multiple sessions running simultaneously

### Windows
Windows are like tabs in a browser. Each session can have multiple windows.

### Panes
Panes are splits within a window. You can divide a window into multiple panes to see different terminals side-by-side.

## Your Custom Configuration

**Prefix Key:** `Ctrl-a` (press and release, then press the next key)

In this guide, `prefix` means `Ctrl-a`.

## Getting Started

### Starting Tmux

```bash
# Start a new session
tmux

# Start a new session with a name
tmux new -s myproject

# List all sessions
tmux ls

# Attach to a session
tmux attach -t myproject

# Attach to the last session
tmux attach
```

### Detaching and Reattaching

```bash
# Detach from current session
prefix d

# Kill current session (close it completely)
prefix :kill-session
```

## Working with Panes

### Creating Panes

```bash
# Split horizontally (left/right)
prefix |

# Split vertically (top/bottom)
prefix -
```

### Navigating Panes

```bash
# Move to pane (vim-style)
prefix h  # left
prefix j  # down
prefix k  # up
prefix l  # right

# Or use arrow keys
prefix ←  # left
prefix →  # right
prefix ↑  # up
prefix ↓  # down

# Cycle through panes
prefix o
```

### Resizing Panes

```bash
# Resize panes (vim-style, repeatable)
prefix Ctrl-h  # resize left
prefix Ctrl-j  # resize down
prefix Ctrl-k  # resize up
prefix Ctrl-l  # resize right

# Toggle pane zoom (full screen for one pane)
prefix z
```

### Managing Panes

```bash
# Close current pane
exit
# or
prefix x  # (asks for confirmation)

# Show pane numbers (then press number to jump to it)
prefix q

# Convert pane to a new window
prefix !

# Rotate panes
prefix Ctrl-o
```

## Working with Windows

### Creating Windows

```bash
# Create new window
prefix c

# Close current window
exit
# or
prefix &  # (asks for confirmation)
```

### Navigating Windows

```bash
# Next window
prefix n

# Previous window
prefix p

# Select window by number
prefix 0-9

# List all windows (interactive)
prefix w

# Rename current window
prefix ,
```

## Sessions

```bash
# Detach from session
prefix d

# List sessions (interactive)
prefix s

# Rename session
prefix $

# Switch to last session
prefix L
```

## Copy Mode (Scrolling & Copying)

```bash
# Enter copy mode (vi-style)
prefix [

# In copy mode:
# - Use vim keys: h/j/k/l to move
# - Use / to search forward
# - Use ? to search backward
# - Press v to start selection
# - Press y to copy selection
# - Press q to exit copy mode

# Paste copied text
prefix ]
```

## Mouse Support

Your config has mouse support enabled! You can:
- Click to switch panes
- Click window names to switch windows
- Drag pane borders to resize
- Scroll with mouse wheel (auto-enters copy mode)
- Select text with mouse (auto-copies with tmux-yank plugin)

## Session Persistence

Your config has `resurrect` and `continuum` plugins:

```bash
# Sessions auto-save every 15 minutes
# Sessions auto-restore when you start tmux

# Manual save
prefix Ctrl-s

# Manual restore
prefix Ctrl-r
```

## Other Useful Commands

```bash
# Reload tmux config
prefix r

# Show keybindings
prefix ?

# Show clock
prefix t

# Command prompt
prefix :
# Then type tmux commands, e.g., "set mouse off"
```

## Common Workflows

### Development Workflow

```bash
# Start a named session for your project
tmux new -s myapp

# Create panes:
prefix |  # Split for editor
# Run: nvim src/main.rs

prefix -  # Split bottom for tests
# Run: cargo watch -x test

prefix c  # New window for server
# Run: cargo run
```

### Reconnecting After Closing Terminal

```bash
# Your work is still there!
tmux ls              # See available sessions
tmux attach -t myapp # Reconnect to your session
```

### Multiple Projects

```bash
# Create separate sessions
tmux new -s frontend
prefix d  # detach

tmux new -s backend
prefix d  # detach

# Switch between them
prefix s  # Interactive session picker
```

## Quick Reference Card

| Action | Command |
|--------|---------|
| **Sessions** |
| New session | `tmux new -s name` |
| List sessions | `tmux ls` |
| Attach to session | `tmux attach -t name` |
| Detach | `prefix d` |
| **Windows** |
| New window | `prefix c` |
| Next window | `prefix n` |
| Previous window | `prefix p` |
| Select window 0-9 | `prefix 0-9` |
| Rename window | `prefix ,` |
| **Panes** |
| Vertical split | `prefix \|` |
| Horizontal split | `prefix -` |
| Navigate (vim) | `prefix h/j/k/l` |
| Resize (vim) | `prefix Ctrl-h/j/k/l` |
| Zoom pane | `prefix z` |
| Close pane | `exit` or `prefix x` |
| **Other** |
| Copy mode | `prefix [` |
| Paste | `prefix ]` |
| Reload config | `prefix r` |
| Show bindings | `prefix ?` |

## Tips

1. **Naming is helpful**: Always name your sessions (`tmux new -s projectname`)
2. **One session per project**: Keep different projects in different sessions
3. **Use zoom**: `prefix z` to focus on one pane temporarily
4. **Sessions persist**: Your tmux sessions survive terminal closes/SSH disconnects
5. **Mouse helps**: Don't be afraid to use the mouse for clicking/resizing
6. **Start with basics**: Master panes and windows first, then explore advanced features

## Getting Help

```bash
# Show all keybindings
prefix ?

# Manual pages
man tmux

# From tmux command prompt
prefix :
# Then type: list-keys, list-commands, show-options, etc.
```

## Troubleshooting

### Colors look wrong
Make sure your terminal supports 256 colors and true color. Most modern terminals do.

### Prefix not working
Remember: Press `Ctrl-a`, release both keys, then press the next key.

### Vim navigation conflicts
If using vim, install vim-tmux-navigator plugin for seamless navigation between vim and tmux panes.

---

**Pro Tip:** Start simple! Just use `tmux`, create a few panes with `prefix |` and `prefix -`, navigate with `prefix h/j/k/l`, and detach with `prefix d`. Everything else will come naturally as you need it.
