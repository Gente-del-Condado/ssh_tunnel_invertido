#!/bin/sh

LOG_FILE="/data/ssh_tunnel.log"
CONTROL_FILE="/data/tunnel_control"

# Iniciar servidor web
busybox httpd -p 8099 -h /www -f &

# Crear API de control
mkdir -p /www
echo '#!/bin/sh' > /www/index.cgi
echo 'echo "Content-type: text/plain"' >> /www/index.cgi
echo 'echo ""' >> /www/index.cgi
echo 'if [ "$QUERY_STRING" = "action=start" ]; then' >> /www/index.cgi
echo '  /run.sh start' >> /www/index.cgi
echo '  echo "Túnel iniciado"' >> /www/index.cgi
echo 'elif [ "$QUERY_STRING" = "action=stop" ]; then' >> /www/index.cgi
echo '  /run.sh stop' >> /www/index.cgi
echo '  echo "Túnel detenido"' >> /www/index.cgi
echo 'elif [ "$QUERY_STRING" = "action=restart" ]; then' >> /www/index.cgi
echo '  /run.sh restart' >> /www/index.cgi
echo '  echo "Túnel reiniciado"' >> /www/index.cgi
echo 'elif [ "$QUERY_STRING" = "action=status" ]; then' >> /www/index.cgi
echo '  cat '$CONTROL_FILE >> /www/index.cgi
echo 'else' >> /www/index.cgi
echo '  echo "Comando no válido."' >> /www/index.cgi
echo 'fi' >> /www/index.cgi

chmod +x /www/index.cgi
