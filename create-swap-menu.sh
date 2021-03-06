#!/bin/bash

clear
#backup fstab
sudo cp /etc/fstab /etc/fstab.bak >/dev/null 2>&1
echo -e " \033[34;47m SCRIPT PARA CREAR ARCHIVO SWAP \033[0m"
echo -e " \033[34;47m SELECCIONA UNA OPCIÓN: \033[0m"
echo " 1.-Crear swap."
echo " 2.-Activar swap."
echo " 3.-Eliminar y desactivar swap."
echo " 4.-Corroborar estado de swap y ram."
echo " 5.-Optimizar swappiness."
echo " 6.-Reiniciar sistema."
echo " 7.-Apagar sistema."

		read opcion
		case $opcion in
	1) echo "Escribe la cantidad de swap deseada en unidad numerica sera tomada en Gigabytes :"
    
			echo ""
    
			read gygas
				
				#backup fstab
				sudo cp /etc/fstab /etc/fstab.bak
				
				#desactiva swap
				swapoff -a
				
				#elimina swapfile
				rm -f /swapfile 
				
				#crea el archivo swapfile con dd en GBs
				dd if=/dev/zero of=/swapfile bs=1G count=$gygas status=progress && sync

				echo -e " \033[34m copia de fstab hecha en /etc/fstab.bak \033[0m";;

	2) echo "Activado"
			
				#establece los permisos correctos
				chmod 600 /swapfile
				
				#formatea el archivo swapfile
				mkswap /swapfile
				
				#activa swapfile
				swapon /swapfile
				
				#edita fstab para que reconozca el archivo
				sed -i 's/^.*swap.*$//gm' /etc/fstab
				
				echo "/swapfile none swap defaults 0 0" >> /etc/fstab
				
				cat /etc/fstab;;
	
	3) echo "¿Quieres Eliminar swap? s/S para SI , n/N para No "

		read opcion
		case $opcion in
				s|S) echo "Eliminado"

				swapoff -a

				sed -i 's/^.*swap.*$//gm' /etc/fstab

				rm -f /swapfile

				echo "fstab restaurado";;

				n|N) echo "Cancelado";;
			
	*) echo "Elige una opcion valida";;
        
    esac;;
    	
	4) echo "Estado de la memoria SWAP y Ram es.."

				echo "Swap total: " `free -m | grep Swap | awk '{print $(2)}'` Mb

				echo "Swap usada: " `free -m | grep Swap | awk '{print $(3)}'` Mb

				echo "Swap libre: " `free -m | grep Swap | awk '{print $(4)}'` Mb
				
				free -h;;
			
	5) echo "El parámetro de propensión a intercambiar puede tener un valor de entre 1 y 100, donde 0 significa “no intercambiar para nada” y 100 significa “intercambiar lo más pronto posible”"
				echo ""
				echo "a.-Ver cantidad de swappiness asignado"
				echo ""
				echo "b.-Cambiar valor swappiness"
				echo ""
				echo "c.-Eliminar cambios y dejar valor por default"

					read opcion
					case $opcion in

						a) echo "Ver cantidad de swappiness asignado"

								cat /proc/sys/vm/swappiness;;

						b) echo "Ingresa un numero entre 1 y 100 para cambiar el valor swappiness"

								echo ""

								read valor

								echo $valor > /proc/sys/vm/swappiness

								echo "vm.swappiness = $valor" >> /etc/sysctl.conf

								cat /etc/sysctl.conf;;

						c) echo "Listo, el valor volvera por default en el proximo reinicio"

								sed -i 's/^.*swappiness.*$//gm' /etc/sysctl.conf;;

						*) echo "Valor no valido, ingresa el valor correspondiente";;

						esac;;

    6) echo "Hecho, hasta luego"; sleep 2

				sudo systemctl reboot;;

    7) echo "OK, Apagando"; sleep 2

				sudo systemctl poweroff;;

    *) echo "Valor no valido, ingresa el valor correspondiente";;

esac


