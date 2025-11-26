source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
   fastfetch -c ~/.config/fastfetch/greeting.jsonc
end

# uv
fish_add_path "/home/mohamed/.local/bin"

if status --is-interactive
    atuin init fish | source
end
