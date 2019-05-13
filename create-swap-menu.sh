#!/bin/bash

clear
echo -e " \033[34;47m SCRIPT PARA CREAR ARCHIVO SWAP \033[0m"
echo -e " \033[34;47m SELECCIONA UNA OPCIÓN: \033[0m"
echo " 1.-Crear swap."
echo " 2.-Activar swap."
echo " 3.-Eliminar archivos swap."

    read opcion
    case $opcion in

    1) echo "Escribe la cantidad de swap deseada en unidad numerica sera tomada en Gigabytes :"
    
    echo ""
    
    read gygas

    sudo cp /etc/fstab /etc/fstab.bak
    
    swapoff -a

    rm -f /swapfile 

    dd if=/dev/zero of=/swapfile bs=1G count=$gygas status=progress && sync

    echo -e " \033[34m copia de fstab hecha en /etc/fstab.bak \033[0m";;

    2) echo "Activado"
    chmod 600 /swapfile

    mkswap /swapfile

    swapon /swapfile

    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

    echo '/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab

    echo "Swap total: " `free -m | grep Swap | awk '{print $(2)}'` Mb

    echo "Swap usada: " `free -m | grep Swap | awk '{print $(3)}'` Mb

    echo "Swap libre: " `free -m | grep Swap | awk '{print $(4)}'` Mb
    
        ;;
    
        3) echo "¿Quieres Eliminar swap? s/S para SI , n/N para No "

        read opcion
        case $opcion in
        s|S) echo "Eliminado"

        swapoff -a

        sed -i 's/^.*swap.*$//gm' /etc/fstab

        rm -f /swapfile

        echo "fstab restaurado"

        ;;

        n|N) echo "Cancelado"
        ;;

        *) echo "Elige una opcion valida";;

        esac
    esac
while true
do
 read -r -p "¿Deseas Continuar digite? Para continuar:[Y/yes] Para Salir: [quit] [q]:  " input
 
 case $input in
     [yY][eE][sS]|[yY])
#!/bin/bash

clear
echo -e " \033[34;47m SCRIPT PARA CREAR ARCHIVO SWAP \033[0m"
echo -e " \033[34;47m SELECCIONA UNA OPCIÓN: \033[0m"
echo " 1.-Crear swap."
echo " 2.-Activar swap."
echo " 3.-Eliminar archivos swap."

    read opcion
    case $opcion in

    1) echo "Escribe la cantidad de swap deseada en unidad numerica sera tomada en Gigabytes :"
    
    echo ""
    
    read gygas

    sudo cp /etc/fstab /etc/fstab.bak
    
    swapoff -a

    rm -f /swapfile 

    dd if=/dev/zero of=/swapfile bs=1G count=$gygas status=progress && sync

    echo -e " \033[34m copia de fstab hecha en /etc/fstab.bak \033[0m";;

    2) echo "Activado"
    chmod 600 /swapfile

    mkswap /swapfile

    swapon /swapfile

    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

    echo '/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab

    echo "Swap total: " `free -m | grep Swap | awk '{print $(2)}'` Mb

    echo "Swap usada: " `free -m | grep Swap | awk '{print $(3)}'` Mb

    echo "Swap libre: " `free -m | grep Swap | awk '{print $(4)}'` Mb
    
        ;;
    
        3) echo "¿Quieres Eliminar swap? s/S para SI , n/N para No "

        read opcion
        case $opcion in
        s|S) echo "Eliminado"

        swapoff -a

        sed -i 's/^.*swap.*$//gm' /etc/fstab

        rm -f /swapfile

        echo "fstab restaurado"

        ;;

        n|N) echo "Cancelado"
        ;;

        *) echo "Elige una opcion valida";;

        esac
    esac
     ;;
    quit | [Qq])

exit
        ;;


     *)
 echo "Letra no valida..."
 ;;
 esac
done

exit 0
