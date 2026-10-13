[CmdletBinding(SupportsShouldProcess)]
param()

$ErrorActionPreference = 'Stop'

$verbName = 'OpenVSCodeHereInWSL'
$menuText = 'Open VS Code here in WSL'
$wslExe = Join-Path $env:SystemRoot 'System32\wsl.exe'
$codeExe = Join-Path $env:LOCALAPPDATA 'Programs\Microsoft VS Code\Code.exe'
$targets = @(
    'HKCU:\Software\Classes\Directory\Background\shell',
    'HKCU:\Software\Classes\Directory\shell'
)

if (-not (Test-Path -LiteralPath $wslExe)) {
    throw "WSL was not found at $wslExe. Install WSL first."
}

foreach ($target in $targets) {
    $verbKey = Join-Path $target $verbName
    $commandKey = Join-Path $verbKey 'command'

    if ($PSCmdlet.ShouldProcess($verbKey, "Add '$menuText' context-menu entry")) {
        New-Item -Path $commandKey -Force | Out-Null
        Set-Item -Path $verbKey -Value $menuText

        if (Test-Path -LiteralPath $codeExe) {
            New-ItemProperty -Path $verbKey -Name 'Icon' -Value $codeExe -PropertyType String -Force | Out-Null
        }

        # %V is replaced by Explorer with the selected/current folder.
        Set-Item -Path $commandKey -Value ('"{0}" --cd "%V" code .' -f $wslExe)
    }
}

Write-Host "Installed: $menuText"
Write-Host 'Right-click a folder (or its empty background) and choose the new command.'
Write-Host 'On Windows 11, choose "Show more options" if it is not in the compact menu.'
