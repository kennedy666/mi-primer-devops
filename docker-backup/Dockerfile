# Imagen base
FROM ubuntu:22.04

# Instalar tar y bash
RUN apt-get update && apt-get install -y tar bash

# Crear directorio de trabajo
WORKDIR /app

# Copiar script al contenedor
COPY backup.sh .

# Dar permisos de ejecución
RUN chmod +x backup.sh

# Ejecutar el script por defecto
ENTRYPOINT ["./backup.sh"]
