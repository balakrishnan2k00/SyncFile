# SyncFile
To Creating a windows pipeline sync between Local Drive and External Drive. A fully automated, bi-directional file sync system between your Local Drive folder (local disk) and an External Drive using a combination of batch scripting, PowerShell, BurntToast notifications, logging, and Task Scheduler.

---

## ✅ Overview

- Syncs files between LocalDrive and an external drive **in both directions**
- **No deletions** (non-mirroring)
- Sends **progress notifications**
- **Logs each sync run** into timestamped files
- Runs **silently in the background**
- Triggered automatically when the external drive is connected

---

## 🔧 Prerequisites

1. Windows 10 or 11
2. PowerShell 5.1+
3. Admin access to install modules and create tasks
4. Install [BurntToast module](https://github.com/Windos/BurntToast):

   Run in PowerShell:
   ```powershell
   Install-Module -Name BurntToast -Scope CurrentUser -Force

🛠 Folder Structure
Create a folder (e.g., C:\SyncDrive) and place:

sync-files.bat → Your batch file

run-sync.ps1 → PowerShell wrapper to call the batch

launch-hidden.vbs → Launches PowerShell silently

sync-logo.png → Custom icon for toast notifications

Output: Sync logs will be created here

🔁 Bi-Directional Sync Logic
Syncs LocalDrive → External Drive and External Drive → Local Drive

Only adds/updates files — nothing is deleted

Robocopy handles file and directory syncing with preserved structure


📄 Logging
Each sync generates a timestamped log file in the same folder. Example filename:

Copy
Edit
sync_log_2025-07-01_1830.txt
Log files include:

Start time

Files copied/updated

Completion time

🚀 Background Execution (No Popup)
To run PowerShell invisibly:

Create a .vbs launcher (launch-hidden.vbs)

Configure Task Scheduler to call that .vbs file

This ensures no PowerShell window pops up during sync.


💾 Use Event Viewer + Task Scheduler (USB Arrival Trigger)
Enable the Operational Log for device events:

Open Event Viewer

Navigate to:
Applications and Services Logs → Microsoft → Windows → DriverFrameworks-UserMode → Operational

Right-click → Enable Log

⏰ Task Scheduler Setup
Open Task Scheduler → Create Task

General tab:

Name: External Drive Sync

Run with highest privileges

Triggers tab:

Use “On an event” (Event ID 2003 from UserModeDriverFrameworks) or a custom USB drive detector

Actions tab:

Program/script: wscript.exe

Arguments: "C:\Path\To\launch-hidden.vbs"

Conditions tab:

Uncheck "Start the task only if the computer is on AC power" (optional)

Save and test

🚨 Manual Cancel
You can cancel the job manually from the task manager by killing the task "Microsoft Robocopy".

✅ Best Practices
Use short, clean folder paths

Test the sync manually before automating

Always back up before enabling automated file operations


🧼 Uninstalling
Remove scheduled task from Task Scheduler

Delete .bat, .ps1, .vbs files and logs

Uninstall BurntToast module (optional):

powershell command: Uninstall-Module BurntToast

🔚 Summary
This setup gives you a reliable, silent, and visual file sync solution with:

Bi-directional file updates

Safe exclusion rules

Progress awareness via toast notifications

Auto-triggered by external SSD insertion

You can customize nearly every part — icons, messages, rules, and logic.