<#
.SYNOPSIS
    Generates a markdown changelog from Conventional Commits between Git tags or revisions.

.PARAMETER FromTag
    The starting tag or commit hash (exclusive). If omitted, defaults to the previous tag.

.PARAMETER ToTag
    The ending tag or commit hash (inclusive). Defaults to HEAD.

.PARAMETER OutputFile
    Optional file path to write the changelog to.
#>

param(
    [string]$FromTag,
    [string]$ToTag = "HEAD",
    [string]$OutputFile
)

$ErrorActionPreference = "Stop"

if (-not (git rev-parse --is-inside-work-tree 2>$null)) {
    Write-Error "Current directory is not inside a Git repository."
    exit 1
}

if (-not $FromTag) {
    $latestTag = git describe --tags --abbrev=0 2>$null
    if ($latestTag) {
        $FromTag = $latestTag.Trim()
    } else {
        $firstCommit = git rev-list --max-parents=0 HEAD
        $FromTag = $firstCommit.Trim()
    }
}

Write-Host "Extracting commits from $FromTag to $ToTag..." -ForegroundColor Cyan
$commitLines = git log "$FromTag..$ToTag" --pretty=format:"%s (%h)"

$features = @()
$fixes = @()
$performance = @()
$refactors = @()
$breaking = @()
$others = @()

foreach ($line in $commitLines) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }

    if ($line -match "BREAKING CHANGE" -or $line -match "^[a-z]+(\([^\)]+\))?!:") {
        $breaking += $line
    } elseif ($line -match "^feat(\([^\)]+\))?:\s*(.*)") {
        $features += $line
    } elseif ($line -match "^fix(\([^\)]+\))?:\s*(.*)") {
        $fixes += $line
    } elseif ($line -match "^perf(\([^\)]+\))?:\s*(.*)") {
        $performance += $line
    } elseif ($line -match "^refactor(\([^\)]+\))?:\s*(.*)") {
        $refactors += $line
    } else {
        $others += $line
    }
}

$sb = [System.Text.StringBuilder]::new()
[void]$sb.AppendLine("# Release Notes ($FromTag -> $ToTag)")
[void]$sb.AppendLine("Generated on $(Get-Date -Format 'yyyy-MM-dd')`n")

if ($breaking.Count -gt 0) {
    [void]$sb.AppendLine("### ⚠️ BREAKING CHANGES")
    foreach ($item in $breaking) { [void]$sb.AppendLine("- $item") }
    [void]$sb.AppendLine("")
}

if ($features.Count -gt 0) {
    [void]$sb.AppendLine("### ✨ Features")
    foreach ($item in $features) { [void]$sb.AppendLine("- $item") }
    [void]$sb.AppendLine("")
}

if ($fixes.Count -gt 0) {
    [void]$sb.AppendLine("### 🐛 Bug Fixes")
    foreach ($item in $fixes) { [void]$sb.AppendLine("- $item") }
    [void]$sb.AppendLine("")
}

if ($performance.Count -gt 0) {
    [void]$sb.AppendLine("### ⚡ Performance Improvements")
    foreach ($item in $performance) { [void]$sb.AppendLine("- $item") }
    [void]$sb.AppendLine("")
}

if ($refactors.Count -gt 0) {
    [void]$sb.AppendLine("### ♻️ Code Refactoring")
    foreach ($item in $refactors) { [void]$sb.AppendLine("- $item") }
    [void]$sb.AppendLine("")
}

$output = $sb.ToString()

if ($OutputFile) {
    Set-Content -Path $OutputFile -Value $output -Encoding UTF8
    Write-Host "Changelog written to: $OutputFile" -ForegroundColor Green
} else {
    Write-Output $output
}
