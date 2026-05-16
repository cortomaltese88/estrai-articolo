# estrai-articolo

<p align="center">
  <img src="assets/estrai-articolo.svg" alt="estrai-articolo" width="160">
</p>

Applicazione locale per estrarre, ripulire e impaginare il testo di articoli accessibili all'utente.

## Avvio

```bash
./avvia.sh
```

L'interfaccia e' disponibile su `http://localhost:7432`.

## Dipendenze

- Python 3
- `python-docx`

## File principali

- `server.py`: backend HTTP locale ed export DOCX
- `gui.html`: interfaccia web locale
- `avvia.sh`: avvio rapido
- `installa.sh`: installazione facoltativa in `/opt/estrai-articolo`

## Licenza

`GPL-3.0-or-later`

Il software e' fornito "as is". L'uso resta sotto la responsabilita' dell'utente.

Il nome, il logo e il marchio STUDIO GD LEX / GD LEX non sono concessi dalla licenza GPL.
