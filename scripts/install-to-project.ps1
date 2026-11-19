<#
.SYNOPSIS
    Installs one or all Antigravity skills into a target project's .agents/skills/ directory.

.DESCRIPTION
    Copies or creates symbolic links for skills from this central library into the
    specified project repository so Antigravity can automatically discover and use them.

.PARAMETER SkillName
    The name of a specific skill folder to install (e.g. "git-workflow").

.PARAMETER All
    Switch to install all skills present in the skills/ directory.

.PARAMETER TargetProject
    Path to the target project directory.

.PARAMETER Symlink
    Switch to create directory symbolic links instead of copying files. Requires elevated permissions or Developer Mode enabled on Windows.

.EXAMPLE
    .\install-to-project.ps1 -SkillName "git-workflow" -TargetProject "C:\Projects\my-web-app"
    .\install-to-project.ps1 -All -TargetProject "D:\work\api-service" -Symlink
#>

[CmdletBinding(DefaultParameterSetName = "Single")]
param(
    [Parameter(Mandatory = $true, ParameterSetName = "Single", Position = 0)]
    [string]$SkillName,

    [Parameter(Mandatory = $true, ParameterSetName = "All")]
    [switch]$All,

    [Parameter(Mandatory = $true, Position = 1)]
    [string]$TargetProject,

    [Parameter(Mandatory = $false)]
    [switch]$Symlink
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceSkillsDir = Join-Path (Split-Path -Parent $scriptDir) "skills"

if (-not (Test-Path -Path $sourceSkillsDir)) {
    Write-Error "Source skills directory not found at: $sourceSkillsDir"
    exit 1
}

if (-not (Test-Path -Path $TargetProject)) {
    Write-Error "Target project directory does not exist: $TargetProject"
    exit 1
}

$destSkillsDir = Join-Path $TargetProject ".agents\skills"
if (-not (Test-Path -Path $destSkillsDir)) {
    New-Item -ItemType Directory -Path $destSkillsDir -Force | Out-Null
    Write-Host "Created destination folder: $destSkillsDir" -ForegroundColor Cyan
}

$skillsToInstall = @()
if ($All) {
    $skillsToInstall = Get-ChildItem -Path $sourceSkillsDir -Directory | Select-Object -ExpandProperty Name
} else {
    $skillsToInstall = @($SkillName)
}

foreach ($skill in $skillsToInstall) {
    $srcPath = Join-Path $sourceSkillsDir $skill
    $dstPath = Join-Path $destSkillsDir $skill

    if (-not (Test-Path -Path $srcPath)) {
        Write-Warning "Skill '$skill' not found at '$srcPath'. Skipping."
        continue
    }

    if (Test-Path -Path $dstPath) {
        Write-Host "Destination already exists: $dstPath. Replacing..." -ForegroundColor Yellow
        Remove-Item -Path $dstPath -Recurse -Force
    }

    if ($Symlink) {
        New-Item -ItemType SymbolicLink -Path $dstPath -Target $srcPath | Out-Null
        Write-Host "Linked skill: $skill -> $dstPath" -ForegroundColor Green
    } else {
        Copy-Item -Path $srcPath -Destination $dstPath -Recurse -Force
        Write-Host "Installed skill: $skill -> $dstPath" -ForegroundColor Green
    }
}

Write-Host "Installation complete! Antigravity will detect these skills in $TargetProject." -ForegroundColor Green
