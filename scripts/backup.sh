#!/bin/bash

# Script para hacer backup de una carpeta y registrar logs, con funciones y rotación

# === CONFIGURACIÓN ===

ORIGEN="$HOME/mi-primer-repo-git/carpeta_original"
DESTINO="$HOME/mi-primer-repo-git/backups"
LOGS="$HOME/mi-primer-repo-git/logs"
FECHA=$(date +"%Y-%m-%d-%H-%M")
NOMBRE_BACKUP="backup-$FECHA.tar.gz"
ARCHIVO_LOG="$LOGS/backup.log"
MAX_BACKUPS=5  # Número máximo de backups que se conservarán

# === FUNCIONES ===

iniciar_log() {
    mkdir -p "$DESTINO" "$LOGS"
    echo "$(date '+%F %T') - Iniciando backup..." >> "$ARCHIVO_LOG"
    echo "📁 Origen: $ORIGEN" >> "$ARCHIVO_LOG"
    echo "📂 Destino: $DESTINO/$NOMBRE_BACKUP" >> "$ARCHIVO_LOG"
}

crear_backup() {
    tar -czf "$DESTINO/$NOMBRE_BACKUP" "$ORIGEN" 2>> "$ARCHIVO_LOG"
    if [ $? -eq 0 ]; then
        echo "$(date '+%F %T') - ✅ Backup hecho correctamente." >> "$ARCHIVO_LOG"
    else
        echo "$(date '+%F %T') - ❌ ERROR: El backup falló." >> "$ARCHIVO_LOG"
    fi
    echo "-----------------------------" >> "$ARCHIVO_LOG"
}

rotar_backups() {
    TOTAL=$(ls -1t "$DESTINO"/backup-*.tar.gz 2>/dev/null | wc -l)
    if [ "$TOTAL" -gt "$MAX_BACKUPS" ]; then
        BORRAR=$(ls -1t "$DESTINO"/backup-*.tar.gz | tail -n +$(($MAX_BACKUPS + 1)))
        for archivo in $BORRAR; do
            rm "$archivo"
            echo "$(date '+%F %T') - 🗑️ Backup antiguo eliminado: $archivo" >> "$ARCHIVO_LOG"
        done
    fi
}

# === EJECUCIÓN PRINCIPAL ===

iniciar_log
crear_backup
rotar_backups
