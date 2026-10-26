# Brew-libre

[Español](README.md) · **English**

A free brewing recipe book for homebrewers: an installable web app (PWA) in English and Spanish, using metric units. No account and no cloud: recipes are saved as `.json` files on your own device, and it works offline.

**Use it:** https://morkx.github.io/brew-libre/

## Features

- Recipe design for All Grain, BIAB and Extract, with BJCP 2021 style guidelines (including regional styles) and AHA/BA styles.
- OG, FG, ABV, IBU (Tinseth, Rager, Garetz) and color (Morey, Daniels, Mosher) in SRM, EBC or °L; gravity in SG, °Plato or °Brix.
- Searchable database of commercial ingredients (malts by maltster, hops, yeasts).
- Water: enter lab reports in any unit, mash pH estimate, salt and acid additions (lactic or citric).
- Mash and decoction, refractometer correction (Terrill / Novotný), carbonation with priming sugar or in a keg.
- Commercial equipment profiles (BrewZilla, Grainfather, Anvil Foundry…) with automatic recipe rescaling.
- Shopping list, printing, and BeerXML import/export.
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

## Structure

| File | Purpose |
|---|---|
| `index.html` | The whole app (a single file) |
| `manifest.webmanifest` | Data for installing it as an app |
| `sw.js` | Service worker: offline use |
| `icons/` | App icons |
| `recetas/` | Recipes to import |

When you change `index.html`, bump `VERSION` in `sw.js` so installed copies update.

## Publishing on GitHub Pages

Settings → Pages → Source: "Deploy from a branch" → branch `main`, folder `/ (root)`.

## License

Brew-libre is free software: you can use, study, modify and redistribute it under the terms of the [GNU General Public License, version 3](LICENSE) or (at your option) any later version. Modified versions you distribute must keep the same license and publish their source code.

Copyright © 2026 Sebastián Valenzuela.

## Support the project

Brew-libre is free. If you find it useful, you can contribute from the "About…" tab in the app.

Contact: Sebastián Valenzuela — sebadarva@gmail.com
