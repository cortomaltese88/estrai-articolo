# Release

## Stato attuale

La release attuale del progetto e' una release sorgente.

- tag corrente documentato: `v0.1.0`
- nessun packaging `.deb` in questa fase

## Quando creare una nuova release

Una nuova release ha senso quando almeno una di queste condizioni e' soddisfatta:

- correzioni funzionali o di stabilita'
- aggiornamenti rilevanti della documentazione
- cambiamenti nelle dipendenze o nei metadati del progetto
- variazioni nel flusso di installazione o avvio

## Controlli prima del tag

Prima di creare un nuovo tag e' consigliato verificare almeno:

- working tree pulito
- aggiornamento di `README.md` se necessario
- aggiornamento di `CHANGELOG.md`
- sintassi valida di `server.py`, `avvia.sh` e `installa.sh`
- stato verde della CI minima
- coerenza della versione dichiarata nei file di progetto interessati

## Forma della release

Allo stato attuale il flusso consigliato e' limitato alla release sorgente tramite tag Git e relativa pubblicazione sul repository.

## Estensioni future

Se in futuro il progetto adottera' packaging `.deb`, sara' utile aggiungere alla checklist:

- contenuti del pacchetto
- dipendenze di sistema
- percorso di installazione
- test di installazione e disinstallazione
- verifica della voce desktop e delle icone
