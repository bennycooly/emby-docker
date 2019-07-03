#!/bin/bash

USERNAME=embyrunner
EMBY_UID="${EMBY_UID:-1000}"
EMBY_GID="${EMBY_GID:-1000}"
GIDLIST="${GIDLIST:-1000,44}"
EMBY_DATA="${EMBY_DATA:-/config}"

COMMAND="EMBY_DATA=${EMBY_DATA} /opt/emby-server/bin/emby-server"

# Set permissions
chown -R ${EMBY_UID}:${EMBY_GID} ${EMBY_DATA}
chmod 666 /dev/dri/renderD128
# chown -R ${EMBY_UID}:${EMBY_GID} /opt/emby-server
# chown ${EMBY_UID}:${EMBY_GID} /usr/share/libdrm/amdgpu.ids

groupadd -r -g ${EMBY_GID} ${USERNAME}
useradd -r -u ${EMBY_UID} -g ${EMBY_GID} -s /usr/bin/nologin ${USERNAME}
usermod -aG ${GIDLIST} ${USERNAME} 

su -s /bin/bash -c "${COMMAND}" -g ${USERNAME} ${USERNAME}

