# ---------------- Util Function ----------------

function Find-AppExisted($app_id) {
    $query = winget list -e -q $app_id
    if ([string]::Join("", $query).contains($app_id)) {
        return $true
    }
    else {
        return $false
    }
}

function Install-App($app_id) {
    if (!(Find-AppExisted($app_id))) {
        Write-Host ("Installing: " + $app_id) -ForegroundColor Green
        winget install -e --id $app_id
    }
    else {
        Write-Host ("Skipping: " + $app_id + " (already installed)") -ForegroundColor Yellow
    }
}

function Update-EnvPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# ---------------- Main Script ----------------

# Accept source agreements
winget upgrade --accept-source-agreements

# Install Developer Tools
Install-App "Git.Git"
Install-App "Microsoft.VisualStudioCode"

# Install oh My Posh
if (!(Find-AppExisted("JanDeDobbeleer.OhMyPosh"))) {
    Write-Host ("Installing: oh My Posh") -ForegroundColor Green
    winget install -e --id JanDeDobbeleer.OhMyPosh
    Update-EnvPath
    # Install font
    oh-my-posh font install Meslo
    # Install posh-git
    Install-PackageProvider NuGet -Force
    Install-Module posh-git -Scope CurrentUser -Force
    Add-PoshGitToProfile
    # Config profile
    Add-Content $PROFILE "`noh-my-posh init pwsh | Invoke-Expression"
}

# Install Scoop
Write-Host "Installing: Scoop" -ForegroundColor Green
Invoke-RestMethod get.scoop.sh | Invoke-Expression
Update-EnvPath
scoop bucket add extras
