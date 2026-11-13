# Brew-libre

**Español** · [English](README.en.md)

Recetario cervecero libre para cerveceros caseros: una app web instalable (PWA), en español e inglés, con unidades métricas. No necesita cuenta ni nube: las recetas se guardan en archivos `.json` en tu propio equipo, y funciona sin conexión.

**Usarla:** https://morkx.github.io/brew-libre/

## Qué hace

- Diseño de recetas All Grain, BIAB y Extracto, con guías de estilo BJCP 2021 (incluye estilos regionales) y AHA/BA.
- OG, FG, ABV, IBU (Tinseth, Rager, Garetz) y color (Morey, Daniels, Mosher) en SRM, EBC o °L; densidad en SG, °Plato o °Brix.
- Base de ingredientes comerciales (maltas por maltería, lúpulos, levaduras) con buscador.
- Agua: análisis de laboratorio en cualquier unidad, pH de macerado, sales y ajuste de pH con pH objetivo o medido (ácido láctico, fosfórico o cítrico, también para el agua de lavado).
- Macerado y decocción, refractómetro (Terrill / Novotný), carbonatación con azúcar o en barril.
- Equipos comerciales (BrewZilla, Grainfather, Anvil Foundry…) con reescalado automático.
- Lista de compras, impresión e importación/exportación BeerXML.
- Diseñador de etiquetas para botellas: frente y contraetiqueta con los datos de elaboración (ABV, IBU, OG/FG, color, maltas, lúpulos, levadura, proceso, lote, fechas y alérgenos detectados en la receta). Se personaliza con 12 formas de contorno, 7 estilos de marco, 17 figuras geométricas combinables (y combinaciones ya armadas), 17 tipografías libres, paletas y colores propios, y logo. Se imprime en A4 con líneas de corte o se exporta en PNG a 300 ppp y SVG.
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

