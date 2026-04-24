-- Module manifest for system-packages-MohamedLaptop
return {
    description = "System packages for MohamedLaptop (auto-synced by dcli merge)",
    package_files = { "packages.lua" },
    hook_behavior = "ask",
    run_hooks_as_user = false,
}
