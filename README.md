# Map Caps -> CTRL on Windows:
```
New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Keyboard Layout' -Name "Scancode Map" -PropertyType Binary -Value ([byte[]](0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x1d,0x00,0x3a,0x00,0x00,0x00,0x00,0x00)) -Force

Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout' -Name 'Scancode Map' -Type Binary -Value ([byte[]](0,0,0,0,0,0,0,0,2,0,0,0,29,0,58,0,0,0,0,0))

Remove-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout' -Name 'Scancode Map'
```
# Map Caps -> CTRL on Linux:
```
echo -e "[ids]\n*\n\n[main]\ncapslock = leftcontrol" | sudo tee /etc/keyd/default.conf >/dev/null && sudo systemctl enable --now keyd

gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"
gsettings reset org.gnome.desktop.input-sources xkb-options
```
## remap Caps Lock to Control using udev hwdb rules

Remapping via `udev hwdb` (hardware database) operates directly at the kernel input layer (`evdev`). This means the change applies system-wide across all display servers (Wayland, X11), virtual consoles (TTYs), and desktop environments (GNOME, KDE, Sway, dwm).

---

### Step 1: Identify your keyboard's hardware identifier

Run `evtest` or `udevadm` to find your keyboard's vendor and product ID or input device node:

```bash
cat /sys/class/input/event*/device/modalias

```

For built-in AT keyboards (laptops), the default generic matcher is `evdev:atkbd:dmi:*`. For USB keyboards, it usually follows `evdev:input:b*v*p*`.

---

### Step 2: Create a custom hwdb rule file

Create a new file under `/etc/udev/hwdb.d/` (e.g., `90-custom-keyboard.hwdb`):

```bash
sudo nano /etc/udev/hwdb.d/90-custom-keyboard.hwdb

```

#### File Content (Caps Lock $\rightarrow$ Control)

```ini
# Match generic AT keyboards (e.g., laptop built-in keyboards)
evdev:atkbd:dmi:*
 KEYBOARD_KEY_3a=leftctrl

# Match all USB input devices
evdev:input:b*v*p*
 KEYBOARD_KEY_3a=leftctrl

```

> **Syntax Requirements:**
> * The `KEYBOARD_KEY_<scancode>` line **must start with a single leading space**.
> * Scancodes are in **hexadecimal** (without `0x`). Caps Lock scancode is `3a`.
> * Target key codes are in **lowercase** (`leftctrl`, `ctrl`, etc. matching Linux input event key names).
> 
> 

If you want to **swap** Caps Lock and Control instead:

```ini
evdev:atkbd:dmi:*
 KEYBOARD_KEY_3a=leftctrl
 KEYBOARD_KEY_1d=capslock

```

---

### Step 3: Compile hwdb and trigger udev

After saving the file, recompile the hardware database and reload the udev rules:

```bash
sudo systemd-hwdb update
sudo udevadm trigger

```

---

### Step 4: Verify the mapping

Run `evtest` or `wev` (on Wayland) or `xev` (on X11) and press Caps Lock. You should see it reporting `KEY_LEFTCTRL` (`29`) directly from the input subsystem.

---

### Quick Troubleshooting & Reverting

* **Target specific device only:** If you want to limit the rule to a specific USB keyboard (e.g., Vendor `046d`, Product `c52b`), format the header like this:
```ini
evdev:input:b0003v046DpC52B*

```


* **Reverting:** Remove `/etc/udev/hwdb.d/90-custom-keyboard.hwdb` and run `sudo systemd-hwdb update && sudo udevadm trigger`.

 22984206+CODESOLE@users.noreply.github.com
