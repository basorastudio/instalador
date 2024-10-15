#!/bin/bash

get_frontend_url() {
  print_banner
  printf "${WHITE} 💻 Introduce el dominio de la interfaz web (Frontend):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " frontend_url
}

get_backend_url() {
  print_banner
  printf "${WHITE} 💻 Introduce el dominio de tu API (Backend):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " backend_url
}

get_urls() {
  get_frontend_url
  get_backend_url
}

whazing_atualizar() {
  system_pm2_stop
  apagar_distsrc
  git_update
  backend_node_dependencies
  backend_node_build
  backend_db_migrate
  system_pm2_start
  frontend_node_dependencies
  frontend_node_build
}

ativar_firewall () {
  iniciar_firewall
}

desativar_firewall () {
  parar_firewall
}

Erro_global () {
  erro_banco
}

inquiry_options() {

  print_banner
  printf "\n\n"
  printf "${WHITE} 💻 ¿Qué necesitas hacer?${GRAY_LIGHT}"
  printf "\n\n"
  printf "   [1] Instalar\n"
  printf "   [2] Actualizar Whazing (antes de actualizar, haz un Snapshot de la VPS)\n"
  printf "   [3] Activar Firewall\n"
  printf "   [4] Desactivar Firewall\n"
  printf "   [5] Error global/pg_filenode.map\n"
  printf "\n"
  read -p "> " option

  case "${option}" in
    1) get_urls ;;


    2) 
      whazing_atualizar 
      exit
      ;;


    3) 
      ativar_firewall 
      exit
      ;;
	  
    4) 
      desativar_firewall 
      exit
      ;;
	  
    5) 
      Erro_global 
      exit
      ;;

    *) exit ;;
  esac
}
