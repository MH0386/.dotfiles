# Force reload full PATH in any new session
$env:PATH = [Environment]::GetEnvironmentVariable("PATH","Machine") + ";" + [Environment]::GetEnvironmentVariable("PATH","User")

Invoke-Expression (&starship init powershell)
(& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
(& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression
(& atuin gen-completions -s powershell) | Out-String | Invoke-Expression

$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

$env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace | Out-String | Invoke-Expression

Invoke-Expression (& { (zoxide init powershell | Out-String) })