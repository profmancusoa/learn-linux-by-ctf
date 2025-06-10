# Percorsi

**In Linux tutto è un file**. Man mano che approfondirai il sistema, capirai meglio cosa significa, ma per ora tienilo semplicemente a mente.

Ogni file è organizzato in un albero gerarchico di directory. La prima directory del filesystem è chiamata, giustamente, directory **root**.

La directory root contiene molte altre directory e file, al cui interno puoi inserire altre directory e file, e così via.

Ecco un esempio di come appare l’albero delle directory:

```
/
|-- bin
|   |-- file1
|   |-- file2
|-- etc
|   |-- file3
|   `-- directory1
|       |-- file4
|       `-- file5
|-- home
|-- var
```


La posizione di questi file e directory viene chiamata *percorso* (path).

Se avessi una directory chiamata `home` con dentro una directory chiamata `guy`, e dentro quest’ultima una directory chiamata `Movies`, il percorso sarebbe: `/home/guy/Movies`. Semplice, no?

Navigare nel filesystem, proprio come nella vita reale, è più facile se sai dove sei e dove stai andando.  
Per vedere dove ti trovi, puoi usare il comando `pwd`. Questo comando significa “print working directory” (stampa la directory corrente) e ti mostra in quale directory ti trovi. Nota che il percorso parte dalla directory root, cioè è un **percorso assoluto**.


# Navigazione

Ricorda che dobbiamo navigare usando i percorsi. Ci sono due modi per specificare un percorso: *assoluto* e *relativo*:

- _Percorso assoluto_: È il percorso dalla directory root. La directory root è indicata con uno slash `/`. Ogni volta che un percorso inizia con `/`, significa che parte dalla root. Esempio: `/home/guy/Desktop`.

- _Percorso relativo_: È il percorso rispetto alla directory in cui ti trovi attualmente.  
  Se ti trovi in `/home/guy/Documents` e vuoi andare in una sottodirectory chiamata `taxes`, non devi specificare l’intero percorso come `/home/guy/Documents/taxes`, ti basta scrivere `taxes/`.

Navigare con percorsi assoluti e relativi può diventare stancante, ma per fortuna ci sono alcune scorciatoie utili:

- `.` indica la _directory corrente_.
- `..` indica la _directory superiore_ – ovvero quella che contiene la directory corrente.
- `~` indica la _home directory_ – che di default è la tua directory personale, ad esempio `/home/guy`.
- `-` indica la _directory precedente_ – ti riporta alla directory visitata prima.

Per spostarti tra le directory usa il comando `cd` (change directory).


# Il tuo obiettivo

Trova la flag! Si trova in un file chiamato `flag.txt`


# Comandi utili
- pwd
- ls
- cd
- find


!!! nota:  
    Il comando `flag` può ricevere un argomento opzionale che indica il nome di una sfida. Puoi tornare a sfide già risolte usando quell’argomento.  
    Ad esempio: `flag challenge01` ti chiederà la flag trovata nella prima sfida (`challenge00`).  
    La flag per `challenge00` è "none".
