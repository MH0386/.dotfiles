-- Base system packages
-- These packages are included regardless of host or modules
-- Uses Lua for conditional package selection based on hardware

local packages = {
    -- Essential base system
    "base",
    "base-devel",

    -- Kernel (uncomment the one you use)
    -- "linux",              -- Standard kernel
    -- "linux-zen",          -- Zen kernel (optimized for desktop)
    -- "linux-lts",          -- Long-term support kernel

    -- Firmware
    -- "linux-firmware",

    -- Basic tools
    -- "git",
    -- "vim",
    -- "neovim",
    -- "htop",
    "wget",
    "which",
    "vim",
    "damask-wallpaper",
    "dcli-arch-git",
    "xorg-xwayland",
    "xdg-user-dirs",
    "wpa_supplicant",
    "vlc-plugins-all",
    "ripgrep",
    "lua-language-server",
    "chaotic-keyring",
    "chaotic-mirrorlist"
}

if dcli.system.distro() == "cachyos" then
    table.insert(packages, "cachyos-hello")
    table.insert(packages, "cachyos-hooks")
    table.insert(packages, "cachyos-kernel-manager")
    table.insert(packages, "cachyos-keyring")
    table.insert(packages, "cachyos-micro-settings")
    table.insert(packages, "cachyos-mirrorlist")
    table.insert(packages, "cachyos-packageinstaller")
    table.insert(packages, "cachyos-plymouth-bootanimation")
    table.insert(packages, "cachyos-rate-mirrors")
    table.insert(packages, "cachyos-settings")
    table.insert(packages, "cachyos-snapper-support")
    table.insert(packages, "cachyos-v3-mirrorlist")
    table.insert(packages, "cachyos-v4-mirrorlist")
    table.insert(packages, "cachyos-wallpapers")
    table.insert(packages, "linux-cachyos")
    table.insert(packages, "linux-cachyos-headers")
    table.insert(packages, "linux-cachyos-lts")
    table.insert(packages, "linux-cachyos-lts-headers")
    table.insert(packages, "linux-cachyos-lts-nvidia-open")
    table.insert(packages, "linux-cachyos-nvidia-open")
end

-- Add CPU microcode based on vendor
local cpu = dcli.hardware.cpu_vendor()
if cpu == "intel" then
    dcli.log.info("Intel CPU detected - adding intel-ucode")
    table.insert(packages, "intel-ucode")
elseif cpu == "amd" then
    dcli.log.info("AMD CPU detected - adding amd-ucode")
    table.insert(packages, "amd-ucode")
end

return {
    description = "Base system packages",
    packages = packages,
}
