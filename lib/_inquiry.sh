#!/bin/bash

get_frontend_url() {
  print_banner
  printf "${WHITE} 💻 Ingrese el dominio de la interfaz web (Frontend):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " frontend_url
}

get_backend_url() {
  print_banner
  printf "${WHITE} 💻 Ingrese el dominio de su API (Backend):${GRAY_LIGHT}"
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

whazing_atualizar_beta() {
  system_pm2_stop
  apagar_distsrc
  update_beta
  backend_node_dependencies
  backend_node_build
  backend_db_migrate
  system_pm2_start
  frontend_node_dependencies
  frontend_node_build
}

inquiry_options() {

  print_banner
  printf "\n\n"
  printf "${WHITE} 💻 ¿Qué necesitas hacer?${GRAY_LIGHT}"
  printf "\n\n"
  printf "   [1] Instalar\n"
  printf "   [2] Actualizar whazing(antes de actualizar haga una Snapshot de la VPS\n"
  printf "   [3] Activar Firewall\n"
  printf "   [4] Desactivar Firewall\n"
  printf "   [5] Error global/pg_filenode.map\n"
  printf "   [6] Instalar N8N - requiere 1 dominio\n"
  printf "   [7] Instalar TypeBot - requiere 4 dominios\n"
  printf "   [8] Instalar Wordpress - requiere 1 dominio\n"
  printf "   [9] Dominio con error SSL\n"
  printf "   [10] Liberar acceso portainer dominio SSL - requiere 1 dominio\n"
  printf "   [11] Actualizar whazing BETA(antes de actualizar haga una Snapshot de la VPS\n"
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
	  
    6) 
      Recurso_Premium
      exit
      ;;
	  
    7) 
      Recurso_Premium
      exit
      ;;
	  
    8) 
      Recurso_Premium
      exit
      ;;

    9) 
      Recurso_Premium
      exit
      ;;
	  
    10) 
      Recurso_Premium
      exit
      ;;
	    
    11) 
      whazing_atualizar_beta
      exit
      ;;

    *) exit ;;
  esac
}

