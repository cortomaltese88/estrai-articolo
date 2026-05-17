#!/bin/bash
# Installa estrai-articolo sul sistema e crea la voce nel menu applicazioni.

set -e

INSTALL_DIR="/opt/estrai-articolo"
VENV_DIR="$INSTALL_DIR/venv"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REQ_FILE="$INSTALL_DIR/requirements.txt"

echo "=== Installazione Estrai Articolo ==="
echo ""

# 1. Crea la directory di installazione
echo "[1/5] Creo $INSTALL_DIR ..."
sudo mkdir -p "$INSTALL_DIR"
sudo mkdir -p "$INSTALL_DIR/assets" "$INSTALL_DIR/packaging"

# 2. Copia i file
echo "[2/5] Copio i file..."
sudo cp "$SCRIPT_DIR/server.py"                 "$INSTALL_DIR/"
sudo cp "$SCRIPT_DIR/gui.html"                  "$INSTALL_DIR/"
sudo cp "$SCRIPT_DIR/avvia.sh"                  "$INSTALL_DIR/"
sudo cp "$SCRIPT_DIR/requirements.txt"          "$INSTALL_DIR/"
sudo cp "$SCRIPT_DIR/assets/estrai-articolo.png" "$INSTALL_DIR/assets/"
sudo cp "$SCRIPT_DIR/assets/estrai-articolo.svg" "$INSTALL_DIR/assets/"
sudo cp "$SCRIPT_DIR/packaging/estrai-articolo.desktop" "$INSTALL_DIR/packaging/"
sudo chmod +x "$INSTALL_DIR/avvia.sh"

# 3. Prepara ambiente Python
echo "[3/5] Preparo virtualenv Python..."
if ! python3 -m venv --help >/dev/null 2>&1; then
    echo "python3-venv non disponibile. Installa il pacchetto python3-venv e rilancia installa.sh." >&2
    exit 1
fi

sudo python3 -m venv "$VENV_DIR"
sudo "$VENV_DIR/bin/python" -m pip install --upgrade pip
sudo "$VENV_DIR/bin/pip" install -r "$REQ_FILE"

# 4. Installa l'icona
echo "[4/5] Installo icona..."
mkdir -p "$ICON_DIR/hicolor/256x256/apps"
cp "$SCRIPT_DIR/assets/estrai-articolo.png" "$ICON_DIR/hicolor/256x256/apps/estrai-articolo.png"
# Aggiorna cache icone KDE/GNOME
command -v gtk-update-icon-cache &>/dev/null && \
    gtk-update-icon-cache -f "$ICON_DIR/hicolor" 2>/dev/null || true
command -v kbuildsycoca6 &>/dev/null && kbuildsycoca6 --quiet 2>/dev/null || \
command -v kbuildsycoca5 &>/dev/null && kbuildsycoca5 --quiet 2>/dev/null || true

# 5. Crea voce nel menu
echo "[5/5] Creo voce nel menu applicazioni..."
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
echo "Virtualenv installata in:"
echo "  $VENV_DIR"
echo ""
echo "Per disinstallare:"
echo "  sudo rm -rf $INSTALL_DIR"
echo "  rm $DESKTOP_DIR/estrai-articolo.desktop"
echo "  rm $ICON_DIR/hicolor/256x256/apps/estrai-articolo.png"
