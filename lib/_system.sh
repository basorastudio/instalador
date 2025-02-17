#!/bin/bash
# 
# gestión del sistema

#######################################
# crea usuario
# Arguments:
#   None
#######################################
system_create_user() {
  print_banner
  printf "${WHITE} 💻 Ahora, vamos a crear el usuario para el deploy...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  useradd -m -s /bin/bash -G sudo deploy 2>/dev/null || echo "Usuário já existe, continuando..."
  echo "deploy:$deploy_password" | chpasswd
  passwd -u deploy 2>/dev/null
  echo "deploy ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/deploy > /dev/null
  usermod -aG sudo deploy
EOF

  sleep 2
}


instalacao_firewall() {
  print_banner
  printf "${WHITE} 💻 Ahora, vamos a instalar y activar el firewall UFW...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 22
ufw allow 80
ufw allow 443
ufw allow 9000
ufw --force enable
echo "{\"iptables\": true}" > /etc/docker/daemon.json
systemctl restart docker
sed -i -e 's/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw
ufw reload
wget -q -O /usr/local/bin/ufw-docker https://github.com/chaifeng/ufw-docker/raw/master/ufw-docker
chmod +x /usr/local/bin/ufw-docker
ufw-docker install
systemctl restart ufw


EOF

  sleep 60
}

iniciar_firewall() {
  print_banner
  printf "${WHITE} 💻 Iniciando Firewall...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  service ufw start
  
EOF

  sleep 2
}

parar_firewall() {
  print_banner
  printf "${WHITE} 💻 Deteniendo Firewall (atención: su servidor quedará desprotegido)...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  service ufw stop
  
EOF

  sleep 2
}

#######################################
# configura zona horaria
# Arguments:
#   None
#######################################
system_set_timezone() {
  print_banner
  printf "${WHITE} 💻 Configurando zona horaria...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  timedatectl set-timezone America/Santo_ Domingo
EOF

  sleep 2
}

#######################################
# descomprime whazing
# Arguments:
#   None
#######################################
system_unzip_whazing() {
  print_banner
  printf "${WHITE} 💻 Clonando whazing...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  git clone https://github.com/basorastudio/whazing.git /home/deploy/whazing
  cd /home/deploy/whazing
  unzip -o whazing.zip
  chmod 775 /home/deploy/whazing/ -Rf
  unzip -o logos.zip
  chmod 775 /home/deploy/whazing/ -Rf
EOF

  sleep 2
}

erro_banco() {
  print_banner
  printf "${WHITE} 💻 Estamos corrigiendo...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  docker container restart postgresql
  docker exec -u root postgresql bash -c "chown -R postgres:postgres /var/lib/postgresql/data"
  docker container restart postgresql
  
EOF

  sleep 2
}

apagar_distsrc() {
  print_banner
  printf "${WHITE} 💻 Borrando archivos de versión anterior${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  cd /home/deploy/whazing/backend
  rm dist/ -Rf
  rm node_modules/ -Rf
  rm package.json -Rf
  rm package-lock.json -Rf
  cd /home/deploy/whazing/frontend  
  rm dist/ -Rf
  rm src/ -Rf
EOF

  sleep 2
}

#######################################
# actualiza whazing
# Arguments:
#   None
#######################################
git_update() {
  print_banner
  printf "${WHITE} 💻 Actualizando whazing desde git...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/whazing
  pm2 stop all
  rm whazing.zip
  wget https://github.com/basorastudio/whazing/raw/refs/heads/main/whazing.zip
  unzip -o whazing.zip
  chmod 775 /home/deploy/whazing/ -Rf
EOF

  sleep 2
}

#######################################
# actualiza sistema
# Arguments:
#   None
#######################################
system_update() {
  print_banner
  printf "${WHITE} 💻 Vamos a actualizar el sistema...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt -y update && apt -y upgrade
  apt autoremove -y
  sudo ufw allow 443/tcp
  sudo ufw allow 80/tcp
EOF

  sleep 2
}

