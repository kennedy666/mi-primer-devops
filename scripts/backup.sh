#!/bin/bash

# Script para hacer backup de una carpeta con logs y validación

# Carpeta que vamos a respaldar
ORIGEN="carpeta_original"

# Carpeta donde se guardará el backup
DESTINO="backups"

# Carpeta de logs
LOGS="logs"

# Fecha actual en formato YYYY-MM-DD-HH-MM
FECHA=$(date +"%Y-%m-%d-%H-%M")

# Nombre del archivo de backup
NOMBRE_BACKUP="backup-$FECHA.tar.gz"

# Ruta del archivo de log
ARCHIVO_LOG="$LOGS/backup.log"

# Crear carpetas si no existen
mkdir -p "$DESTINO"
mkdir -p "$LOGS"

# Mensajes de depuración por pantalla y log
echo "🕒 $(date '+%F %T') - Iniciando backup..."
echo "📁 Origen: $ORIGEN"
echo "📂 Destino: $DESTINO"
echo "📝 Nombre del backup: $NOMBRE_BACKUP"

# También lo registramos en el log
echo "🕒 $(date '+%F %T') - Iniciando backup..." >> "$ARCHIVO_LOG"
echo "📁 Origen: $ORIGEN" >> "$ARCHIVO_LOG"
echo "📂 Destino: $DESTINO/$NOMBRE_BACKUP" >> "$ARCHIVO_LOG"

# Crear el archivo comprimido
tar -czf "$DESTINO/$NOMBRE_BACKUP" "$ORIGEN" 2>> "$ARCHIVO_LOG"

# Verificar si fue exitoso
if [ $? -eq 0 ]; then
    echo "✅ Backup completado correctamente"
    echo "✅ $(date '+%F %T') - Backup completado correctamente" >> "$ARCHIVO_LOG"
else
    echo "❌ ERROR: El backup falló"
    echo "❌ $(date '+%F %T') - ERROR: El backup falló" >> "$ARCHIVO_LOG"
fi

# Separador en el log
echo "-----------------------------" >> "$ARCHIVO_LOG"
