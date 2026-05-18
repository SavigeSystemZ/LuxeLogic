# Desktop Launcher Robustness Plan

## Background & Motivation
The desktop icon for LuxeLogic is failing to launch the application correctly. While the script works when run manually from a terminal, the desktop environment execution context (PATH, working directory, and shell behavior) often differs, causing silent failures. We need a "bulletproof" launcher that logs errors and provides visual feedback even when things go wrong.

## Proposed Solution
1. **Error Logging**: Implement a logging system in `luxelogic-launcher.sh` that redirects all output to `launcher.log`.
2. **Path Normalization**: Explicitly define the `PATH` within the script to include common binary locations.
3. **Persistence on Failure**: Add a `trap` that prevents the terminal window from closing immediately if an error occurs, allowing the user to read the error message.
4. **Desktop File Normalization**: Update the `.desktop` file to invoke the script via `bash` explicitly.

## Implementation Steps

### Step 1: Upgrade luxelogic-launcher.sh
- Add a log file path.
- Add `trap` to catch errors and wait for user input.
- Explicitly add `/usr/bin`, `/usr/local/bin`, and `$HOME/.local/bin` to `PATH`.
- Use `exec > >(tee -a "$LOG_FILE") 2>&1` to log everything.

### Step 2: Update LuxeLogic.desktop
- Change `Exec` to `bash -c "/home/whyte/.MyAppZ/LuxeLogic/luxelogic-launcher.sh"`.
- Ensure `Path=` is set to the project root.

### Step 3: installer.sh Update
- Ensure the installer correctly handles these new fields.

## Verification
- User will be asked to click the icon again.
- If it fails, they can check `launcher.log` in the project root.
