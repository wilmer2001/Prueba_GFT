# SauceDemo E2E — Playwright + Cucumber (TypeScript)

![TypeScript](https://img.shields.io/badge/TypeScript-5.4-blue?logo=typescript)
![Playwright](https://img.shields.io/badge/Playwright-1.44-green?logo=playwright)
![Cucumber](https://img.shields.io/badge/Cucumber-10.8-brightgreen?logo=cucumber)
![Node](https://img.shields.io/badge/Node-18%2B-339933?logo=node.js)

Prueba técnica GFT: automatización E2E del flujo de SauceDemo (login, carrito y checkout) con Playwright + Cucumber en TypeScript.

---

## Requisitos previos

- Node.js 18 o superior
- npm 9 o superior

---

## Instalación paso a paso

```bash
# 1. Clonar el repositorio
git clone <url-del-repositorio>
cd saucedemo-e2e-playwright-cucumber

# 2. Instalar dependencias
npm install

# 3. Instalar los navegadores de Playwright
npx playwright install chromium
```

---

## Cómo ejecutar los tests

### Todos los tests
```bash
npm test
```

### Solo los tests @smoke
```bash
npm run test:smoke
```

### Solo los tests @regression
```bash
npm run test:regression
```

### Solo los tests @negative
```bash
npm run test:negative
```

---

## Cómo abrir el reporte HTML

Después de ejecutar los tests, el reporte se genera en `reports/cucumber-report.html`:

```bash
# Windows
start reports/cucumber-report.html

# macOS
open reports/cucumber-report.html

# Linux
xdg-open reports/cucumber-report.html
```

---

## Evidencia de ejecución

Los videos `.webm` se generan automáticamente en `reports/videos/` durante cada ejecución (uno por escenario). No se suben al repositorio (ver `.gitignore`), pero se crean localmente al correr los tests:

```
reports/
├── videos/
│   ├── <hash>-Happy_Path.webm
│   ├── <hash>-Login_Fallido.webm
│   └── <hash>-Data_Driven_*.webm
├── screenshots/       ← Solo se generan cuando un test falla
└── cucumber-report.html
```

---

## Estructura del proyecto

```
├── features/
│   └── saucedemo.feature       # Escenarios Gherkin (Happy Path, Login Fallido, Data Driven)
├── src/
│   ├── pages/                  # Page Object Model
│   │   ├── LoginPage.ts
│   │   ├── InventoryPage.ts
│   │   ├── CartPage.ts
│   │   └── CheckoutPage.ts
│   ├── steps/
│   │   └── saucedemo.steps.ts  # Step definitions con TypeScript estricto
│   └── support/
│       └── world.ts            # CustomWorld: timeouts globales, video, screenshots
├── dataBase/
│   ├── schema.sql              # Creación de tablas (PostgreSQL 15)
│   ├── data.sql                # Datos de prueba (10+ registros por tabla)
│   └── queries.sql             # 5 queries SQL requeridas
├── reports/                    # Generado automáticamente
├── cucumber.js                 # Configuración de Cucumber (formato HTML, paths)
├── tsconfig.json
└── package.json
```

---

## Escenarios cubiertos

| # | Escenario | Tags | Descripción |
|---|-----------|------|-------------|
| 1 | Happy Path | `@smoke @critical` | Login válido → agregar producto → checkout completo |
| 2 | Login Fallido | `@negative @regression` | Usuario bloqueado → validación mensaje de error exacto |
| 3 | Data Driven | `@regression` | Scenario Outline con 3 usuarios distintos |

---

## Parte 2 — SQL

Los scripts SQL se encuentran en la carpeta `dataBase/`:

- **`schema.sql`** — Creación de esquema y tablas
- **`data.sql`** — Población con 10+ registros por tabla
- **`queries.sql`** — 5 queries de negocio

Motor: **PostgreSQL 15**
