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

## Recetas clon

La carpeta [`recetas/`](recetas/) trae [`recetas-reales.json`](recetas/recetas-reales.json): 14 recetas clon publicadas en Brew Your Own y Home Brew Answers, convertidas a métrico. Cada una cita su fuente en las notas.

Sierra Nevada Pale Ale, Pliny the Elder, Pilsner Urquell, Guinness Draught, Westmalle Tripel, Fuller's ESB, Heady Topper, Hacker-Pschorr Dunkle Weisse y Hefe Weisse, Tipopils, Tree House Julius, Mexican Lager, Founders Breakfast Stout y Saison Dupont.

Para cargarlas: descargá el archivo y en la app usá **Más → Importar recetas…**. Se suman a «Mis recetas» sin reemplazar las tuyas.

## Instalar

Abrí la dirección de arriba y:

- **Android (Chrome):** menú ⋮ → «Instalar app».
- **iPhone / iPad (Safari):** Compartir → «Agregar a pantalla de inicio».
- **PC (Chrome o Edge):** ícono de instalar en la barra de direcciones.

También podés descargar `index.html` y abrirlo con doble clic: funciona igual, sin instalar nada.

## App para Android

La carpeta `android/` contiene el proyecto Android (hecho con [Capacitor](https://capacitorjs.com/)), que empaqueta la app completa para que funcione sin conexión. Para compilar y firmar la APK en Arch Linux:

```bash
bash build-apk.sh
```

El script instala JDK 21, Node y el Android SDK, copia la app web al proyecto Android y firma la APK con tu clave de release, que se guarda fuera del repo. Antes de cada versión nueva subí `versionCode` y `versionName` en `android/app/build.gradle` y agregá el changelog en `fastlane/metadata/android/*/changelogs/<versionCode>.txt`.

Las descripciones, el ícono y las capturas para tiendas F-Droid/IzzyOnDroid están en `fastlane/metadata/android/`.

## Estructura

| Archivo | Para qué |
|---|---|
| `index.html` | La app completa (un solo archivo) |
| `manifest.webmanifest` | Datos para instalarla como app |
| `sw.js` | Service worker: funcionamiento sin conexión |
| `icons/` | Íconos de la app |
| `recetas/` | Recetas para importar |
| `android/` | Proyecto Android (Capacitor) |
| `fastlane/` | Descripción, ícono y capturas para tiendas de apps |
| `build-apk.sh` | Compila y firma la APK en Arch Linux |

Al cambiar `index.html`, subí el número de `VERSION` en `sw.js` para que las copias instaladas se actualicen.

## Publicar en GitHub Pages

Settings → Pages → Source: «Deploy from a branch» → rama `main`, carpeta `/ (root)`.

## Créditos

Brew-libre se basa en la planilla de cálculo cervecero **Beer_calc v5.6** (autor original no identificado; si sos el autor, escribime para darte el crédito correspondiente). De ella provienen las fórmulas de cálculo, las bases de ingredientes originales y la receta de ejemplo «Jambo Beer». La idea de convertirla en una app libre, la selección de funciones y el criterio cervecero son de Sebastián Valenzuela, que se apoyó también en su experiencia con apps de elaboración privativas.

El código fue escrito con asistencia de IA (Claude, de Anthropic).

## Licencia

Brew-libre es software libre: podés usarlo, estudiarlo, modificarlo y redistribuirlo bajo los términos de la [Licencia Pública General de GNU, versión 3](LICENSE) o (a tu elección) cualquier versión posterior. Las versiones modificadas que distribuyas deben mantener la misma licencia y publicar su código fuente.

Copyright © 2026 Sebastián Valenzuela.

## Apoyar el proyecto

Brew-libre es gratis. Si te sirve, podés colaborar desde la pestaña «Acerca de…» de la app.

Contacto: Sebastián Valenzuela — sebadarva@gmail.com
