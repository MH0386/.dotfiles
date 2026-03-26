# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A declarative Arch Linux / CachyOS configuration manager built in Lua 5.4. Uses a custom tool called `dcli` to manage packages, services, dotfiles, and host-specific settings. The entry point is `config.lua`, which resolves the active host and loads its configuration.

## Commands

```bash
dcli sync                        # Apply configuration, install packages, sync dotfiles
pre-commit run --all-files       # Run all validation hooks (yamlfix, shellcheck, lua-language-server, etc.)
pre-commit run <hook-id>         # Run a single hook (e.g., lua-language-server-check)
```

CI runs `prek` via GitHub Actions on push/PR to `main` and auto-commits any fixes.

## Architecture

**Three layers:**

1. **Hosts** (`hosts/*.lua`) — machine-specific configs. Each defines `enabled_modules`, per-host packages, `default_apps`, backup settings, and services. Active host is determined by `dcli.system.hostname()` in `config.lua`.

2. **Modules** (`modules/**/module.lua`) — reusable config units. Each returns a table with `description`, `packages`, and optionally `dotfiles_sync`, `services`, and `dotfiles` mappings. Modules can use `dcli` API calls for conditional logic (e.g., GPU-specific drivers).

3. **DCLI API** (`.lua/dcli.lua`) — type definitions and API reference. Available globally as `dcli` (configured in `.luarc.json` as a recognized global). Provides `dcli.hardware`, `dcli.system`, `dcli.package`, `dcli.file`, `dcli.env`, `dcli.service`, `dcli.power`, `dcli.security`, `dcli.desktop`, `dcli.boot`, `dcli.network`, `dcli.audio`, `dcli.storage`, `dcli.log`, and `dcli.util`.

## Module Structure

```
modules/<category>/<name>/
├── module.lua          # Returns: { description, packages, dotfiles_sync?, services?, dotfiles? }
└── dotfiles/           # Optional: synced to ~/ when dotfiles_sync = true
```

Module return table:

```lua
return {
    description = "Module description",
    packages = { "pkg1", "pkg2" },
    dotfiles_sync = true,                    -- sync dotfiles/ to ~/
    dotfiles = {                             -- explicit source→target mappings
        { source = ".claude", target = "~/.claude" }
    },
    services = { enabled = {}, disabled = {} }  -- optional
}
```

Top-level modules (`modules/base.lua`, `modules/hardware.lua`, `modules/gaming.lua`) are single files that use `dcli` APIs for conditional package lists (e.g., distro-specific packages, GPU drivers, microcode).

## Host Configuration

Host files return a table with: `host`, `description`, `enabled_modules` (array of module paths like `"development/ide/zed"`), `packages`, `exclude`, `services`, `default_apps`, `flatpak_scope`, `aur_helper`, `module_processing`, `config_backups`, `system_backups`.

## Development Conventions

- **Adding a module**: Create `modules/<path>/module.lua` returning the config table. Add to `enabled_modules` in relevant host files.
- **Adding a host**: Create `hosts/<Hostname>.lua`. The name must match `dcli.system.hostname()`.
- **Conditional logic**: Use `dcli.hardware`, `dcli.system.distro()`, etc. for hardware/distro-aware modules.
- **Dotfiles**: Place in module's `dotfiles/` subdirectory. Files in `dotfiles/` map to `~/.config/` or `~/` by default; use `dotfiles` table for explicit mappings.
- **Lua types**: Refer to `.lua/dcli.lua` for the full `dcli` API with LuaLS `@meta` type annotations. The language server is configured via `.luarc.json`.

## Pre-commit Hooks

Hooks enforce: YAML formatting (`yamlfix`), shell linting (`shellcheck`), Lua diagnostics (`lua-language-server-check`), JSON formatting, secret scanning (`trufflehog`), Markdown linting, GitHub Actions linting (`actionlint`), and Mergify/Renovate config validation. All configs live in `.github/lint/` and `.pre-commit-config.yaml`.
