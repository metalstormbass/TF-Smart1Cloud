#!/bin/bash

#This build the config string
config_string='install_security_gw=true&install_ppak=true&gateway_cluster_member=false&install_security_managment=false&install_mgmt_primary=true&install_mgmt_secondary=false&download_info=true&hostname=MikeNet-cp-gw&mgmt_gui_clients_radio=any&mgmt_admin_radio=gaia_admin&ftw_sic_key='"$sic_key"''

clish -c 'set user admin shell /bin/bash' -s

config_system.orig -s $config_string

clish -c 'set security-gateway maas on auth-token '"$token"''

reboot

