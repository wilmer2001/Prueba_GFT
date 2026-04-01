import {
  setWorldConstructor,
  World,
  IWorldOptions,
  setDefaultTimeout,
  Before,
  After,
  Status
} from '@cucumber/cucumber';
import { Browser, BrowserContext, Page, chromium } from '@playwright/test';
import * as path from 'path';
import * as fs from 'fs';

// Timeouts globales configurados en el World
setDefaultTimeout(30 * 1000);

export class CustomWorld extends World {
  browser!: Browser;
  context!: BrowserContext;
  page!: Page;

  constructor(options: IWorldOptions) {
    super(options);
  }
}

setWorldConstructor(CustomWorld);

Before(async function (this: CustomWorld) {
  this.browser = await chromium.launch({ headless: true });

  // Video habilitado para cada scenario
  this.context = await this.browser.newContext({
    recordVideo: {
      dir: 'reports/videos/',
      size: { width: 1280, height: 720 }
    },
    viewport: { width: 1280, height: 720 }
  });

  this.page = await this.context.newPage();

  // Timeout de navegación global configurado en el World
  this.page.setDefaultNavigationTimeout(30 * 1000);
});

After(async function (this: CustomWorld, scenario) {
  // Screenshot automático solo cuando el test falle
  if (scenario.result?.status === Status.FAILED) {
    const screenshotDir = path.join('reports', 'screenshots');
    if (!fs.existsSync(screenshotDir)) {
      fs.mkdirSync(screenshotDir, { recursive: true });
    }

    // Sanitizar nombre de archivo: quitar comillas, espacios y caracteres especiales
    const sanitizedName = scenario.pickle.name
      .replace(/['"]/g, '')
      .replace(/\s+/g, '_')
      .replace(/[^a-zA-Z0-9_-]/g, '');

    const screenshotPath = path.join(screenshotDir, `${sanitizedName}.png`);
    await this.page.screenshot({ path: screenshotPath, fullPage: true });
  }

  await this.context.close();
  await this.browser.close();
});