while true
do
 read -r -p "¿Deseas Continuar digite? Para continuar:[Y/yes] Para Salir: [quit] [q]:  " input
 
 case $input in
     [yY][eE][sS]|[yY])

#!/bin/bash

clear
#backup fstab
sudo cp /etc/fstab /etc/fstab.bak >/dev/null 2>&1
echo -e " \033[34;47m SCRIPT PARA CREAR ARCHIVO SWAP \033[0m"
echo -e " \033[34;47m SELECCIONA UNA OPCIÓN: \033[0m"
echo " 1.-Crear swap."
echo " 2.-Activar swap."
echo " 3.-Eliminar y desactivar swap."
echo " 4.-Corroborar estado de swap y ram."
echo " 5.-Optimizar swappiness."
echo " 6.-Reiniciar sistema."
echo " 7.-Apagar sistema."

		read opcion
		case $opcion in
	1) echo "Escribe la cantidad de swap deseada en unidad numerica sera tomada en Gigabytes :"
    
			echo ""
    
			read gygas
				
				#backup fstab
				sudo cp /etc/fstab /etc/fstab.bak
				
				#desactiva swap
				swapoff -a
				
				#elimina swapfile
				rm -f /swapfile 
				
				#crea el archivo swapfile con dd en GBs
				dd if=/dev/zero of=/swapfile bs=1G count=$gygas status=progress && sync

				echo -e " \033[34m copia de fstab hecha en /etc/fstab.bak \033[0m";;

	2) echo "Activado"
			
				#establece los permisos correctos
				chmod 600 /swapfile
				
				#formatea el archivo swapfile
				mkswap /swapfile
				
				#activa swapfile
				swapon /swapfile
				
				#edita fstab para que reconozca el archivo
				sed -i 's/^.*swap.*$//gm' /etc/fstab
				
				echo "/swapfile none swap defaults 0 0" >> /etc/fstab
				
				cat /etc/fstab;;
	
	3) echo "¿Quieres Eliminar swap? s/S para SI , n/N para No "

		read opcion
		case $opcion in
				s|S) echo "Eliminado"

				swapoff -a

				sed -i 's/^.*swap.*$//gm' /etc/fstab

				rm -f /swapfile

				echo "fstab restaurado";;

				n|N) echo "Cancelado";;
			
	*) echo "Elige una opcion valida";;
        
    esac;;
    	
	4) echo "Estado de la memoria SWAP y Ram es.."

				echo "Swap total: " `free -m | grep Swap | awk '{print $(2)}'` Mb

				echo "Swap usada: " `free -m | grep Swap | awk '{print $(3)}'` Mb

				echo "Swap libre: " `free -m | grep Swap | awk '{print $(4)}'` Mb
				
				free -h;;
			
	5) echo "El parámetro de propensión a intercambiar puede tener un valor de entre 1 y 100, donde 0 significa “no intercambiar para nada” y 100 significa “intercambiar lo más pronto posible”"
				echo ""
				echo "a.-Ver cantidad de swappiness asignado"
				echo ""
				echo "b.-Cambiar valor swappiness"
				echo ""
				echo "c.-Eliminar cambios y dejar valor por default"

					read opcion
					case $opcion in

						a) echo "Ver cantidad de swappiness asignado"

								cat /proc/sys/vm/swappiness;;

						b) echo "Ingresa un numero entre 1 y 100 para cambiar el valor swappiness"

								echo ""

								read valor

								echo $valor > /proc/sys/vm/swappiness

								echo "vm.swappiness = $valor" >> /etc/sysctl.conf

								cat /etc/sysctl.conf;;

						c) echo "Listo, el valor volvera por default en el proximo reinicio"

								sed -i 's/^.*swappiness.*$//gm' /etc/sysctl.conf;;

						*) echo "Valor no valido, ingresa el valor correspondiente";;

						esac;;

    6) echo "Hecho, hasta luego"; sleep 2

				sudo systemctl reboot;;

    7) echo "OK, Apagando"; sleep 2

				sudo systemctl poweroff;;

    *) echo "Valor no valido, ingresa el valor correspondiente";;

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
