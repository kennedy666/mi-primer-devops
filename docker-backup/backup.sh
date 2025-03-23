#!/bin/bash

# Script para backup en contenedor Docker

ORIGEN="/data/original"
DESTINO="/data/backups"
LOGS="/data/logs"
FECHA=$(date +"%Y-%m-%d-%H-%M-%S-%3N")
NOMBRE_BACKUP="backup-$FECHA.tar.gz"
ARCHIVO_LOG="$LOGS/backup.log"
MAX_BACKUPS=7

mkdir -p "$DESTINO" "$LOGS"

echo "$(date '+%F %T') - Iniciando backup..." >> "$ARCHIVO_LOG"
echo "📁 Origen: $ORIGEN" >> "$ARCHIVO_LOG"
echo "📂 Destino: $DESTINO/$NOMBRE_BACKUP" >> "$ARCHIVO_LOG"

tar -czf "$DESTINO/$NOMBRE_BACKUP" -C "$ORIGEN" . 2>> "$ARCHIVO_LOG"

if [ $? -eq 0 ]; then
    echo "$(date '+%F %T') - ✅ Backup hecho correctamente." >> "$ARCHIVO_LOG"
else
    echo "$(date '+%F %T') - ❌ ERROR: El backup falló." >> "$ARCHIVO_LOG"
fi

# Rotación
TOTAL=$(ls -1t "$DESTINO"/backup-*.tar.gz 2>/dev/null | wc -l)
if [ "$TOTAL" -gt "$MAX_BACKUPS" ]; then
    BORRAR=$(ls -1t "$DESTINO"/backup-*.tar.gz | tail -n +$(($MAX_BACKUPS + 1)))
    for archivo in $BORRAR; do
        rm "$archivo"
        echo "$(date '+%F %T') - 🗑️ Backup eliminado: $archivo" >> "$ARCHIVO_LOG"
    done
fi

echo "-----------------------------" >> "$ARCHIVO_LOG"
