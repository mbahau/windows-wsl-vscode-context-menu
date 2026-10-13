[CmdletBinding(SupportsShouldProcess)]
param()

$ErrorActionPreference = 'Stop'
$verbName = 'OpenVSCodeHereInWSL'
$targets = @(
    'HKCU:\Software\Classes\Directory\Background\shell',
    'HKCU:\Software\Classes\Directory\shell'
)

foreach ($target in $targets) {
    $verbKey = Join-Path $target $verbName
    if ((Test-Path -LiteralPath $verbKey) -and $PSCmdlet.ShouldProcess($verbKey, 'Remove context-menu entry')) {
        Remove-Item -LiteralPath $verbKey -Recurse -Force
    }
}

Write-Host 'Removed: Open VS Code here in WSL'
