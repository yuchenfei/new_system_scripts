# ---------------- Util Function ----------------

function Check-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

function Update-EnvPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# ---------------- Main Script ----------------

# python
if (!(Check-Command "conda")) {
    winget install -e --id Anaconda.Miniconda3
}

# java
if (!(Check-Command "javac")) {
    winget install -e --id Oracle.JDK.17
}

# node.js
if (!(Check-Command "fnm")){
    # Install fnm
    scoop install fnm
    # Config profile for fnm
    $config = "fnm env --use-on-cd | Out-String | Invoke-Expression"
    $content = Get-Content $PROFILE
    if (!($content.contains($config))){
        Add-Content $PROFILE ("`n" + $config)
    }
    Update-EnvPath
    # Install lts node
    fnm install --lts
}
