#!/bin/sh

LOG_FILE="/data/ssh_tunnel.log"
SSH_KEY="/data/id_rsa"
CONTROL_FILE="/data/tunnel_control"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG_FILE
}

# Función para iniciar el túnel
start_tunnel() {
    log_message "Iniciando el túnel SSH inverso..."
    echo "running" > $CONTROL_FILE
    autossh -M 0 -N -R ${REMOTE_PORT}:localhost:${LOCAL_PORT} -i $SSH_KEY $VPS_USER@$VPS_HOST -p $VPS_PORT -o StrictHostKeyChecking=no &
    echo $! > /data/tunnel_pid
    log_message "Túnel iniciado con PID $(cat /data/tunnel_pid)"
}

# Función para detener el túnel
stop_tunnel() {
    if [ -f /data/tunnel_pid ]; then
        kill "$(cat /data/tunnel_pid)"
        rm -f /data/tunnel_pid
        log_message "Túnel detenido."
    else
        log_message "No hay túnel en ejecución."
    fi
    echo "stopped" > $CONTROL_FILE
}

# Función para reiniciar el túnel
restart_tunnel() {
    stop_tunnel
    sleep 2
    start_tunnel
}

# Comprobar argumento pasado
case "$1" in
    start)
        start_tunnel
        ;;
    stop)
        stop_tunnel
        ;;
    restart)
        restart_tunnel
        ;;
    status)
        cat $CONTROL_FILE
        ;;
    *)
        echo "Uso: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac
