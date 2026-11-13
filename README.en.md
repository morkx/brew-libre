# Brew-libre

[Español](README.md) · **English**

A free brewing recipe book for homebrewers: an installable web app (PWA) in English and Spanish, using metric units. No account and no cloud: recipes are saved as `.json` files on your own device, and it works offline.

**Use it:** https://morkx.github.io/brew-libre/

## Features

- Recipe design for All Grain, BIAB and Extract, with BJCP 2021 style guidelines (including regional styles) and AHA/BA styles.
- OG, FG, ABV, IBU (Tinseth, Rager, Garetz) and color (Morey, Daniels, Mosher) in SRM, EBC or °L; gravity in SG, °Plato or °Brix.
- Searchable database of commercial ingredients (malts by maltster, hops, yeasts).
- Water: enter lab reports in any unit, mash pH estimate, salt additions and pH adjustment to a target from an estimated or measured pH (lactic, phosphoric or citric acid, also for the sparge water).
- Mash and decoction, refractometer correction (Terrill / Novotný), carbonation with priming sugar or in a keg.
- Commercial equipment profiles (BrewZilla, Grainfather, Anvil Foundry…) with automatic recipe rescaling.
- Shopping list, printing, and BeerXML import/export.
- Bottle label designer: front and back labels with the brewing data (ABV, IBU, OG/FG, colour, malts, hops, yeast, process, batch, dates and allergens detected from the recipe). Customise it with 12 outline shapes, 7 frame styles, 17 combinable geometric shapes (plus ready-made combinations), 17 free typefaces, palettes and your own colours, and a logo. Print on A4 with cut lines or export as 300 dpi PNG and SVG.
- Ready-made 2026 recipes.

The interface follows your browser's language (Spanish or English); you can switch it anytime with the **EN / ES** button at the top or in Preferences.

## Clone recipes

The [`recetas/`](recetas/) folder contains [`recetas-reales.json`](recetas/recetas-reales.json): 14 clone recipes published in Brew Your Own and Home Brew Answers, converted to metric. Each one cites its source in the notes (the recipe notes are in Spanish).

Sierra Nevada Pale Ale, Pliny the Elder, Pilsner Urquell, Guinness Draught, Westmalle Tripel, Fuller's ESB, Heady Topper, Hacker-Pschorr Dunkle Weisse and Hefe Weisse, Tipopils, Tree House Julius, Mexican Lager, Founders Breakfast Stout and Saison Dupont.

To load them: download the file and in the app use **More → Import recipes…**. They are added to "My recipes" without replacing yours.

## Install

Open the address above and:

- **Android (Chrome):** menu ⋮ → "Install app".
- **iPhone / iPad (Safari):** Share → "Add to Home Screen".
- **PC (Chrome or Edge):** click the install icon in the address bar.

You can also download `index.html` and open it with a double click: it works the same, nothing to install.

## Android app

