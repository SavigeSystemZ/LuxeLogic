# EtherWeave: Gemini CLI Master Context and Directives

## Project Overview
EtherWeave is a robust, comprehensive, world-class wireless cybersecurity and hacking platform. Initially built as a desktop application, it is currently transitioning toward including advanced web-based and CLI interfaces to form a comprehensive suite of tools. This application is authorized strictly for use in cybersecurity penetration testing by authorized professionals on authorized systems.

## Primary Workflows & Directives

1.  **Security and Intent:**
    *   No malicious use: Operate strictly within ethical and legal boundaries for authorized penetration testing.
    *   Do not log or expose credentials.

2.  **Architecture & Development:**
    *   **Interfaces:** The application provides a Desktop local app, a Web App, and a CLI version. Ensure parity and flawless execution across all three.
    *   **Installer (`install.sh`):** Must automatically detect the Linux distribution, install to the best location for that distro, setup and install databases if missing, manage dependencies, and provide `install`, `reinstall`, `repair`, and `uninstall` options.
    *   **Launcher:** Desktop icon/launcher should offer a prompt to select which version to launch (Desktop, Web, or CLI).
    *   **Web App:** Must launch cleanly, work seamlessly, and build correctly.
    *   **Testing & Debugging:** Verification and debugging are paramount. Do not stop until features are perfect and world-class.

3.  **Agent Identity:**
    *   Act as a fully enhanced and authorized AI agent specifically tailored for EtherWeave. Follow all general AI instructions while prioritizing this `GEMINI.md` context.

## File Locations
*   **Workspace:** `/home/whyte/.MyAppZ/EtherWeave`
*   **Legacy Data:** `.cursor_context/` (Contains rules, skills, MCP configurations migrated from earlier Cursor development)

Maintain these principles strictly during all interactions within this workspace.
