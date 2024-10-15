
## Liberar SSL mediante Cloudflare como alternativa

## EJECUTAR LOS COMANDOS A CONTINUACIÓN ##

```bash
sudo apt-get update
```

```bash
sudo apt-get install certbot
```

```bash
sudo apt-get install python3-certbot-dns-cloudflare
```

```bash
sudo apt-get install python3-certbot-nginx
```

Crear este archivo con los datos abajo, con nano para guardar presiona Ctrl + x
```bash
nano cloudflare.ini
```

```bash
dns_cloudflare_email = tu email
dns_cloudflare_api_key = tu api
```

Ejemplo usando el usuario deploy, si es otro usuario cambia los datos
```bash
mkdir -p /home/deploy/.secrets/certbot/
```

```bash
mv cloudflare.ini /home/deploy/.secrets/certbot
```

```bash
sudo certbot certonly --dns-cloudflare --dns-cloudflare-credentials /home/deploy/.secrets/certbot/cloudflare.ini -d frontend.tudominio.com -d backend.tudominio.com --dns-cloudflare-propagation-seconds 60
```

```bash
sudo certbot --nginx
```
