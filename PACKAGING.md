# Making Sandboxles a desktop app (more memory & CPU)

Running the game in a normal browser tab shares memory and CPU with other tabs and the browser. Packaging it as a **desktop app** gives it its own process so it can use more RAM and CPU.

## Electron app (included)

This project includes an Electron wrapper so you can run the sim as a desktop app with more memory.

### Easiest: run everything

**Double‑click `run-app.bat`** in the project folder. It will:
1. Install Node.js via winget if needed (you may get one UAC prompt).
2. Run `npm install` (downloads Electron on first run).
3. Start the app.

If Node is already installed, you can instead open a terminal in the project folder and run:
```bash
npm install
npm start
```
Uses a 4GB JS heap by default. For an explicit “heavy” run: `npm run start:heavy`.

Files: `main.js` (creates the window, loads `sandbox.html`), `package.json` (scripts + Electron dependency), `run-app.bat` (install Node + deps + launch).

## Other options (easiest → more control)

### 2. **Tauri** (smaller, faster)
- Uses the system WebView (e.g. Edge on Windows) instead of bundling Chromium.
- **Pros:** Much smaller app size, lower RAM, still a real window.
- **Cons:** Slightly more setup (Rust toolchain).
- **Rough steps:** Install Rust + Tauri CLI → `npm create tauri-app` (or add Tauri to an existing HTML project) → point it at your `sandbox.html`.

### 3. **PWA (Progressive Web App)**
- “Install” the page from the browser (Chrome: Install app).
- **Pros:** No extra framework; runs in its own window.
- **Cons:** Still the same browser engine and limits; doesn’t get a separate process with higher limits by default.

### 4. **Larger grid / higher FPS inside the same app**
- In `sandbox.html`, increase **W** and **H** (grid width/height) to use more cells and more CPU/memory.
- You can also expose a “Quality” or “Grid size” option and raise the simulation step count per frame to push the sim harder.

**Recommendation:** Use **Electron** if you want the least friction and are okay with a bigger app; use **Tauri** if you care about size and RAM. Both let the sim run as a real app and use more memory/CPU than a single tab.
