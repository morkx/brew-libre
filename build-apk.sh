#!/usr/bin/env bash
# Brew-libre: compila y firma la APK de Android en Arch Linux.
# Uso, desde la raíz del repo:  bash build-apk.sh
# Se puede correr varias veces: lo que ya está instalado se saltea.
#
# Seguridad: la clave de firma vive FUERA del repo (por defecto en ~/claves/)
# y las contraseñas se piden por teclado; nunca se guardan en ningún archivo.
set -euo pipefail

SDK_PLATFORM="android-36"
BUILD_TOOLS="36.0.0"
CMDLINE_ZIP="commandlinetools-linux-13114758_latest.zip"   # si falla la descarga, actualizá el nombre desde developer.android.com/studio
KEYSTORE="${KEYSTORE:-$HOME/claves/brewlibre-release.jks}"
KEY_ALIAS="brewlibre"

export ANDROID_HOME="${ANDROID_HOME:-$HOME/Android/Sdk}"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"

paso() { printf '\n\033[1;33m==> %s\033[0m\n' "$*"; }

[ -f capacitor.config.json ] && [ -d android ] || { echo "Corré el script desde la raíz del repo brew-libre."; exit 1; }
case "$(realpath "$KEYSTORE" 2>/dev/null || echo "$KEYSTORE")" in
  "$(pwd)"/*) echo "La clave de firma no puede estar dentro del repo: $KEYSTORE"; exit 1;;
esac

paso "1/6 Paquetes del sistema (JDK 21, Node, npm)"
sudo pacman -S --needed --noconfirm jdk21-openjdk nodejs npm unzip wget
sudo archlinux-java set java-21-openjdk

paso "2/6 Android SDK en $ANDROID_HOME"
if [ ! -x "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" ]; then
  mkdir -p "$ANDROID_HOME/cmdline-tools"
  tmp="$(mktemp -d)"
  wget -q --show-progress -O "$tmp/tools.zip" "https://dl.google.com/android/repository/$CMDLINE_ZIP"
  unzip -q "$tmp/tools.zip" -d "$tmp"
  mv "$tmp/cmdline-tools" "$ANDROID_HOME/cmdline-tools/latest"
  rm -rf "$tmp"
fi
yes | sdkmanager --licenses >/dev/null || true
sdkmanager "platform-tools" "platforms;$SDK_PLATFORM" "build-tools;$BUILD_TOOLS"

grep -q 'ANDROID_HOME' "$HOME/.bashrc" 2>/dev/null || cat >> "$HOME/.bashrc" <<'EOF'
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools
EOF

paso "3/6 Copiando la app web al proyecto Android"
npm ci
npm run android:sync

GRADLE=android/app/build.gradle
VERSION="$(grep -m1 versionName "$GRADLE" | sed -E 's/.*"(.*)".*/\1/')"
CODE="$(grep -m1 versionCode "$GRADLE" | awk '{print $2}')"
echo "   Versión $VERSION (versionCode $CODE). Subí ambos en $GRADLE antes de cada release."

paso "4/6 Clave de firma"
if [ ! -f "$KEYSTORE" ]; then
  mkdir -p "$(dirname "$KEYSTORE")"; chmod 700 "$(dirname "$KEYSTORE")"
  echo "Se va a crear tu clave de release. Elegí una contraseña y GUARDALA: sin esta clave no podrás actualizar la app."
  keytool -genkeypair -v -keystore "$KEYSTORE" -alias "$KEY_ALIAS" -keyalg RSA -keysize 4096 -validity 10000
  chmod 600 "$KEYSTORE"
else
  echo "Usando la clave existente: $KEYSTORE"
fi

paso "5/6 Compilando la APK de release"
( cd android && ./gradlew --no-daemon assembleRelease )

paso "6/6 Alineando y firmando"
OUT_DIR=android/app/build/outputs/apk/release
BT="$ANDROID_HOME/build-tools/$BUILD_TOOLS"
FINAL="$PWD/brew-libre-$VERSION.apk"
"$BT/zipalign" -f -p 4 "$OUT_DIR/app-release-unsigned.apk" "$OUT_DIR/aligned.apk"
"$BT/apksigner" sign --ks "$KEYSTORE" --ks-key-alias "$KEY_ALIAS" --out "$FINAL" "$OUT_DIR/aligned.apk"
rm -f "$FINAL.idsig"
"$BT/apksigner" verify --print-certs "$FINAL" | head -3

paso "Listo"
echo "APK: $FINAL ($(du -h "$FINAL" | cut -f1); IzzyOnDroid admite hasta ~30 MB)"
echo "Probala con:  adb install -r \"$FINAL\""
echo "La APK no se sube al repo (está en .gitignore): adjuntala al Release del tag v$VERSION en GitHub."
echo "Respaldá $KEYSTORE en un lugar seguro y nunca la compartas."
