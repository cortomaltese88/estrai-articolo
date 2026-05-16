#!/bin/bash
# Installa estrai-articolo sul sistema e crea la voce nel menu applicazioni.

set -e

INSTALL_DIR="/opt/estrai-articolo"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"

echo "=== Installazione Estrai Articolo ==="
echo ""

# 1. Crea la directory di installazione
echo "[1/4] Creo $INSTALL_DIR ..."
sudo mkdir -p "$INSTALL_DIR"
sudo mkdir -p "$INSTALL_DIR/assets" "$INSTALL_DIR/packaging"

# 2. Copia i file
echo "[2/4] Copio i file..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo cp "$SCRIPT_DIR/server.py"                 "$INSTALL_DIR/"
sudo cp "$SCRIPT_DIR/gui.html"                  "$INSTALL_DIR/"
sudo cp "$SCRIPT_DIR/avvia.sh"                  "$INSTALL_DIR/"
sudo cp "$SCRIPT_DIR/assets/estrai-articolo.png" "$INSTALL_DIR/assets/"
sudo cp "$SCRIPT_DIR/assets/estrai-articolo.svg" "$INSTALL_DIR/assets/"
sudo cp "$SCRIPT_DIR/packaging/estrai-articolo.desktop" "$INSTALL_DIR/packaging/"
sudo chmod +x "$INSTALL_DIR/avvia.sh"

# 3. Installa l'icona
echo "[3/4] Installo icona..."
mkdir -p "$ICON_DIR/hicolor/256x256/apps"
cp "$SCRIPT_DIR/assets/estrai-articolo.png" "$ICON_DIR/hicolor/256x256/apps/estrai-articolo.png"
# Aggiorna cache icone KDE/GNOME
command -v gtk-update-icon-cache &>/dev/null && \
    gtk-update-icon-cache -f "$ICON_DIR/hicolor" 2>/dev/null || true
command -v kbuildsycoca6 &>/dev/null && kbuildsycoca6 --quiet 2>/dev/null || \
command -v kbuildsycoca5 &>/dev/null && kbuildsycoca5 --quiet 2>/dev/null || true

# 4. Crea voce nel menu
echo "[4/4] Creo voce nel menu applicazioni..."
mkdir -p "$DESKTOP_DIR"
cat > "$DESKTOP_DIR/estrai-articolo.desktop" << DESKTOP
[Desktop Entry]
Version=1.0
Type=Application
Name=Estrai Articolo
GenericName=Estrattore articoli di giornale
Comment=Applicazione locale per estrarre e impaginare testo da articoli accessibili all'utente
Exec=/opt/estrai-articolo/avvia.sh
Icon=/opt/estrai-articolo/assets/estrai-articolo.png
Terminal=false
Categories=Utility;Network;
Keywords=articolo;giornale;notizie;estrai;testo;docx;
StartupNotify=true
StartupWMClass=estrai-articolo
DESKTOP

chmod +x "$DESKTOP_DIR/estrai-articolo.desktop"

# Aggiorna database menu
command -v update-desktop-database &>/dev/null && \
    update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true

echo ""
echo "=== Installazione completata! ==="
echo ""
echo "Trovi 'Estrai Articolo' nel menu applicazioni → Utilità"
echo "Oppure avvialo direttamente con:"
echo "  /opt/estrai-articolo/avvia.sh"
echo ""
echo "Per disinstallare:"
echo "  sudo rm -rf $INSTALL_DIR"
echo "  rm $DESKTOP_DIR/estrai-articolo.desktop"
echo "  rm $ICON_DIR/hicolor/256x256/apps/estrai-articolo.png"
