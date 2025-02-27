FROM alpine:latest

# Instalar dependencias
RUN apk add --no-cache openssh-client autossh sshpass jq

# Crear directorio de datos
RUN mkdir -p /data && chmod 700 /data

# Copiar archivos necesarios
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Definir el punto de entrada
CMD ["/bin/sh", "/run.sh", "start"]

# Copiar el servidor HTTP
COPY server.sh /server.sh
RUN chmod +x /server.sh

# Definir el punto de entrada
CMD ["/bin/sh", "/server.sh"]
