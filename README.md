[![Grupo de WhatsApp](https://img.shields.io/badge/WhatsApp-Grupo%20Whazing-brightgreen.svg)](https://chat.whatsapp.com/KAk11eaAfRu6Bp13wQX6MB)

**IMPORTANTE**: 

- [Términos de USO](https://github.com/basorastudio/whazing/blob/main/docs/TermosdeUso.md)

- [Contrato de Licencia](https://github.com/basorastudio/whazing/blob/main/LICENSE)

Versión gratuita*

- Límites de la versión gratuita
- 10 usuarios
- 2 canales 
- Soporte WhatsApp Api Bayles
- Soporte Facebook, Instagram y WebChat - VIA HUB - Necesario pagar mensualidad por canal dudas (48) 9941-6725
- Verificar premium abajo para saber diferencias

Versión Premium*

- Sin límites
- Kanban
- Integración WebHook/N8N - TypeBot - Groq - ChatGPT - DeepSeek
- Transcripción de audio
- Tareas
- Evaluación de atención
- Generación PDF de atención
- Informe de tickets
- Anotaciones en tickets 
- Mensajes separados por colas
- Transferir atención a ChatBot
- Eliminación mensaje "Enviado vía Whazing" en módulo campañas

- Instalador versión premium TypeBot, N8N y Wordpress

- [Tabla de Valores versión premium y servicio de instalación](https://github.com/basorastudio/whazing/blob/main/docs/TabeladeValores.md)

## CREAR SUBDOMINIO Y APUNTAR AL IP DE TU VPS

Requisitos

Ubuntu 20 con mínimo 8GB memoria
2 dns del backend y del frontend

## VERIFICAR PROPAGACIÓN DEL DOMINIO

https://dnschecker.org/

## EJECUTAR LOS COMANDOS ABAJO PARA INSTALAR

Para evitar errores se recomienda actualizar sistema y después reiniciar para evitar errores
```bash
sudo su root
```
```bash
apt -y update && apt -y upgrade
```
```bash
reboot
```
 
Después reiniciar seguir con la instalación
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
git clone https://github.com/basorastudio/instalador.git whazinginstalador
```
```bash
sudo chmod +x ./whazinginstalador/whazing
```
```bash
cd ./whazinginstalador
```

## Importante cambiar contraseñas predeterminadas para evitar ataques

Editar datos con tus datos, con nano para guardar presiona Ctrl + x
O con acceso vps por la aplicación que prefieras

- Usa solo letras y números, no uses caracteres especiales

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

## Modificar Frontend

Usar configuración del Menú empresas para cambiar nombre del sitio y LOGOS

## Errores

Si no inicia en la primera instalación use opción 2 para actualizar puede ser que algún archivo no se descargó correctamente

"Error interno del servidor: SequelizeConnectionError: no se pudo abrir el archivo \"global/pg_filenode.map\": Permiso denegado"

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
"Tu instancia de Portainer expiró por motivos de seguridad. Para reactivar tu instancia de Portainer, necesitarás reiniciar Portainer."

```bash
docker container restart portainer
```

Después accede nuevamente url http://seuip:9000/

## Recomendación de VPS buena y económica

- [Potente VPS en la nube & Hosting Web.](https://control.peramix.com/?affid=58)

- Cupón 25% descuento "WHAZING"

```bash
WHAZING
```

#### ¿Te gustó? ¡Apoya el proyecto! Con tu donación, será posible continuar con las actualizaciones. Sigue el QR code (PIX)

[<img src="donate.jpg" height="160" width="180"/>](donate.jpg)

## Consultoría particular

Para consultoría particular contactar (será cobrado por esto) 48 999416725

Versión api en bayles# instalador
