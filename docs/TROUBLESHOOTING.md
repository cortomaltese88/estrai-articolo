# Troubleshooting

## Porta 7432 occupata

Sintomo:

- `./avvia.sh` segnala che il server e' gia' in esecuzione oppure l'avvio non procede come atteso

Verifiche utili:

```bash
ss -tlnp | grep 7432
```

Possibili azioni:

- chiudere il processo che usa gia' la porta
- riutilizzare l'istanza gia' attiva aprendo `http://localhost:7432`

## python-docx mancante

Sintomo:

- errore durante l'export DOCX
- messaggio che segnala modulo `docx` non disponibile

Possibili azioni:

```bash
pip install -r requirements.txt
```

Oppure reinstallare tramite:

```bash
./installa.sh
```

## Virtualenv non trovata

Sintomo:

- `./avvia.sh` avvisa che la `venv` non e' stata trovata e usa `python3` di sistema

Possibili azioni:

- creare manualmente una virtualenv locale
- installare le dipendenze richieste
- eseguire l'installazione integrata con `./installa.sh`

Esempio:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
./avvia.sh
```

## Il browser non si apre

Sintomo:

- il server parte ma nessuna finestra del browser viene aperta

Possibili cause:

- ambiente desktop senza `xdg-open`
- browser predefinito non configurato
- sessione grafica non disponibile

Possibile azione:

- aprire manualmente `http://localhost:7432`

## Errore export DOCX

Sintomo:

- il pulsante `.docx` fallisce
- il download non parte oppure viene restituito un errore

Possibili cause:

- `python-docx` non installato correttamente
- metadati o contenuto non gestiti dalla generazione del documento
- ambiente Python non coerente con quello usato in avvio

Possibili azioni:

- verificare quale interprete Python viene usato
- reinstallare le dipendenze
- ripetere l'estrazione prima dell'export

## Problemi con desktop file o icona

Sintomo:

- voce applicazione non visibile nel menu
- icona assente o non aggiornata

Possibili azioni:

- rilanciare `./installa.sh`
- verificare la presenza di `~/.local/share/applications/estrai-articolo.desktop`
- verificare la presenza dell'icona in `~/.local/share/icons/hicolor/256x256/apps/estrai-articolo.png`
- aggiornare logout/login o cache desktop dell'ambiente grafico se necessario
