# Windows WSL VS Code Context Menu

Adds **Open VS Code here in WSL** to the Windows File Explorer context menu. It opens the selected folder in your default WSL distribution and starts VS Code with `code .`.

It does not install a startup app, service, or background process. The command runs only when you click the menu item.

## Requirements

- Windows with WSL installed and a default Linux distribution configured
- Visual Studio Code
- VS Code's WSL support installed and working (the `code` command must work in WSL)

## Install

Run PowerShell from this folder:

```powershell
.\install.ps1
```

The entry is added for both:

- a folder that you right-click
- empty space inside a folder

On Windows 11, legacy registry menu entries normally appear under **Show more options**.

## Uninstall

```powershell
.\uninstall.ps1
```

## Verify WSL support

In a WSL terminal, run:

```bash
code .
```

If that opens VS Code correctly, the Explorer command will use the same setup.

## How it works

The installer writes per-user context-menu registry keys under `HKCU\Software\Classes`. Selecting the command invokes:

```text
wsl.exe --cd "<selected-folder>" code .
```

No administrator permission is required.
