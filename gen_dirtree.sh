#!/bin/bash

# Controlla argomenti
if [ $# -ne 4 ]; then
    echo "Uso: $0 <nome_directory_base> <seme>"
    exit 1
fi

BASE_DIR="$1"
SEED="$2"
# NUM_DIRS=2048
# NUM_FILES=512
NUM_DIRS="$3"
NUM_FILES="$4"

# Imposta il seme per la generazione deterministica
RANDOM=$SEED

# Nomi fantasiosi senza spazi
WORDS=(zebrafish tesseract moonblade fluxnet quantumloaf krakenbyte zentauri grimwhale techspike frostknob)

# Permessi non standard per i file
PERMISSIONS=("644" "755" "777" "600" "400")

# Crea directory di base
mkdir -p "$BASE_DIR"
cd "$BASE_DIR" || exit 1

# Genera le directory
echo "Generazione di $NUM_DIRS directory..."
for ((i=0; i<NUM_DIRS; i++)); do
    path=""
    depth=$((RANDOM % 5 + 1))
    for ((j=0; j<depth; j++)); do
        word_index=$((RANDOM % ${#WORDS[@]}))
        dir="${WORDS[$word_index]}_$((RANDOM % 10000))"
        path="$path/$dir"
    done
    mkdir -p ".$path"
done

# Raccoglie tutte le directory
mapfile -t ALL_DIRS < <(find . -type d)

# Genera i file
echo "Generazione di $NUM_FILES file..."
for ((i=0; i<NUM_FILES; i++)); do
    rand_dir=${ALL_DIRS[$((RANDOM % ${#ALL_DIRS[@]}))]}
    word_index=$((RANDOM % ${#WORDS[@]}))
    filename="${WORDS[$word_index]}_$((RANDOM % 100000))"

    # Aggiungi file nascosti occasionalmente
    if (( RANDOM % 10 == 0 )); then
        filename=".$filename"
    fi

    filesize=$((RANDOM % 4901 + 100))
    head -c "$filesize" /dev/urandom > "$rand_dir/$filename"

    # Imposta permessi non standard
    perm_index=$((RANDOM % ${#PERMISSIONS[@]}))
    chmod ${PERMISSIONS[$perm_index]} "$rand_dir/$filename"

    # Imposta timestamp retrodatato (1-10 giorni fa)
    timestamp=$((RANDOM % 10 + 1))
    touch -d "$timestamp days ago" "$rand_dir/$filename"
done

echo "Albero deterministico generato con successo in $BASE_DIR"
