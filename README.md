# Complemento SSH Tunnel Invertido para Home Assistant

Este complemento permite crear un **túnel SSH inverso** para acceder a **Home Assistant** desde un servidor **VPS**. A través de este túnel, podrás gestionar tu Home Assistant de manera remota sin necesidad de una IP pública o NAT.

## Funciones

- **Crea un túnel SSH inverso** entre tu Home Assistant y un servidor VPS.
- **Conexión segura y persistente** usando claves SSH.
- **Panel web** para iniciar, detener y reiniciar el túnel.
- **Registra las conexiones, tiempos y fallos**.
- **Reintentos automáticos** en caso de fallo de conexión.
- **Configuración sencilla** a través de un archivo `config.yaml`.

## Requisitos

- Home Assistant OS
- Acceso SSH a un VPS
- Conexión a Internet en el dispositivo Home Assistant

## Instalación

### Paso 1: Descargar el complemento

1. Dirígete a **Supervisor > Complementos > Repositorios**.
2. Añade el repositorio de complementos con la URL de este repositorio de GitHub.
3. Una 
