# ⚡ Auto Accept Agent

**Tired of babysitting your AI?**

Auto Accept Agent automatically handles those repetitive "Accept", "Run", and "Confirm" actions so you can focus on the code, not the UI.

---

## 🎯 Supported Platforms

| Platform | Method | Setup Difficulty |
|----------|--------|------------------|
| **VS Code / Antigravity** | Extension (automatic) | ⭐ Easy |
| **Cursor IDE** | Script Injection | ⭐⭐ Medium |

---

## 📦 Installation

### For VS Code / Antigravity

1. Install from VS Code Marketplace: Search for `Auto Accept Agent`
2. Or install `.vsix` manually: Extensions → `...` → `Install from VSIX`
3. Click the status bar item to toggle ON/OFF

**That's it!** The extension automatically detects and accepts AI suggestions.

---

### For Cursor IDE (Script Injection)

Cursor's Composer UI doesn't expose commands to extensions, so we use **script injection** via the "Custom CSS and JS Loader" extension.

#### Step 1: Install Custom CSS and JS Loader

1. Open Cursor
2. Go to Extensions (Ctrl+Shift+X)
3. Search for **"Custom CSS and JS Loader"** by be5invis
4. Install it

#### Step 2: Save the Injection Script

1. Create a folder for scripts, e.g., `C:\Scripts\` (Windows) or `~/Scripts/` (Mac/Linux)
2. Copy `cursor-injection-script.js` from this extension to that folder
3. Note the full path, e.g., `C:\Scripts\cursor-injection-script.js`

#### Step 3: Configure Cursor Settings

1. Open Command Palette (Ctrl+Shift+P)
2. Type **"Open User Settings (JSON)"** and select it
3. Add this to your `settings.json`:

**Windows:**
```json
{
  "vscode_custom_css.imports": [
    "file:///C:/Scripts/cursor-injection-script.js"
  ]
}
```

**Mac/Linux:**
```json
{
  "vscode_custom_css.imports": [
    "file:///Users/yourname/Scripts/cursor-injection-script.js"
  ]
}
```

#### Step 4: Enable and Restart

1. Open Command Palette (Ctrl+Shift+P)
2. Run **"Enable Custom CSS and JS"**
3. **Restart Cursor** (close completely and reopen)
4. On Windows, you may need to run Cursor as Administrator

#### Step 5: Verify

- You should see a green **"⚡ AutoAccept"** indicator in the bottom-right corner
- Click it to toggle ON/OFF
- Use DevTools Console (Help → Toggle Developer Tools) for more controls:
  ```javascript
  autoAccept.start()   // Start
  autoAccept.stop()    // Stop
  autoAccept.toggle()  // Toggle
  autoAccept.status()  // Show stats
  ```

---

## ⚙️ How It Works

### VS Code Extension
- Polls for available accept commands every 300ms
- Executes registered VS Code commands like `editor.action.inlineSuggest.commit`
- Works with Antigravity, Copilot, and VS Code Chat

### Cursor Injection Script
- Injected at application startup via Custom CSS and JS Loader
- Scans DOM for buttons with text like "Accept", "Accept All", "Run"
- Simulates mouse events to click them
- Shows visual indicator for status

---

## 🔧 Troubleshooting

### Cursor: "Corrupt Installation" Warning
This is expected when using Custom CSS and JS Loader. The extension modifies Cursor's core files. Click "Don't Show Again" - it's safe.

### Cursor: Script Not Loading
1. Check the file path in settings.json (use forward slashes `/` even on Windows)
2. Make sure the path starts with `file:///`
3. Try running Cursor as Administrator
4. Re-run "Enable Custom CSS and JS" after updates

### Cursor: Need to Re-enable After Updates
Cursor updates may reset the injection. Just run "Enable Custom CSS and JS" again and restart.

---

## ⚠️ Disclaimer

**Use at your own risk.** Auto-accepting AI-generated code without review can introduce bugs. Best suited for:
- Small projects and prototypes
- Trusted AI models
- Development environments

Always review critical code changes manually.

---

## 📁 Files Included

| File | Purpose |
|------|---------|
| `extension.js` | Main VS Code extension |
| `cursor-injection-script.js` | Script for Cursor (via Custom CSS and JS Loader) |
| `cursor-console-script.js` | Alternative: paste directly into DevTools Console |

---

## 🙏 Credits

Cursor injection approach inspired by [TRUE YOLO MODE](https://github.com/ivalsaraj/true-yolo-cursor-auto-accept-full-agentic-mode) by @ivalsaraj.

---

## License

MIT
