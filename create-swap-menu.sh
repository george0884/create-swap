#!/bin/bash

# Verificar root al inicio
if [ "$EUID" -ne 0 ]; then
  echo "Ejecuta el script como root: sudo ./create-swap-menu.sh"
  exit 1
fi

# Backup fstab silencioso
cp /etc/fstab /etc/fstab.bak >/dev/null 2>&1

# ─────────────────────────────────────────
# FUNCIONES
# ─────────────────────────────────────────

mostrar_menu() {
  clear
  echo -e " \033[34;47m SCRIPT PARA CREAR ARCHIVO SWAP \033[0m"
  echo -e " \033[34;47m SELECCIONA UNA OPCIÓN:         \033[0m"
  echo " 1.-Crear swap."
  echo " 2.-Activar swap."
  echo " 3.-Eliminar y desactivar swap."
  echo " 4.-Corroborar estado de swap y ram."
  echo " 5.-Optimizar swappiness."
  echo " 6.-Reiniciar sistema."
  echo " 7.-Apagar sistema."
  echo " 0.-Salir."
  echo ""
}

crear_swap() {
  echo "Escribe la cantidad de swap deseada en Gigabytes:"
  read gygas

  # Validar que sea número entero mayor a 0
  if ! [[ "$gygas" =~ ^[0-9]+$ ]] || [ "$gygas" -lt 1 ]; then
    echo -e "\033[31m Error: ingresa un número válido mayor a 0. \033[0m"
    return
  fi

  # Desactiva y elimina swap anterior
  swapoff -a
  rm -f /swapfile

  # Crear swapfile con fallocate (más rápido que dd)
  if command -v fallocate &>/dev/null; then
    fallocate -l ${gygas}G /swapfile
  else
    dd if=/dev/zero of=/swapfile bs=1G count=$gygas status=progress && sync
  fi

  echo -e "\033[32m Swapfile de ${gygas}G creado. Ahora usa la opción 2 para activarlo. \033[0m"
  echo -e "\033[34m Copia de fstab hecha en /etc/fstab.bak \033[0m"
}

activar_swap() {
  if [ ! -f /swapfile ]; then
    echo -e "\033[31m No existe /swapfile. Primero crea el swap con la opción 1. \033[0m"
    return
  fi

  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile

  # Limpiar entradas swap anteriores y agregar la nueva
  sed -i '/swap/d' /etc/fstab
  echo "/swapfile none swap defaults 0 0" >> /etc/fstab

  echo -e "\033[32m Swap activado correctamente. \033[0m"
  cat /etc/fstab
}

eliminar_swap() {
  echo "¿Quieres eliminar el swap? [s/S] SI  [n/N] NO"
  read confirmacion
  case $confirmacion in
    s|S)
      swapoff -a
      sed -i '/swap/d' /etc/fstab
      rm -f /swapfile
      echo -e "\033[32m Swap eliminado y fstab restaurado. \033[0m"
      ;;
    n|N)
      echo "Cancelado."
      ;;
    *)
      echo "Opción no válida."
      ;;
  esac
}

estado_swap() {
  echo -e "\033[34m Estado de la memoria SWAP y RAM: \033[0m"
  echo "Swap total: $(free -m | awk '/Swap/{print $2}') Mb"
  echo "Swap usada: $(free -m | awk '/Swap/{print $3}') Mb"
  echo "Swap libre: $(free -m | awk '/Swap/{print $4}') Mb"
  echo ""
  free -h
}

optimizar_swappiness() {
  echo "El swappiness puede tener valor entre 1 y 100."
  echo "  0 = no intercambiar casi nunca"
  echo "100 = intercambiar lo más pronto posible"
  echo ""
  echo "a.-Ver swappiness actual"
  echo "b.-Cambiar swappiness"
  echo "c.-Restaurar valor por default"
  read subopcion

  case $subopcion in
    a)
      echo "Swappiness actual: $(cat /proc/sys/vm/swappiness)"
      ;;
    b)
      echo "Ingresa un número entre 1 y 100:"
      read valor
      if ! [[ "$valor" =~ ^[0-9]+$ ]] || [ "$valor" -lt 1 ] || [ "$valor" -gt 100 ]; then
        echo -e "\033[31m Error: valor no válido. \033[0m"
        return
      fi
      # Aplicar inmediatamente
      sysctl -w vm.swappiness=$valor
      # Guardar en sysctl.conf sin duplicar
      sed -i '/vm.swappiness/d' /etc/sysctl.conf
      echo "vm.swappiness = $valor" >> /etc/sysctl.conf
      echo -e "\033[32m Swappiness cambiado a $valor. \033[0m"
      cat /etc/sysctl.conf
      ;;
    c)
      sed -i '/vm.swappiness/d' /etc/sysctl.conf
      echo -e "\033[32m Swappiness eliminado de sysctl.conf. Volverá al default en el próximo reinicio. \033[0m"
      ;;
    *)
      echo "Opción no válida."
      ;;
  esac
}

# ─────────────────────────────────────────
# BUCLE PRINCIPAL
# ─────────────────────────────────────────

while true; do
  mostrar_menu
  read opcion

  case $opcion in
    1) crear_swap ;;
    2) activar_swap ;;
    3) eliminar_swap ;;
    4) estado_swap ;;
    5) optimizar_swappiness ;;
    6) echo "Reiniciando..."; sleep 2; systemctl reboot ;;
    7) echo "Apagando..."; sleep 2; systemctl poweroff ;;
    0) echo "Hasta luego."; exit 0 ;;
    *) echo -e "\033[31m Opción no válida. \033[0m" ;;
  esac

  echo ""
  read -r -p "Presiona Enter para continuar..."
done
