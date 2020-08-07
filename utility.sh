#!/bin/bash

read_var() {
  if [ -z "$1" ]; then
    echo "environment variable name is required"
    return
  fi

  local ENV_FILE='.env'
  if [ ! -z "$2" ]; then
    ENV_FILE="$2"
  fi

  local VAR=$(grep ^$1= "$ENV_FILE" | xargs)
  IFS="=" read -ra VAR <<< "$VAR"
  echo ${VAR[1]}
}

phashReplace=$(read_var phashReplace)
publicKeyReplace=$(read_var publicKeyReplace)
sysLogIp=$(read_var sysLogIp)
allowManagementIp=$(read_var allowManagementIp)
denyManagementIp=$(read_var denyManagementIp)

sed -i "s/phashReplace/${phashReplace}/" palo_alto_config
sed -i "s/publicKeyReplace/${publicKeyReplace}/" palo_alto_config
sed -i "s/sysLogIp/${sysLogIp}/" palo_alto_config
sed -i "s+allowManagementIp+${allowManagementIp}+" palo_alto_config
sed -i "s/denyManagementIp/${denyManagementIp}/" palo_alto_config