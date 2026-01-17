exec($(carapace _carapace))
execx($(atuin init xonsh))
execx($(starship init xonsh))
execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')
