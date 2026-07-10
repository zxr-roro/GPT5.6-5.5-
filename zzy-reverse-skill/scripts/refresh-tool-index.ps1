<#
.SYNOPSIS
Refresh the local reverse-skill tool index.

.DESCRIPTION
Root-level compatibility wrapper. The real implementation lives at:
  skills/scripts/refresh-tool-index.ps1

This wrapper keeps older README commands working while preserving the canonical
script location under skills/scripts/.
#>

[CmdletBinding()]
param(
    [string]$OutputMarkdown,
    [string]$OutputJson
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$target = Join-Path $repoRoot 'skills\scripts\refresh-tool-index.ps1'

if (-not (Test-Path -LiteralPath $target)) {
    throw "Missing canonical refresh script: $target"
}

$argsToForward = @()
if (-not [string]::IsNullOrWhiteSpace($OutputMarkdown)) {
    $argsToForward += @('-OutputMarkdown', $OutputMarkdown)
}
if (-not [string]::IsNullOrWhiteSpace($OutputJson)) {
    $argsToForward += @('-OutputJson', $OutputJson)
}

& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $target @argsToForward
exit $LASTEXITCODE
