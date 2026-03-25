-- Host configuration for MohamedLaptop
-- My Laptop
-- See LUA-HOSTS.md for full documentation

local memory_mb = dcli.system.memory_total_mb()

dcli.log.info(string.format("Loading config for MohamedLaptop (%d MB RAM)", memory_mb))

-- ═══════════════════════════════════════════════════════════════════
-- MODULE SELECTION
-- ═══════════════════════════════════════════════════════════════════

local enabled_modules = {
    "base",
    "browsers",
    "desktop-environment/cosmic",
    "desktop-environment/gnome",
    "development/cli",
    "development/ide/antigravity",
    "development/ide/pycharm",
    "development/ide/vscode",
    "development/ide/zed",
    "development/programming/python",
    "development/programming/rust",
    "development/tools/docker",
    "development/tools/podman",
    "fonts",
    "office",
    "shells",
    "shells/bash",
    "shells/fish",
    "shells/nushell",
    "shells/xonsh",
    "shells/zsh",
    "terminal",
    "tiling-window-manager/desktop-shell/DankMaterialShell",
    "tiling-window-manager/hyprland",
    "tiling-window-manager/niri",
    "tools/ai",
    "tools/cli",
    "tools/gui",
    "tools/system",
    "hardware",
    "gaming",
    "system-packages-MohamedLaptop",
}

-- Example: Add GPU drivers based on hardware detection
-- if dcli.hardware.has_nvidia() then
--     table.insert(enabled_modules, "nvidia-drivers")
-- elseif dcli.hardware.has_amd_gpu() then
--     table.insert(enabled_modules, "amd-drivers")
-- end

-- Example: Add laptop-specific modules
-- if is_laptop then
--     table.insert(enabled_modules, "laptop-power")
-- end

-- ═══════════════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════════════

local services = {
    enabled = {},
    disabled = {},
}

-- Example: Enable docker if module is enabled
-- if dcli.util.contains(enabled_modules, "docker") then
--     table.insert(services.enabled, "docker.service")
-- end

-- ═══════════════════════════════════════════════════════════════════
-- RETURN CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════

return {
    host = "MohamedLaptop",
    description = "My Laptop",

    enabled_modules = enabled_modules,

    -- Host-specific packages (in addition to modules)
    packages = {},

    -- Packages to exclude from modules
    exclude = {},

    -- Services configuration
    services = services,

    -- Default applications
    default_apps = {
        browser = "firefox",
        terminal = "com.mitchellh.ghostty",
        text_editor = "dev.zed.Zed",
        file_manager = "org.gnome.Nautilus",
    },

    -- Settings
    flatpak_scope = "user",
    auto_prune = false,
    module_processing = "parallel",
    aur_helper = "paru",
    editor = "fresh",

    -- Backup settings
    config_backups = {
        enabled = true,
        max_backups = 5,
    },

    system_backups = {
        enabled = true,
        backup_on_sync = true,
        backup_on_update = true,
        tool = "snapper",
        snapper_config = "root",
    },
}