#######################################
# instala node
# Arguments:
#   None
#######################################
system_node_install() {
  print_banner
  printf "${WHITE} 💻 Instalando nodejs...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  apt-get install -y nodejs
EOF

  sleep 2
}

#######################################
# instala docker
# Arguments:
#   None
#######################################
system_docker_install() {
  print_banner
  printf "${WHITE} 💻 Instalando docker...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
  apt install -y docker-ce
EOF

  sleep 2
}

#######################################
# Pregunta por la ubicación del archivo que contiene
# múltiples URL para streaming.
# Globals:
#   WHITE
#   GRAY_LIGHT
#   BATCH_DIR
#   PROJECT_ROOT
# Arguments:
#   None
#######################################
system_puppeteer_dependencies() {
  print_banner
  printf "${WHITE} 💻 Instalando dependencias de puppeteer...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
apt install -y bash sudo curl
apt install -y ffmpeg ufw apt-transport-https ca-certificates software-properties-common curl libgbm-dev wget unzip fontconfig locales gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils python2-minimal build-essential libxshmfence-dev nginx unzip fail2ban
EOF

  sleep 2
}

system_pm2_stop() {
  print_banner
  printf "${WHITE} 💻 Deteniendo whazing...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  pm2 stop all
EOF

  sleep 2
}

system_pm2_start() {
  print_banner
  printf "${WHITE} 💻 Iniciando whazing...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  pm2 start all
EOF

  sleep 2
}


#######################################
# instala pm2
# Arguments:
#   None
#######################################
system_pm2_install() {
  print_banner
  printf "${WHITE} 💻 Instalando pm2...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  npm install -g pm2
  pm2 startup ubuntu -u deploy
  env PATH=\$PATH:/usr/bin pm2 startup ubuntu -u deploy --hp /home/deploy
  echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf
  sysctl -p
EOF

  sleep 2
}

#######################################
# optimización redis
# Arguments:
#   None
#######################################
system_sysctl() {
  print_banner
  printf "${WHITE} 💻 Alterando parámetros del sistema...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf
  echo never > /sys/kernel/mm/transparent_hugepage/enabled
  echo 'vm.swappiness = 1' >> /etc/sysctl.conf
  sysctl -p
EOF

  sleep 2
}


#######################################
# instala snapd
# Arguments:
#   None
#######################################
system_snapd_install() {
  print_banner
  printf "${WHITE} 💻 Instalando snapd...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt install -y snapd
  systemctl start snapd
  systemctl enable snapd
  snap install core
  snap refresh core
EOF

  sleep 2
}

#######################################
# instala certbot
# Arguments:
#   None
#######################################
system_certbot_install() {
  print_banner
  printf "${WHITE} 💻 Instalando certbot...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  apt-get remove certbot
  snap install --classic certbot
  ln -s /snap/bin/certbot /usr/bin/certbot
EOF

  sleep 2
}

#######################################
# instala nginx
# Arguments:
#   None
#######################################
system_nginx_install() {
  print_banner
  printf "${WHITE} 💻 Instalando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  rm /etc/nginx/sites-enabled/default
EOF

  sleep 2
}

#######################################
# install_chrome
# Arguments:
#   None
#######################################
system_set_user_mod() {
  print_banner
  printf "${WHITE} 💻 Vamos a actualizar el sistema...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  sudo usermod -aG docker deploy
  su - deploy
EOF

  sleep 2
}

criar_cron() {
  print_banner
  printf "${WHITE} 💻 Crear cron...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
(crontab -l -u deploy | grep -v "/usr/bin/node /usr/bin/pm2 restart all"; echo "0 */4 * * * /usr/bin/node /usr/bin/pm2 restart all") | crontab -u deploy -
EOF

  sleep 2
}

#######################################
# reinicia nginx
# Arguments:
#   None
#######################################
system_nginx_restart() {
  print_banner
  printf "${WHITE} 💻 reiniciando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  service nginx restart
EOF

  sleep 2
}

