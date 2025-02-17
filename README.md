[![Grupo do WhatsApp](https://img.shields.io/badge/WhatsApp-Grupo%20Whazing-brightgreen.svg)](https://chat.whatsapp.com/KAk11eaAfRu6Bp13wQX6MB)

**IMPORTANTE**: 

- [Términos de USO](https://github.com/basorastudio/Whazing-SaaS/blob/main/docs/TermosdeUso.md)

- [Contrato de Licencia](https://github.com/basorastudio/Whazing-SaaS/blob/main/LICENSE)



Versión gratis*

- Límites de la versión gratis 
- 10 usuarios
- 2 canales
- Soporte WhatsApp Api Bayles
- Soporte Facebook e Instagram y WebChat - VIA HUB - Necesario pagar mensualidad por canal dudas (48) 9941-6725
- Verificar premium abajo para saber diferencias

Versión Premium*

- No posee límites
- Kanban
- Integración WebHook/N8N - TypeBot - Groq - ChatGPT - DeepSeek
- Transcripción de audio
- Tareas
- Evaluación de atención
- Generación PDF atención
- Informe de tickets
- Notas en tickets
- Mensajes separados por filas
- Transferir atención a ChatBot
- Retirada mensaje "Enviado vía Whazing" en el módulo campañas

- Instalador versión premium TypeBot, N8N y Wordpress


-  [Tabla de Valores versión premium y servicio de instalación](https://github.com/basorastudio/Whazing-SaaS/blob/main/docs/TabeladeValores.md)

## CREAR SUBDOMINIO Y APUNTAR AL IP DE SU VPS

Requisitos

Ubuntu 20 con mínimo 8GB memoria
2 dns del backend y del frontend


## CHECAR PROPAGACIÓN DEL DOMINIO

https://dnschecker.org/

## EJECUTAR LOS COMANDOS ABAJO PARA INSTALAR

para evitar errores recomendamos actualizar sistema y después de actualizar reiniciar para evitar errores
```bash
sudo su root
```
```bash
apt -y update && apt -y upgrade
```
```bash
reboot
```
 
Después de reiniciar seguir con la instalación
```bash
sudo su root
```
```bash
apt install git
```
```bash
cd /root
```
```bash
git clone https://github.com/basorastudio/Whazing-SaaS.instalador.git whazinginstalador
```
```bash
sudo chmod +x ./whazinginstalador/whazing
```
```bash
cd ./whazinginstalador
```

## Importante cambiar contraseñas predeterminadas para evitar ataques

Editar datos con sus datos, con nano para guardar presione Ctrl + x
O con acceso vps por la aplicación que prefiera

- Use solo letras y números, no use caracteres especiales

```bash
nano config
```

```bash
sudo ./whazing
```

## EJECUTAR LOS COMANDOS ABAJO PARA ACTUALIZAR
```bash
sudo su root
```
```bash
cd /root
```
```bash
cd ./whazinginstalador
```
```bash
sudo ./whazing
```

## Cambiar Frontend

Use configuración del Menú empresas para cambiar nombre del sitio y LOGOS 

## Errores

En caso de no iniciar en la primera instalación use opción 2 para actualizar puede ser algún archivo no se descargó correctamente

"Internal server error: SequelizeConnectionError: could not open file \"global/pg_filenode.map\": Permission denied"

```bash
docker container restart postgresql
```
```bash
docker exec -u root postgresql bash -c "chown -R postgres:postgres /var/lib/postgresql/data"
```
```bash
docker container restart postgresql
```

## Acceso Portainer generar contraseña
"Your Portainer instance timed out for security purposes. To re-enable your Portainer instance, you will need to restart Portainer."

```bash
docker container restart portainer
```

Después acceda nuevamente url http://seuip:9000/

## Recomendación de VPS buena y barata

-  [Powerful cloud VPS & Web hosting.](https://control.peramix.com/?affid=58)

- Cupón 25% descuento "WHAZING"

```bash
WHAZING
```

#### ¿Te gustó? ¡Apoya el proyecto! Con tu donación, será posible continuar con las actualizaciones. Sigue el código QR (PIX)  

[<img src="donate.jpg" height="160" width="180"/>](donate.jpg)

## Consultoría particular

Para consultoría particular llamar (se cobrará por esto) 48 999416725 

Versión api en bayles# Whazing-SaaS.instalador-main
# chat-install
