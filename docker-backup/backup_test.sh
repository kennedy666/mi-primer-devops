#!/bin/bash

echo "🧪 Iniciando backup de prueba"
mkdir -p /tmp/backups
FECHA=$(date +"%Y-%m-%d-%H-%M-%S")
ARCHIVO="/tmp/backups/backup-$FECHA.tar.gz"
tar -czf "$ARCHIVO" docker-backup 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Backup simulado creado en $ARCHIVO"
    exit 0
else
    echo "❌ Falló el backup simulado"
    exit 1
fi