El script instala JDK 21, Node y el Android SDK, copia la app web al proyecto Android y firma la APK con tu clave de release, que se guarda fuera del repo. Antes de compilar una versión nueva corré `version.sh` (ver [Versiones](#versiones)): sube `versionCode` y `versionName` y crea el changelog en `fastlane/metadata/android/*/changelogs/<versionCode>.txt`.

Las descripciones, el ícono y las capturas para tiendas F-Droid/IzzyOnDroid están en `fastlane/metadata/android/`.

## Estructura

| Archivo | Para qué |
|---|---|
| `index.html` | La app completa (un solo archivo) |
| `manifest.webmanifest` | Datos para instalarla como app |
| `sw.js` | Service worker: funcionamiento sin conexión |
| `icons/` | Íconos de la app |
| `recetas/` | Recetas para importar |
| `fonts/` | Tipografías libres del diseñador de etiquetas, con sus licencias |
| `android/` | Proyecto Android (Capacitor) |
| `fastlane/` | Descripción, ícono y capturas para tiendas de apps |
| `build-apk.sh` | Compila y firma la APK en Arch Linux |
| `version.sh` | Sube el número de versión en todos los archivos |
| `netlify.toml` | Configuración para publicar en Netlify |

Cada cambio en `index.html` sale con una versión nueva (ver [Versiones](#versiones)); así cambia `VERSION` en `sw.js` y las copias instaladas se actualizan.

## Publicar

La app es un sitio estático: cualquier servidor con **https** sirve, y con https se puede instalar como app y funciona sin conexión.

### En Netlify (recomendado)

El repo ya trae `netlify.toml`, que le dice a Netlify cómo armar y publicar la app. Al publicar se arma la carpeta `www/` solo con los archivos de la app web; el proyecto Android y los scripts no se suben.

**Conectando el repositorio** (se actualiza solo con cada `git push`):

1. Entrá a [app.netlify.com](https://app.netlify.com) con tu cuenta de GitHub.
2. **Add new site → Import an existing project → GitHub** y elegí `morkx/brew-libre`.
3. Dejá los valores que Netlify toma del `netlify.toml` (build `npm run build`, carpeta `www`) y tocá **Deploy**.
4. En **Site configuration → Change site name** podés elegir la dirección, por ejemplo `brew-libre.netlify.app`.

**Sin conectar el repositorio** (Netlify Drop):

```bash
npm run build
```

y arrastrá la carpeta `www/` a [app.netlify.com/drop](https://app.netlify.com/drop). Para actualizar, repetí el `npm run build` y arrastrala de nuevo en la pestaña **Deploys** del sitio.

### En GitHub Pages

Settings → Pages → Source: «Deploy from a branch» → rama `main`, carpeta `/ (root)`.

## Versiones

Brew-libre usa [versionado semántico](https://semver.org/lang/es/) `MAYOR.MENOR.PARCHE`: se sube el **parche** al corregir errores, la **menor** al agregar funciones y la **mayor** si cambia el formato de los recetarios de forma incompatible. La versión se ve en la pestaña «Acerca de».

Para publicar una versión:

1. `bash version.sh 1.4.0` actualiza `package.json`, `index.html`, `sw.js` y `android/app/build.gradle`, y crea los changelogs de Fastlane.
2. Anotá los cambios abajo, en `README.en.md` y en los changelogs.
3. Commit, `git tag v1.4.0` y `git push --tags`.

### 1.3.1 — 2026-11-13
- «Acerca de»: donaciones con **Mercado Pago**; se quitaron los datos de transferencia bancaria.

### 1.3.0 — 2026-11-10
- Agua: nueva sección **Ajuste de pH**. pH objetivo editable (antes fijo en 5,4), pH medido sin ácido opcional en lugar del estimado, ácido fosfórico con concentración editable además de láctico y cítrico, y ácido para el agua de lavado con su propio pH.
- El día de cocción, la lista de compras y la impresión incluyen el ácido del lavado y el pH objetivo.
- Número de versión visible en «Acerca de» y script `version.sh`.

### 1.2.0 — 2026-11-07
- Botón **Imprimir instrucciones**: la hoja de elaboración en una página A4.

### 1.1.0 — 2026-11-05
- **Diseñador de etiquetas** para botellas: formas, figuras, tipografías y colores; plantilla Tropical.
- «Acerca de» con enlace al repositorio, licencia y reporte de errores.
- Publicación en Netlify.

### 1.0.0 — 2026-10-27
- Primera versión: PWA, recetas clon para importar y app Android con Capacitor.

## Créditos

Brew-libre se basa en la planilla de cálculo cervecero **Beer_calc v5.6** (autor original no identificado; si sos el autor, escribime para darte el crédito correspondiente). De ella provienen las fórmulas de cálculo, las bases de ingredientes originales y la receta de ejemplo «Jambo Beer». La idea de convertirla en una app libre, la selección de funciones y el criterio cervecero son de Sebastián Valenzuela, que se apoyó también en su experiencia con apps de elaboración privativas.

El código fue escrito con asistencia de IA (Claude, de Anthropic).

Las tipografías del diseñador de etiquetas son libres (SIL Open Font License, y Apache 2.0 en el caso de Roboto Slab); el detalle y los textos de licencia están en [`fonts/`](fonts/README.md).

## Licencia

Brew-libre es software libre: podés usarlo, estudiarlo, modificarlo y redistribuirlo bajo los términos de la [Licencia Pública General de GNU, versión 3](LICENSE) o (a tu elección) cualquier versión posterior. Las versiones modificadas que distribuyas deben mantener la misma licencia y publicar su código fuente.

Copyright © 2026 Sebastián Valenzuela.

## Apoyar el proyecto

Brew-libre es gratis. Si te sirve, podés colaborar desde la pestaña «Acerca de…» de la app.

Contacto: Sebastián Valenzuela — sebadarva@gmail.com
