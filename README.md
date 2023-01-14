# new_system_scripts

安装软件依靠 `winget` 命令，较新系统已自带。

## 基础脚本

### 安装内容

- Git
- VSCode
- [oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh)
  - Nerd Font: Meslo
  - [posh-git](https://github.com/dahlbyk/posh-git)
- [Scoop](https://github.com/ScoopInstaller/Scoop)

### 执行脚本

在终端（管理员）中运行

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/yuchenfei/new_system_scripts/blob/main/install_base.ps1'))
```

### 手动配置

oh-my-posh 主题在 `$profile` 文件中配置，具体参考文档：

- <https://ohmyposh.dev/docs/installation/customize>
- <https://ohmyposh.dev/docs/themes>

Windows Terminal 配置字体

```json
{
    "profiles":
    {
        "defaults":
        {
            "font":
            {
                "face": "MesloLGM NF"
            }
        }
    }
}
```

## 记录

执行脚本中某个函数

```powershell
. .\install_base.ps1
Update-EnvPath
```
