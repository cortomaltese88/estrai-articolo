# Uso

## Installazione

Per installare l'applicazione in `/opt/estrai-articolo` con ambiente Python dedicato:

```bash
./installa.sh
```

Lo script richiede i permessi necessari per creare la directory di installazione e preparare la virtualenv.

## Avvio

Per avviare l'applicazione:

```bash
./avvia.sh
```

Lo script tenta di usare la virtualenv presente accanto al progetto o, se assente, `python3` di sistema.

Una volta avviato il server locale, l'interfaccia e' raggiungibile su:

```text
http://localhost:7432
```

Se il browser non si apre automaticamente, e' sufficiente visitare l'indirizzo manualmente.

## Uso base dell'interfaccia

1. Incolla l'URL dell'articolo nel campo dedicato.
2. Avvia l'estrazione.
3. Attendi il caricamento del contenuto e dei metadati disponibili.
4. Leggi il testo estratto nell'area principale.
5. Se necessario usa le azioni disponibili:
   - copia del testo
   - salvataggio come `.txt`
   - stampa
   - export come `.docx`

## Export DOCX

L'export DOCX e' disponibile dopo un'estrazione riuscita.

Il file generato include, quando disponibili:

- testata
- data
- autore
- URL
- titolo
- corpo del testo ripulito

La generazione del documento richiede la dipendenza `python-docx`.

## Limiti noti

- L'applicazione opera in locale e dipende dalla raggiungibilita' della pagina indicata.
- L'estrazione si basa sui contenuti e metadati esposti dalla pagina.
- Alcune pagine potrebbero non fornire un contenuto estraibile nel formato atteso.
- La qualita' dell'impaginazione DOCX dipende dai dati disponibili nella sorgente.

## Responsabilita' dell'utente

L'utente e' responsabile di:

- usare l'applicazione solo su contenuti a cui puo' accedere legittimamente
- verificare correttezza e completezza del testo estratto
- controllare il contenuto esportato prima di riutilizzarlo o archiviarlo
