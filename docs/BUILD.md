# Build e sviluppo

## Ambiente di sviluppo

Preparazione minima dell'ambiente:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Avvio in sviluppo

Con ambiente attivo:

```bash
python3 server.py
```

Oppure:

```bash
source .venv/bin/activate
./avvia.sh
```

## Test minimi

Controlli leggeri utili prima di un rilascio o di una modifica documentale:

```bash
python3 -m py_compile server.py
bash -n avvia.sh
bash -n installa.sh
```

## Equivalente locale della CI minima

Se presente il workflow `.github/workflows/ci.yml`, un controllo locale essenziale consiste in:

```bash
python3 -m py_compile server.py
bash -n avvia.sh
bash -n installa.sh
```

In aggiunta e' possibile validare la sintassi YAML del workflow con un parser locale, se disponibile l'ambiente Python adeguato.

## Packaging

Al momento il progetto non prevede build binarie, pacchetti `.deb` o artefatti installabili diversi dalla copia sorgente e dall'installazione tramite script.
