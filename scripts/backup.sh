#!/bin/bash

# Script para hacer backup de una carpeta y registrar logs

# === CONFIGURACIÓN ===

ORIGEN="$HOME/carpeta_original"   # <-- Cambia si usas otra ruta
DESTINO="$HOME/backups"
LOGS="$HOME/logs"
FECHA=$(date +"%Y-%m-%d-%H-%M")
NOMBRE_BACKUP="backup-$FECHA.tar.gz"
ARCHIVO_LOG="$LOGS/backup.log"

# === CREAR CARPETAS SI NO EXISTEN ===

mkdir -p "$DESTINO"
mkdir -p "$LOGS"

# === INICIAR LOG ===

echo "$(date '+%F %T') - Iniciando backup..." >> "$ARCHIVO_LOG"
echo "📁 Origen: $ORIGEN" >> "$ARCHIVO_LOG"
echo "📂 Destino: $DESTINO/$NOMBRE_BACKUP" >> "$ARCHIVO_LOG"

# === CREAR BACKUP ===

tar -czf "$DESTINO/$NOMBRE_BACKUP" "$ORIGEN" 2>> "$ARCHIVO_LOG"

# === VERIFICAR RESULTADO ===

if [ $? -eq 0 ]; then
    echo "$(date '+%F %T') - ✅ Backup hecho." >> "$ARCHIVO_LOG"
else
    echo "$(date '+%F %T') - ❌ ERROR: El backup falló." >> "$ARCHIVO_LOG"
fi

echo "-----------------------------" >> "$ARCHIVO_LOG"
