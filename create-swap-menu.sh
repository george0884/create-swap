#!/bin/bash

clear
echo " * SCRIPT PARA CREAR ARCHIVO SWAP * "
echo " SELECCIONA UNA OPCIÓN:"
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
    echo "copia de fstab hecha en /etc/fstab.bak";;

    2) echo "Activado"
    chmod 600 /swapfile

    mkswap /swapfile

    swapon /swapfile

    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
    
        ;;
    
        3) echo "¿Quieres Eliminar swap? s/S para SI , n/N para No "

        read opcion
        case $opcion in
        s|S) echo "Eliminado"

        swapoff -a

        rm -f /swapfile

        sudo mv /etc/fstab.bak /etc/fstab
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
echo " * SCRIPT PARA CREAR ARCHIVO SWAP * "
echo " SELECCIONA UNA OPCIÓN:"
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
    echo "copia de fstab hecha en /etc/fstab.bak";;

    2) echo "Activado"
    chmod 600 /swapfile

    mkswap /swapfile

    swapon /swapfile

    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
    
        ;;
    
        3) echo "¿Quieres Eliminar swap? s/S para SI , n/N para No "

        read opcion
        case $opcion in
        s|S) echo "Eliminado"

        swapoff -a

        rm -f /swapfile

        sudo mv /etc/fstab.bak /etc/fstab
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
