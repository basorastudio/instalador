#!/bin/bash
# 
# funciones para configurar el frontend de la aplicación

#######################################
# instala paquetes de node
# Argumentos:
#   Ninguno
#######################################
frontend_node_dependencies() {
  print_banner
  printf "${WHITE} 💻 Instalando dependencias del frontend...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/whazing/frontend
  npm install --force
EOF

  sleep 2
}

frontend_quasar() {
  print_banner
  printf "${WHITE} 💻 Instalando dependencias del frontend...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  cd /home/deploy/whazing/frontend
  sudo npm i @quasar/cli
EOF

  sleep 2
}

#######################################
# compila el código del frontend
# Argumentos:
#   Ninguno
#######################################
frontend_node_build() {
  print_banner
  printf "${WHITE} 💻 Compilando el código del frontend...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/whazing/frontend
  npx update-browserslist-db@latest --yes
  export NODE_OPTIONS=--openssl-legacy-provider
  npx quasar build -P -m pwa
EOF

  sleep 2
}


#######################################
# configura las variables de entorno del frontend
# Argumentos:
#   Ninguno
#######################################
frontend_set_env() {
  print_banner
  printf "${WHITE} 💻 Configurando variables de entorno (frontend)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  # asegurar idempotencia
  backend_url=$(echo "${backend_url/https:\/\/}")
  backend_url=${backend_url%%/*}
  backend_url=https://$backend_url

sudo su - deploy << EOF
  cat <<[-]EOF > /home/deploy/whazing/frontend/.env
URL_API=${backend_url}
FACEBOOK_APP_ID='23156312477653241'
[-]EOF
EOF

  sleep 2
}

#######################################
# inicia el frontend usando pm2 en
# modo producción.
# Argumentos:
#   Ninguno
#######################################
frontend_start_pm2() {
  print_banner
  printf "${WHITE} 💻 Iniciando pm2 (backend)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/whazing/frontend
  pm2 start server.js --name whazing-frontend
  pm2 save
EOF

  sleep 2
}

#######################################
# configura nginx para el frontend
# Argumentos:
#   Ninguno
#######################################
frontend_nginx_setup() {
  print_banner
  printf "${WHITE} 💻 Configurando nginx (frontend)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  frontend_hostname=$(echo "${frontend_url/https:\/\/}")

sudo su - root << EOF

cat > /etc/nginx/sites-available/whazing-frontend << 'END'
server {
  server_name $frontend_hostname;
  
    location / {
    proxy_pass http://127.0.0.1:3333;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-Proto \$scheme;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_cache_bypass \$http_upgrade;
  }
}


END

ln -s /etc/nginx/sites-available/whazing-frontend /etc/nginx/sites-enabled
EOF

  sleep 2
}
