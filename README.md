# SyncFile

A fully automated, bi-directional file sync system between your Local Drive (local disk) and an External Drive using batch scripting, PowerShell, BurntToast notifications, logging, and Task Scheduler.

---

## ✅ Overview

- **Bi-directional sync** between LocalDrive and an external drive
- **No deletions** (non-mirroring; only adds/updates files)
- **Progress notifications** via Windows Toast
- **Logs each sync run** into timestamped files
- **Runs silently in the background**
- **Auto-triggered** when the external drive is connected

---

## 🔧 Prerequisites

- Windows 10 or 11
- PowerShell 5.1+
- Admin access to install modules and create scheduled tasks
- [BurntToast PowerShell module](https://github.com/Windos/BurntToast)

  Install BurntToast by running:
  ```powershell
  Install-Module -Name BurntToast -Scope CurrentUser -Force
  ```

---

## 🗂️ Folder Structure

```
SyncDrive/
├── External Drive Sync.xml      # Task Scheduler XML definition
├── launch-hidden.vbs           # Launches PowerShell silently
├── run-sync.ps1                # PowerShell wrapper to call the batch
├── sync-files.bat              # Main batch sync script
├── sync-logo.png               # Icon for toast notifications
└── Log/
    └── *.txt                   # Timestamped sync logs
```

---

## 🔁 Bi-Directional Sync Logic

- Syncs **LocalDrive → External Drive** and **External Drive → LocalDrive**
- Uses `robocopy` for robust file and directory syncing (preserves structure)
- **No files are deleted** (safe, non-mirroring)
- Only new or updated files are copied in either direction

---

## 📄 Logging

- Each sync run generates a timestamped log file in `SyncDrive/Log/`
- Example: `sync_log_2025-07-01_1830.txt`
- Log includes:
  - Start time
  - Files copied/updated
  - Completion time

---

## 🚀 Background Execution (No Popup)

- PowerShell is launched invisibly using `launch-hidden.vbs`
- Task Scheduler is configured to call the `.vbs` file, ensuring no window pops up

---

## 💾 Event-Driven Automation

### Enable Device Event Logging

1. Open **Event Viewer**
2. Navigate to:  
   `Applications and Services Logs → Microsoft → Windows → DriverFrameworks-UserMode → Operational`
3. Right-click → **Enable Log**

### Task Scheduler Setup

1. Open **Task Scheduler** → **Create Task**
2. **General** tab:
   - Name: `External Drive Sync`
   - Run with highest privileges
3. **Triggers** tab:
   - Use **On an event** (Event ID 2003 from UserModeDriverFrameworks) or a custom USB drive detector
4. **Actions** tab:
   - Program/script: `wscript.exe`
   - Arguments: `"C:\SyncDrive\launch-hidden.vbs"`
5. **Conditions** tab:
   - (Optional) Uncheck "Start the task only if the computer is on AC power"
6. **Save** and test

---

## 🚨 Manual Cancel

- To cancel a running sync, open Task Manager and end the `Microsoft Robocopy` process.

---

## ✅ Best Practices

- Use short, clean folder paths (e.g., `C:\SyncDrive`)
- Test the sync manually before automating
- Always back up important data before enabling automated file operations

---

## 🧼 Uninstalling

1. Remove the scheduled task from Task Scheduler
2. Delete `.bat`, `.ps1`, `.vbs` files and logs from `SyncDrive`
3. Uninstall BurntToast module (optional):

   ```powershell
   Uninstall-Module BurntToast
   ```

---

## 🔚 Summary

This setup provides a reliable, silent, and visual file sync solution with:

- Bi-directional file updates
- Safe exclusion rules (no deletions)
- Progress awareness via toast notifications
- Auto-triggered by external SSD insertion
- Easy customization (icons, messages, rules, logic)

---

## 📬 Support & Customization

Feel free to customize any part of the workflow—icons, notification messages, sync rules, and logic—to fit your needs. For issues or suggestions, open an issue or pull request.