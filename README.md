# Brew-libre

**Español** · [English](README.en.md)

Recetario cervecero libre para cerveceros caseros: una app web instalable (PWA), en español e inglés, con unidades métricas. No necesita cuenta ni nube: las recetas se guardan en archivos `.json` en tu propio equipo, y funciona sin conexión.

**Usarla:** https://morkx.github.io/brew-libre/

## Qué hace

- Diseño de recetas All Grain, BIAB y Extracto, con guías de estilo BJCP 2021 (incluye estilos regionales) y AHA/BA.
- OG, FG, ABV, IBU (Tinseth, Rager, Garetz) y color (Morey, Daniels, Mosher) en SRM, EBC o °L; densidad en SG, °Plato o °Brix.
- Base de ingredientes comerciales (maltas por maltería, lúpulos, levaduras) con buscador.
- Agua: análisis de laboratorio en cualquier unidad, pH de macerado, sales y ácido (láctico o cítrico).
- Macerado y decocción, refractómetro (Terrill / Novotný), carbonatación con azúcar o en barril.
- Equipos comerciales (BrewZilla, Grainfather, Anvil Foundry…) con reescalado automático.
- Lista de compras, impresión e importación/exportación BeerXML.
- Recetas prediseñadas 2026.

## Instalar

Abrí la dirección de arriba y:

- **Android (Chrome):** menú ⋮ → «Instalar app».
- **iPhone / iPad (Safari):** Compartir → «Agregar a pantalla de inicio».
- **PC (Chrome o Edge):** ícono de instalar en la barra de direcciones.

También podés descargar `index.html` y abrirlo con doble clic: funciona igual, sin instalar nada.

## Estructura

| Archivo | Para qué |
|---|---|
| `index.html` | La app completa (un solo archivo) |
| `manifest.webmanifest` | Datos para instalarla como app |
| `sw.js` | Service worker: funcionamiento sin conexión |
| `icons/` | Íconos de la app |

Al cambiar `index.html`, subí el número de `VERSION` en `sw.js` para que las copias instaladas se actualicen.

## Publicar en GitHub Pages

Settings → Pages → Source: «Deploy from a branch» → rama `main`, carpeta `/ (root)`.

## Licencia

Brew-libre es software libre: podés usarlo, estudiarlo, modificarlo y redistribuirlo bajo los términos de la [Licencia Pública General de GNU, versión 3](LICENSE) o (a tu elección) cualquier versión posterior. Las versiones modificadas que distribuyas deben mantener la misma licencia y publicar su código fuente.

Copyright © 2026 Sebastián Valenzuela.

## Apoyar el proyecto

Brew-libre es gratis. Si te sirve, podés colaborar desde la pestaña «Acerca de…» de la app.

Contacto: Sebastián Valenzuela — sebadarva@gmail.com
