## Liberar SSL mediante cloudflare alternativa

## EJECUTAR LOS COMANDOS ABAJO ##


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

ejemplo usando usuario deploy, en caso de ser otro cambiar datos
```bash
mkdir -p /home/deploy/.secrets/certbot/
```

```bash
mv cloudflare.ini /home/deploy/.secrets/certbot
```

```bash
sudo certbot certonly --dns-cloudflare --dns-cloudflare-credentials /home/deploy/.secrets/certbot/cloudflare.ini -d frontend.tudominio.com.br -d backend.tudominio.com.br --dns-cloudflare-propagation-seconds 60
```

```bash
sudo certbot --nginx
```