# nvim enviroment setup guideline

## Process to install/configure nvim on macOS

### Install lazy.nvim
```
$ git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/lazy/start/lazy.nvim
```

### Create init.vim
```
$ mkdir ~/.config/nvim
$ cp ./init.vim ~/.config/nvim/init.vim
```

### Open & Inialize lazy.nvim
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

## Usage and shortcuts of nvim

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

## ✅ Next Steps: Language-specific Setup

Below are the clear next steps for building a **full development + test + debug** environment for each stack.

---

### 1️⃣ **Node.js (Express)**

**Goal:**  
- LSP auto-completion  
- ESLint / Prettier integration (optional)  
- Unit test runner (e.g. Jest)  
- Debugging (DAP)

**Steps:**  
1. Open `:Mason` and install:
   - `tsserver` (for JavaScript/TypeScript)
   - `eslint` (optional, if you want inline linting)

2. Add to `init.vim`:
   ```lua
   require('lspconfig').tsserver.setup{}
   ```

3. For debugging:

   * Install `mfussenegger/nvim-dap`
   * Add `nvim-dap` config for Node.js (e.g. `vscode-node-debug2`)

4. Write unit tests (Jest) in your project, then run them in a split terminal or using `vim-test` plugin if you prefer.

---

### 2️⃣ **Python**

**Goal:**

* LSP auto-completion
* Black / Pylint integration (optional)
* Unit test runner (pytest)
* Debugging (DAP)

**Steps:**

1. Open `:Mason` and install:

   * `pyright` (Python LSP)

2. Add to `init.vim`:

   ```lua
   require('lspconfig').pyright.setup{}
   ```

3. For debugging:

   * Install `mfussenegger/nvim-dap`
   * Install `debugpy` in your Python env:

     ```bash
     pip install debugpy
     ```

4. Write `pytest` tests and run them in a terminal or integrate `vim-test`.

---

### 3️⃣ **Java (Spring Boot)**

**Goal:**

* LSP auto-completion
* Maven/Gradle support (managed outside Neovim)
* Unit test runner (JUnit)
* Debugging (DAP)

**Steps:**

1. Open `:Mason` and install:

   * `jdtls` (Java LSP)

2. Add to `init.vim`:

   ```lua
   require('lspconfig').jdtls.setup{}
   ```

3. For debugging:

   * Install `mfussenegger/nvim-dap`
   * Setup Java debug adapter (`vscode-java-debug`)

4. Run Maven/Gradle tests from terminal or via external tooling.

---

## 🔗 Optional Recommended Plugins for Debugging (DAP)

```lua
{
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "williamboman/mason-nvim-dap.nvim",
}
```

---

## ✅ General Tips

* Always use `:Mason` to manage LSP servers and debug adapters.
* Formatters like Prettier, Black, ESLint are usually installed **per project** (use `npm` / `pip`).
* Keep `tmux` or `split` open for test runs if you don't want test plugins.
* Use `Telescope` for fuzzy search and `live_grep` for full-text search.

