const { app, BrowserWindow } = require('electron');
const path = require('path');

// Optional: use more memory (run with npm run start:heavy or set below to e.g. 4096)
const MAX_OLD_SPACE = process.argv.includes('--js-flags') ? null : 4096;
if (MAX_OLD_SPACE) {
  app.commandLine.appendSwitch('js-flags', `--max-old-space-size=${MAX_OLD_SPACE}`);
}

function createWindow() {
  const win = new BrowserWindow({
    width: 1280,
    height: 800,
    title: 'Sandboxles',
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
    },
  });

  win.loadFile(path.join(__dirname, 'sandbox.html'));
  win.setMenuBarVisibility(false);
}

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) createWindow();
});
