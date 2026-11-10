#!/usr/bin/env bash
# Brew-libre: sube el número de versión en todos los lugares a la vez.
# Uso, desde la raíz del repo:  bash version.sh 1.4.0
# Después: anotá los cambios en «Versiones» de README.md y README.en.md
# y en los changelogs de Fastlane que crea el script, hacé commit y
#   git tag v1.4.0 && git push --tags
set -euo pipefail

V="${1:-}"
[[ "$V" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "Uso: bash version.sh X.Y.Z  (versión actual: $(sed -n 's/.*"version": "\(.*\)".*/\1/p' package.json | head -1))"; exit 1; }
[ -f package.json ] && [ -f sw.js ] || { echo "Corré el script desde la raíz del repo brew-libre."; exit 1; }

GRADLE=android/app/build.gradle
CODE=$(( $(sed -n 's/^ *versionCode \([0-9]*\).*/\1/p' "$GRADLE") + 1 ))
HOY=$(date +%F)

# package.json y package-lock.json (solo la versión del propio paquete, no las dependencias)
sed -i '0,/"version": "[^"]*"/s//"version": "'"$V"'"/' package.json
sed -i '0,/"version": "[^"]*"/s//"version": "'"$V"'"/' package-lock.json
sed -i '0,/^\(      "version": \)"[^"]*"/s//\1"'"$V"'"/' package-lock.json
# app web: número visible en «Acerca de» y caché del service worker (así las copias instaladas se actualizan)
sed -i "s/^const APP_VERSION = '[^']*', APP_DATE = '[^']*';/const APP_VERSION = '$V', APP_DATE = '$HOY';/" index.html
sed -i "s/^const VERSION = 'brew-libre-[^']*';/const VERSION = 'brew-libre-$V';/" sw.js
# Android
sed -i "s/^\( *versionCode \)[0-9]*/\1$CODE/; s/^\( *versionName \)\"[^\"]*\"/\1\"$V\"/" "$GRADLE"
for d in fastlane/metadata/android/*/; do
  d="${d%/}"; f="$d/changelogs/$CODE.txt"; [ -f "$f" ] || { mkdir -p "$d/changelogs"; : > "$f"; echo "Escribí el changelog en $f"; }
done

grep -q "^const APP_VERSION = '$V'" index.html || { echo "No encontré APP_VERSION en index.html"; exit 1; }
echo "Versión $V (versionCode $CODE, $HOY). Falta: README «Versiones», changelogs, commit y tag v$V."
