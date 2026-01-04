$CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
$COMPLETIONS_CONFIRM=True

exec($(carapace _carapace))
execx($(atuin init xonsh))
execx($(starship init xonsh))
execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')

aliases['pacman'] = 'pacman --color=always --needed'