# Arch Config - Gemini Project Overview

This repository contains a modular configuration management system for Arch Linux and CachyOS, powered by a custom Lua-based tool called `dcli`. It manages system packages, host-specific configurations, services, and dotfiles synchronization.

## Architecture

The project is structured around **Hosts** and **Modules**:

- **Hosts (`hosts/`):** Define the specific configuration for a machine (e.g., `MohamedDesktop.lua`, `MohamedLaptop.lua`). A host configuration specifies which modules to enable, host-specific packages, default applications, and system-level settings like backup strategies (e.g., Snapper).
- **Modules (`modules/`):** Independent, reusable units of configuration. Each module (e.g., `modules/development/cli/module.lua`) defines a set of packages to install and can include a `dotfiles/` directory for automatic synchronization.
- **DCLI (`.lua/dcli.lua`):** The core Lua API providing access to system-level functionality such as hardware detection, package management, service control, and file operations.

## Key Files & Directories

- `config.lua`: The entry point that identifies the active host (usually via `dcli.system.hostname()`).
- `hosts/`: Contains machine-specific Lua configuration files.
- `modules/`: Contains modular package lists and dotfiles.
  - `modules/*/module.lua`: The Lua configuration for a specific module.
  - `modules/*/dotfiles/`: Directory containing dotfiles for the module.
- `.lua/dcli.lua`: Type definitions and documentation for the `dcli` API.
- `.pre-commit-config.yaml`: Configuration for local validation hooks.

## Building and Running

The project relies on the `dcli` tool (likely provided by the `dcli-arch-git` package found in `modules/base.lua`).

- **Synchronization:** To apply the configuration and synchronize dotfiles:
  ```bash
  # (Typical command for such tools, verify with --help)
  dcli sync
  ```
- **Local Validation:** Before committing, run pre-commit hooks:
  ```bash
  pre-commit run --all-files
  ```

## Development Conventions

- **Adding a New Host:** Create a new Lua file in `hosts/` named after the hostname and configure its `enabled_modules` and settings.
- **Creating a Module:** Add a directory in `modules/` with a `module.lua` that returns a table with `description`, `packages`, and optionally `dotfiles_sync = true`.
- **Dotfiles:** Place any configuration files in a `dotfiles/` subdirectory within a module. These will be synchronized to the user's home directory if `dotfiles_sync` is enabled.
- **Hardware-Specific Logic:** Use the `dcli.hardware` API in modules or host configs to conditionally add packages (e.g., GPU drivers, microcode).

## Validation & Quality Standards

The project maintains high quality through extensive automated checks:

- **Linting:** `yamlfix`, `actionlint`, `markdownlint`, `shellcheck`, and `pretty-format-json`.
- **Security:** `trufflehog` and `GitGuardian` for secret scanning, `DeepSource` for code quality and security.
- **Automation:** `Renovate` for dependency updates and `Mergify` for automated pull request management.
- **CI:** GitHub Actions are used for CI (`prek` hooks) and automatic application of fixes.