#######################################
# configuración para nginx.conf
# Arguments:
#   None
#######################################
system_nginx_conf() {
  print_banner
  printf "${WHITE} 💻 configurando nginx...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

sudo su - root << EOF

cat > /etc/nginx/conf.d/whazing.conf << 'END'
client_max_body_size 100M;
large_client_header_buffers 16 5120k;
END

EOF

  sleep 2
}

#######################################
# instala nginx
# Arguments:
#   None
#######################################
system_certbot_setup() {
  print_banner
  printf "${WHITE} 💻 Configurando certbot...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  backend_domain=$(echo "${backend_url/https:\/\/}")
  frontend_domain=$(echo "${frontend_url/https:\/\/}")
  admin_domain=$(echo "${admin_url/https:\/\/}")

  sudo su - root <<EOF
  certbot -m $deploy_email \
          --nginx \
          --agree-tos \
          --non-interactive \
          --domains $backend_domain,$frontend_domain
EOF

  sleep 2
}

#######################################
# reinicia
# Arguments:
#   None
#######################################
system_reboot() {
  print_banner
  printf "${WHITE} 💻 Reboot...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  reboot
EOF

  sleep 2
}

#######################################
# crea docker db
# Arguments:
#   None
#######################################
system_docker_start() {
  print_banner
  printf "${WHITE} 💻 Iniciando container docker...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  docker stop $(docker ps -q)
  docker container start postgresql
  docker container start redis-whazing
  docker exec -u root postgresql bash -c "chown -R postgres:postgres /var/lib/postgresql/data"
EOF

  sleep 2
}

#######################################
# crea docker db
# Arguments:
#   None
#######################################
system_docker_restart() {
  print_banner
  printf "${WHITE} 💻 Iniciando container docker...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - root <<EOF
  docker container restart redis-whazing
  docker container restart portainer
  docker container restart postgresql
  docker exec -u root postgresql bash -c "chown -R postgres:postgres /var/lib/postgresql/data"
EOF

  sleep 60
}



#######################################
# crea mensaje final
# Arguments:
#   None
#######################################
system_success() {

echo $deploy_password > /root/senhadeploy

  print_banner
  printf "${GREEN} 💻 Instalación completada con Éxito...${NC}"
  printf "${CYAN_LIGHT}";
  printf "\n\n"
  printf "\n"
  printf "Usuario: admin@admin.com"
  printf "\n"
  printf "Contraseña: 123456"
  printf "\n"
  printf "URL front: https://$frontend_domain"
  printf "\n"
  printf "URL back: https://$backend_domain"
  printf "\n"
  printf "Contraseña Usuario deploy: $deploy_password"
  printf "\n"
  printf "Usuario de Base de Datos: whazing"
  printf "\n"
  printf "Nombre de Base de Datos: postgres"
  printf "\n"
  printf "Contraseña de Base de Datos: $pg_pass"
  printf "\n"
  printf "Contraseña de Redis: $redis_pass"
  printf "\n"
  printf "Contraseña de Rabbit: $rabbit_pass"
  printf "\n"
  printf "${NC}";

  sleep 2
}

#######################################
# actualiza whazing
# Arguments:
#   None
#######################################
update_beta() {
  print_banner
  printf "${WHITE} 💻 Actualizando el whazing Beta...${GRAY_LIGHT}"
  printf "\n\n"

  sleep 2

  sudo su - deploy <<EOF
  cd /home/deploy/whazing
  pm2 stop all
  rm whazing.zip
  wget https://github.com/basorastudio/whazing-Beta/raw/refs/heads/main/whazing.zip
  unzip -o whazing.zip
  chmod 775 /home/deploy/whazing/ -Rf
EOF

  sleep 2
}

Recurso_Premium() {


  print_banner
  printf "${GREEN} Recurso exclusivo de la versión premium...${NC}"
  printf "${CYAN_LIGHT}";
  printf "\n\n"
  printf "\n"
  printf "Adquiéralo ya (48) 99941-6725"

  printf "\n"
  printf "\n"
  printf "${NC}";

  sleep 30
}