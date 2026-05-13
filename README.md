# qmi03's Neovim Configuration

[![Neovim](https://img.shields.io/badge/Neovim-0.9+-blueviolet)](https://neovim.io/)
[![Lazy.nvim](https://img.shields.io/badge/Lazy.nvim-orange)](https://github.com/folke/lazy.nvim)

This repository contains my personal Neovim configuration, powered by [Lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. It's built on top of [LazyVim](https://www.lazyvim.org/), a highly extensible Neovim setup, with custom tweaks for my workflow.

I previously managed this config via Nix for immutability, but frequent changes made it cumbersome. Now, it's a standalone, mutable setup. However, I still recommend using Nix for installing language servers and tools to avoid Mason.nvim overhead—check my [Nix dotfiles](https://github.com/qmi03/dotfiles/blob/master/modules/common/packages/configs/neovim/default.nix) for that.

## 🚀 Features

- **Plugin Management**: Lazy.nvim with locked versions for reproducibility.
- **LazyVim Base**: Pre-configured with extras (see `lazyvim.json`).
- **LSP Support**: Custom LSP configurations in the `lsp/` directory. No Mason.nvim—use Nix or manual installs.
- **Keymaps & Autocmds**: Defined in `lua/` for easy overrides.
- **Formatting & Linting**: Stylua for Lua, integrated pre-commit hooks.
- **UI Enhancements**: Themes, statusline, and UI plugins via LazyVim defaults.
- **Performance**: Lazy loading for faster startup.

## 📋 Requirements

- Neovim ≥ 0.9.0
- Git (for cloning and plugin installation)
- A terminal with Nerd Font support (recommended for icons)
- **Optional but Recommended**: Nix for LSP servers and tools (see [dotfiles link](https://github.com/qmi03/dotfiles/blob/master/modules/common/packages/configs/neovim/default.nix)).

## 🛠 Installation

1. **Backup your existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository** to your Neovim config directory:
   ```bash
   git clone https://github.com/qmi03/nvim.git ~/.config/nvim
   cd ~/.config/nvim
   ```

3. **Sync plugins** (Lazy will handle this on first launch, but you can run manually):
   ```bash
   nvim --headless -c 'autocmd User LazySync quitall' -c 'Lazy sync'
   ```

4. **Launch Neovim**:
   ```bash
   nvim
   ```
   - Plugins will install automatically on first run (may take 1-2 minutes).
   - Restart Neovim after installation.

5. **Set up LSPs via Nix** (optional, for full features):
   - Follow my [Nix Neovim module](https://github.com/qmi03/dotfiles/blob/master/modules/common/packages/configs/neovim/default.nix).
   - Or install servers manually (e.g., via `npm`, `brew`) and configure in `lsp/` files.

That's it! You should now have a fully functional setup. Run `:Lazy` inside Neovim to manage plugins.

## 🔧 Customization

This config follows LazyVim's structure for easy extension:

- **Options**: Edit `lua/config/options.lua` for global settings.
- **Keymaps**: Add/override in `lua/config/keymaps.lua`.
- **Plugins**: 
  - Core plugins in `lua/plugins/`.
  - Add new ones by creating files like `lua/plugins/my-plugin.lua`.
- **LSP**: Extend in `lsp/` directory (e.g., `lsp/rust.lua`).
- **Extras**: Modify `lazyvim.json` to toggle LazyVim extras.

After changes, restart Neovim or run `:source %` in `init.lua`.

## 📁 Directory Structure

```
.
├── .gitignore              # Git ignores
├── .pre-commit-config.yaml # Pre-commit hooks
├── .stylua.toml            # Lua formatter config
├── README.md               # This file
├── init.lua                # Bootstrap (Lazy setup)
├── lazy-lock.json          # Locked plugin versions
├── lazyvim.json            # LazyVim extras config
├── after/                  # After/ftplugin directory
├── lsp/                    # LSP configurations
└── lua/                    # Core config modules
    ├── config/             # Options, keymaps, autocmds
    ├── plugins/            # Plugin specs
    └── ...                 # Other modules
```

## 🤝 Contributing

- Fork the repo and open a PR for improvements.
- Report issues for bugs or suggestions.
- Style: Run `stylua` for Lua formatting and pre-commit hooks.

## 📄 License

MIT License - see [LICENSE](LICENSE) (or add one if missing).

---

Happy Vimming! If you have questions, open an issue. 🚀
(THIS README IS GENERATED WITH AI BECAUSE I WAS LAZY)
