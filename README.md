# Neovim Environment Setup Guide

## Process to install/configure Neovim on macOS

### Install lazy.nvim
```
$ git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/lazy/start/lazy.nvim
```

### Create init.vim
```
$ mkdir ~/.config/nvim
$ cp ./init.vim ~/.config/nvim/init.vim
```

### Open & Initialize lazy.nvim
```
$ nvim foo.txt
# and execute ":Lazy update" in the editor
```

### Install external dependency(macOS)
```
$ brew install ripgrep fd
```

### Install markdown library
```
$ nvim foo.md
# execute ":call mkdp#util#install()" in the editor
```

## Usage and shortcuts for Neovim

| Function | Key |
|-------------------------------|------------------|
| **Toggle file tree** | `F2` |
| **Toggle Undo Tree** | `F5` |
| **Toggle Markdown Preview** | `F6` (inside `.md` files) |
| **Next buffer** | `,n` |
| **Previous buffer** | `,p` |
| **New tab** | `<Leader>tn` |
| **Close all other tabs** | `<Leader>to` |
| **Close current tab** | `<Leader>tc` |
| **Move tab** | `<Leader>tm` |
| **Go to tab 1, 2, 3** | `<Leader>1`, `<Leader>2`, `<Leader>3` |
| **Horizontal split** | `<Leader>sh` |
| **Vertical split** | `<Leader>sv` |
| **Switch window left** | `Ctrl-h` |
| **Switch window down** | `Ctrl-j` |
| **Switch window up** | `Ctrl-k` |
| **Switch window right** | `Ctrl-l` |
| **Search files (Telescope)** | `<Leader>f` |
| **Search in file content (Telescope live grep)** | `<Leader>g` |

> **Note:** `<Leader>` is `\` by default.

---

## ✅ LSP Configuration Summary (Completed)

We have completed LSP configuration for three main languages, supporting **Node.js/TypeScript**, **Python**, and **Java (Spring Boot)** development.

### 🔧 Configured LSP Features

**Auto-installed LSP Servers:**
- `ts_ls` - TypeScript/JavaScript support
- `pyright` - Python support  
- `jdtls` - Java support

**LSP Keybindings:**
| Function | Keybinding | Description |
|----------|------------|-------------|
| Go to definition | `gd` | Jump to function/variable definition |
| Show documentation | `K` | Display hover documentation |
| Rename symbol | `<space>rn` | Smart rename variable/function |
| Code actions | `<space>ca` | Quick fixes, refactoring suggestions |
| Find references | `gr` | Find all reference locations |

**Auto-completion Features:**
- LSP-based intelligent completion
- Snippet expansion support
- Tab/Ctrl+n/p navigation for completion options
- Enter to confirm selection

### 📁 Project Setup Requirements

Ensure your project has appropriate root marker files:

**Node.js/TypeScript Projects:**
```bash
# Create package.json to activate TypeScript LSP
npm init -y
```

**Python Projects:**
```bash
# pyright auto-detects Python files, no special setup required
```

**Java Projects:**
```bash
# Create Maven or Gradle project structure
# jdtls auto-detects pom.xml or build.gradle
```

### 🚀 How to Use

1. Open any `.js/.ts/.py/.java` file
2. LSP will automatically start and provide intelligent completion
3. Use the keybindings above for code navigation and operations
4. Completion suggestions will appear automatically as you type

---

## ✅ Next Steps: Testing and Debugging Environment

LSP and auto-completion are complete! The next goal is to establish comprehensive **testing** and **debugging** environments for each language.

---

### 1️⃣ **Node.js Testing and Debugging**

**Remaining Goals:**  
- ESLint / Prettier integration (optional)  
- Unit test runner (Jest/Mocha)  
- Debugging (DAP)

**Suggested Steps:**  
1. Install ESLint/Prettier in project:
   ```bash
   npm install --save-dev eslint prettier
   ```

2. Install testing and debugging plugins:
   ```lua
   -- Add to lazy.nvim setup
   {"mfussenegger/nvim-dap"},
   {"rcarriga/nvim-dap-ui"},
   {"nvim-neotest/neotest"},
   ```

3. Configure Node.js debugger

---

### 2️⃣ **Python Testing and Debugging**

**Remaining Goals:**
- Black / Pylint integration (optional)
- Unit test runner (pytest)
- Debugging (DAP)

**Suggested Steps:**

1. Install development tools:
   ```bash
   pip install black pylint pytest
   ```

2. Configure Python debugger:
   ```bash
   pip install debugpy
   ```

3. Add DAP configuration

---

### 3️⃣ **Java Testing and Debugging**

**Remaining Goals:**
- Maven/Gradle integration
- Unit test runner (JUnit)
- Debugging (DAP)

**Suggested Steps:**

1. Ensure project has `pom.xml` or `build.gradle`

2. Install Java debug adapter via Mason

3. Configure Spring Boot debugging environment

---

## 🔗 Recommended Testing and Debugging Plugins

```lua
-- Testing and debugging related plugins
{
  "mfussenegger/nvim-dap",           -- Core debug adapter
  "rcarriga/nvim-dap-ui",            -- Debug UI
  "williamboman/mason-nvim-dap.nvim", -- Mason DAP integration
  "nvim-neotest/neotest",            -- Test runner
  "vim-test/vim-test",               -- Alternative test runner
}
```

---

## ✅ General Tips

* Always use `:Mason` to manage LSP servers and debug adapters.
* Formatters like Prettier, Black, ESLint are usually installed **per project** (use `npm` / `pip`).
* Keep `tmux` or `split` open for test runs if you don't want test plugins.
* Use `Telescope` for fuzzy search and `live_grep` for full-text search.

