# dotfiles

# Map Caps -> CTRL on Windows:
```
New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout' -Name "Scancode Map" -PropertyType Binary -Value ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x1d,0x00,0x3a,0x00,0x00,0x00,0x00,0x00)) -Force
```
or
```
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout' -Name 'Scancode Map' -Type Binary -Value ([byte[]](0,0,0,0,0,0,0,0,2,0,0,0,29,0,58,0,0,0,0,0))
```
# Map Caps -> CTRL on Linux:
```
echo -e "[ids]\n*\n\n[main]\ncapslock = leftcontrol" | sudo tee /etc/keyd/default.conf >/dev/null && sudo systemctl enable --now keyd
```
 22984206+CODESOLE@users.noreply.github.com
