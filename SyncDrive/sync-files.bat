@echo off
setlocal

:: Configuration
set "SOURCE_DIR=D:" :: Change D: to your Local Drive's letter
set "DEST_DIR=H:"  :: Change H: to your external SSD's letter

:: Create timestamp (YYYY-MM-DD_HHMM format)
for /f "tokens=1-4 delims=/ " %%a in ("%date%") do (
    set "yy=%%d"
    set "mm=%%b"
    set "dd=%%c"
)
for /f "tokens=1-2 delims=:" %%a in ("%time%") do (
    set "hh=%%a"
    set "min=%%b"
)
set "LOG_FILE=C:/SyncDrive/Log/sync_log_%yy%-%mm%-%dd%_%hh%%min%.txt"  :: Change C:/SyncDrive/Log/ to your desired log directory

:: Robocopy flags
set "ROBOCOPY_FLAGS=/E /Z /FFT /R:3 /W:5 /NP /TEE /LOG+:%LOG_FILE%"

:: Send start notification
powershell -WindowStyle Hidden -command "New-BurntToastNotification -Text 'File Sync', 'Sync started between Local Disk and External SSD' -AppLogo 'C:\SyncDrive\sync-logo.png'"

echo ================================== >> "%LOG_FILE%"
echo Sync started at %date% %time% >> "%LOG_FILE%"

:: LocalDrive to External SSD
robocopy "%SOURCE_DIR%" "%DEST_DIR%" %ROBOCOPY_FLAGS%
powershell -WindowStyle Hidden -command "New-BurntToastNotification -Text 'File Sync', 'Sync.. (50%%) complete' -AppLogo 'C:\SyncDrive\sync-logo.png'"

:: External SSD to LocalDrive
robocopy "%DEST_DIR%" "%SOURCE_DIR%" %ROBOCOPY_FLAGS%

:: Send complete notification
powershell -WindowStyle Hidden -command "New-BurntToastNotification -Text 'File Sync', 'Sync completed successfully' -AppLogo 'C:\SyncDrive\sync-logo.png'"

echo Sync completed at %date% %time% >> "%LOG_FILE%"
echo ================================== >> "%LOG_FILE%"

endlocal
exit /b