The `android/` folder holds the Android project (built with [Capacitor](https://capacitorjs.com/)), which packages the whole app so it works offline. To build and sign the APK on Arch Linux:

```bash
bash build-apk.sh
```

The script installs JDK 21, Node and the Android SDK, copies the web app into the Android project and signs the APK with your release key, which is kept outside the repo. Before building a new version, run `version.sh` (see [Versions](#versions)): it bumps `versionCode` and `versionName` and creates the changelog at `fastlane/metadata/android/*/changelogs/<versionCode>.txt`.

Descriptions, icon and screenshots for F-Droid/IzzyOnDroid stores are in `fastlane/metadata/android/`.

## Structure

| File | Purpose |
|---|---|
| `index.html` | The whole app (a single file) |
| `manifest.webmanifest` | Data for installing it as an app |
| `sw.js` | Service worker: offline use |
| `icons/` | App icons |
| `recetas/` | Recipes to import |
| `fonts/` | Free typefaces for the label designer, with their licenses |
| `android/` | Android project (Capacitor) |
| `fastlane/` | Description, icon and screenshots for app stores |
| `build-apk.sh` | Builds and signs the APK on Arch Linux |
| `version.sh` | Bumps the version number in every file |
| `netlify.toml` | Settings for publishing on Netlify |

Every change to `index.html` ships as a new version (see [Versions](#versions)); that changes `VERSION` in `sw.js`, so installed copies update.

## Publishing

The app is a static site: any **https** server works, and over https it can be installed as an app and works offline.

### On Netlify (recommended)

The repo includes `netlify.toml`, which tells Netlify how to build and publish the app. Publishing builds a `www/` folder with only the web app files; the Android project and scripts are not uploaded.

**Connecting the repository** (updates automatically on every `git push`):

1. Sign in at [app.netlify.com](https://app.netlify.com) with your GitHub account.
2. **Add new site → Import an existing project → GitHub** and pick `morkx/brew-libre`.
3. Keep the settings Netlify reads from `netlify.toml` (build `npm run build`, folder `www`) and press **Deploy**.
4. Under **Site configuration → Change site name** you can choose the address, e.g. `brew-libre.netlify.app`.

**Without connecting the repository** (Netlify Drop):

```bash
npm run build
```

then drag the `www/` folder onto [app.netlify.com/drop](https://app.netlify.com/drop). To update, run `npm run build` again and drag it onto the site's **Deploys** tab.

### On GitHub Pages

Settings → Pages → Source: "Deploy from a branch" → branch `main`, folder `/ (root)`.

## Versions

Brew-libre uses [semantic versioning](https://semver.org/) `MAJOR.MINOR.PATCH`: the **patch** goes up for bug fixes, the **minor** for new features and the **major** if the recipe book format changes in an incompatible way. The version is shown in the About tab.

To release a version:

1. `bash version.sh 1.4.0` updates `package.json`, `index.html`, `sw.js` and `android/app/build.gradle`, and creates the Fastlane changelogs.
2. Write the changes below, in `README.md` and in the changelogs.
3. Commit, `git tag v1.4.0` and `git push --tags`.

### 1.3.1 — 2026-11-13
- About: donations via **Mercado Pago**; bank transfer details removed.

### 1.3.0 — 2026-11-10
- Water: new **pH adjustment** section. Editable target pH (previously fixed at 5.4), optional measured pH without acid instead of the estimate, phosphoric acid with editable concentration besides lactic and citric, and sparge water acid with its own target pH.
- Brew day steps, shopping list and printout include the sparge acid and the target pH.
- Version number shown in About, and a `version.sh` script.

### 1.2.0 — 2026-11-07
- **Print instructions** button: the brew sheet on one A4 page.

### 1.1.0 — 2026-11-05
- Bottle **label designer**: shapes, figures, typefaces and colours; Tropical template.
- About tab with links to the repository, license and bug reports.
- Netlify publishing.

### 1.0.0 — 2026-10-27
- First version: PWA, clone recipes to import and Android app with Capacitor.

## Credits

Brew-libre is based on the **Beer_calc v5.6** brewing spreadsheet (original author unknown; if you are the author, write to me so I can credit you properly). The calculation formulas, the original ingredient databases and the example recipe "Jambo Beer" come from it. The idea of turning it into a free app, the choice of features and the brewing know-how are by Sebastián Valenzuela, who also drew on his experience with proprietary brewing apps.

The code was written with AI assistance (Claude, by Anthropic).

The label designer's typefaces are free (SIL Open Font License, and Apache 2.0 for Roboto Slab); details and license texts are in [`fonts/`](fonts/README.md).

## License

Brew-libre is free software: you can use, study, modify and redistribute it under the terms of the [GNU General Public License, version 3](LICENSE) or (at your option) any later version. Modified versions you distribute must keep the same license and publish their source code.

Copyright © 2026 Sebastián Valenzuela.

## Support the project

Brew-libre is free. If you find it useful, you can contribute from the "About…" tab in the app.

Contact: Sebastián Valenzuela — sebadarva@gmail.com
