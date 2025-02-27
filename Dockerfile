FROM alpine:latest

# Instalar dependencias
RUN apk add --no-cache openssh-client autossh sshpass jq

# Crear directorio de datos
RUN mkdir -p /data && chmod 700 /data

# Copiar archivos necesarios
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Copiar el servidor HTTP
COPY server.sh /server.sh
RUN chmod +x /server.sh

# Crear el script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Definir el punto de entrada para ejecutar el nuevo script
CMD ["/bin/sh", "/start.sh"]
