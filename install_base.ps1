# ---------------- Util Function ----------------

function query_app_existed($app_id) {
    $query = winget list -e -q $app_id
    if ([string]::Join("", $query).contains($app_id)) {
        return $true
    }
    else {
        return $false
    }
}

function Install-App($app_id) {
    if (!(query_app_existed($app_id))) {
        Write-Host ("Installing: " + $app_id) -ForegroundColor Green
        winget install -e --id $app_id
        return $true
    }
    else {
        Write-Host ("Skipping: " + $app_id + " (already installed)") -ForegroundColor Yellow
        return $false
    }
}

function Update-EnvPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# ---------------- Main Script ----------------

# Install Developer Tools
Install-App "Git.Git" | Out-Null
Install-App "Microsoft.VisualStudioCode" | Out-Null

# Install oh My Posh
if (Install-App ("JanDeDobbeleer.OhMyPosh")) {
    Update-EnvPath
    # Install font
    oh-my-posh font install Meslo
    # Install posh-git
    PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
    Add-PoshGitToProfile
    # Config profile
    Add-Content $PROFILE "`noh-my-posh init pwsh | Invoke-Expression"
}

# Install Scoop
Write-Host "Installing: Scoop" -ForegroundColor Green
Invoke-RestMethod get.scoop.sh | Invoke-Expression
Update-EnvPath
scoop bucket add extras