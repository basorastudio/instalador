
[![Grupo de WhatsApp](https://img.shields.io/badge/WhatsApp-Grupo%20Whazing-brightgreen.svg)](https://chat.whatsapp.com/KAk11eaAfRu6Bp13wQX6MB)

**IMPORTANTE**:

- [Términos de USO](https://github.com/cleitonme/Whazing-SaaS/blob/main/docs/TermosdeUso.md)

- [Contrato de Licencia](https://github.com/cleitonme/Whazing-SaaS/blob/main/LICENSE)

Versión gratis* - para siempre no tendrá bloqueos

- Límites de la versión gratis: 10 usuarios y 2 canales

Versión Premium*

- No posee límites

- [Tabla de Valores versión premium y servicio de instalación](https://github.com/cleitonme/Whazing-SaaS/blob/main/docs/TabeladeValores.md)

## CREAR SUBDOMINIO Y APUNTAR AL IP DE SU VPS

Requisitos

Ubuntu 20 con mínimo 8GB de memoria
2 DNS del backend y del frontend

## VERIFICAR LA PROPAGACIÓN DEL DOMINIO

https://dnschecker.org/

## EJECUTAR LOS COMANDOS A CONTINUACIÓN PARA INSTALAR

Para evitar errores, es recomendable actualizar el sistema y, después de actualizar, reiniciar para evitar errores
```bash
sudo su root
```
```bash
apt -y update && apt -y upgrade
```
```bash
reboot
```

Después de reiniciar, continuar con la instalación
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
```bash
sudo ./whazing
```

## EJECUTAR LOS COMANDOS A CONTINUACIÓN PARA ACTUALIZAR
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

Utilice la configuración del Menú de empresas para cambiar el nombre del sitio y los LOGOS

## Errores

Si no se inicia en la primera instalación, use la opción 2 para actualizar. Puede ser que algún archivo no se haya descargado correctamente.

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

## Acceso a Portainer para generar contraseña

"Su instancia de Portainer se agotó por motivos de seguridad. Para reactivar su instancia de Portainer, necesitará reiniciar Portainer."
```bash
docker container restart portainer
```

Luego acceda nuevamente a la URL http://suip:9000/

## Recomendación de VPS buena y barata

- [Powerful cloud VPS & Web hosting.](https://control.peramix.com/?affid=58)

- Cupón 25% de descuento "WHAZING"

```bash
WHAZING
```

## Consultoría particular

Para consultoría particular, contactar (esto tendrá un costo) al 48 999416725

Versión API en bayles
