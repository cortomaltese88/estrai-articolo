#!/bin/bash
# Avvia il server locale e apre l'interfaccia nel browser predefinito.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER="$SCRIPT_DIR/server.py"
PORT=7432
URL="http://localhost:$PORT"

# Controlla se il server è già in ascolto
if ss -tlnp 2>/dev/null | grep -q ":$PORT " || netstat -tlnp 2>/dev/null | grep -q ":$PORT "; then
    echo "Server già in esecuzione su $URL"
else
    echo "Avvio server..."
    python3 "$SERVER" &
    SERVER_PID=$!
    # Attende che il server sia pronto (max 5 secondi)
    for i in $(seq 1 10); do
        sleep 0.5
        if ss -tlnp 2>/dev/null | grep -q ":$PORT " || \
           curl -s --connect-timeout 1 "$URL" > /dev/null 2>&1; then
            echo "Server pronto (PID $SERVER_PID)"
            break
        fi
    done
fi

# Apre nel browser predefinito
if command -v xdg-open &>/dev/null; then
    xdg-open "$URL"
elif command -v firefox &>/dev/null; then
    firefox "$URL"
elif command -v chromium-browser &>/dev/null; then
    chromium-browser "$URL"
else
    echo "Apri manualmente: $URL"
fi

# Attende — se avviato da terminale mostra il log, se da .desktop esce
wait 2>/dev/null || true
