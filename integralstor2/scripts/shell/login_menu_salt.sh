#!/bin/bash

pause(){
  read -p "Press [Enter] key to continue..." key
}
 
configure_network_interface(){
  #echo "configure networking called"
  python3 /opt/integralstor/integralstor2/scripts/python/configure_networking.py interface
}


view_node_status(){
  python3 /opt/integralstor/integralstor2/scripts/python/display_node_status.py
  pause
}
view_node_config(){
  python3 /opt/integralstor/integralstor2/scripts/python/display_node_config.py
  pause
}


remove_minions(){
  python3 /opt/integralstor/integralstor2/scripts/python/clear_minions.py
  pause
}

goto_shell() {
  su -l fractalio
  pause
}

do_reboot() {
  reboot now
  pause
}


do_shutdown() {
  shutdown -h now
  pause
}

show_menu() {
  clear
  echo "-------------------------------"	
  echo " IntegralStore Unicell - Menu"
  echo "-------------------------------"
  echo "1. Configure a network interface"
  echo "2. Reboot"
  echo "3. Shutdown"
  echo "4. View configuration"
  echo "5. View process status"
  echo "6. Exit menu"
}

read_input(){
  local input 
  read -p "Enter choice [1 - 6] " input
  case $input in
    1) configure_network_interface ;;
    2) do_reboot;;
    3) do_shutdown;;
    4) view_node_config;;
    5) view_node_status;;
    6) exit 0;;
    *)  echo "Not a Valid INPUT" && sleep 2
  esac
}
 
trap '' SIGINT SIGQUIT SIGTSTP
 
while true
do
  echo "The integralstor console menu has started" > /tmp/out
  show_menu
  read_input
  echo "The integralstor console menu has stopped" >> /tmp/out
done
