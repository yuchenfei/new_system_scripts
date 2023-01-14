# 查询 https://winget.run/
$apps = @(
    # System Enhancement
    "Microsoft.PowerToys",
    "Lexikos.AutoHotkey",
    "QL-Win.QuickLook",
    # Tools
    "voidtools.Everything",
    "Bandisoft.Bandizip",
    "Bandisoft.Honeyview",
    "Daum.PotPlayer",
    "Bitwarden.Bitwarden",
    "Ghisler.TotalCommander",
    "SoftDeluxe.FreeDownloadManager",
    "PicGo.PicGo",
    "9P1WXPKB68KX", # Snipaste
    "9PKTQ5699M62", # iCloud
    # Application
    "Tencent.WeChat",
    "ByteDance.Feishu",
    "NetEase.MailMaster",
    "EuSoft.Eudic", # 欧路词典
    "Notion.Notion",
    "Obsidian.Obsidian",
    "EdrawSoft.MindMaster",
    # Game
    "Nvidia.GeForceExperience",
    "Valve.Steam"
)

Write-Host "Installing Software" -ForegroundColor Green
foreach ($app in $apps) {
    $queryApp = winget list -e -q $app
    if (![string]::Join("", $queryApp).contains($app)) {
        Write-Host ("Installing: " + $app) -ForegroundColor Green
        winget install -e --id $app --accept-package-agreements --accept-source-agreements --force
        Write-Host $_
    }
    else {
        Write-Host ("Skipping: " + $app + " (already installed)") -ForegroundColor Yellow
    }
}

# Install Scoop Scftware
scoop install geekuninstaller
scoop install spacesniffer
scoop install runcat
