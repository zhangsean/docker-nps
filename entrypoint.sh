#!/bin/sh
[ -z $NPS_MODE ] && NPS_MODE=client
if [ $NPS_MODE == 'server' -o $NPS_MODE == 'all' ]; then
  sed -i '/runmode/s/dev/pro/g' conf/nps.conf
  sed -i "/public_vkey/s|123|$NPS_PUBLIC_VKEY|g" conf/nps.conf
  [ $NPS_BRIDGE_TYPE ] && sed -i "/bridge_type/s|tcp|$NPS_BRIDGE_TYPE|g" conf/nps.conf
  [ $NPS_BRIDGE_PORT ] && sed -i "/bridge_port/s|8024|$NPS_BRIDGE_PORT|g" conf/nps.conf
  [ $NPS_HTTP_PROXY_PORT ] && sed -i "/http_proxy_port/s|80|$NPS_HTTP_PROXY_PORT|g" conf/nps.conf
  [ $NPS_HTTPS_PROXY_PORT ] && sed -i "/https_proxy_port/s|443|$NPS_HTTPS_PROXY_PORT|g" conf/nps.conf
  [ $NPS_WEB_USERNAME ] && sed -i "/web_username/s|admin|$NPS_WEB_USERNAME|g" conf/nps.conf
  [ $NPS_WEB_PASSWORD ] && sed -i "/web_password/s|123|$NPS_WEB_PASSWORD|g" conf/nps.conf
  [ $NPS_WEB_PORT ] && sed -i "/web_port/s|8080|$NPS_WEB_PORT|g" conf/nps.conf
  [ $NPS_HTTP_CACHE ] && sed -i "/http_cache/s|false|$NPS_HTTP_CACHE|g" conf/nps.conf
  /nps/nps > nps.log &
fi
if [ $NPS_MODE == 'client' -o $NPS_MODE == 'all' ]; then
  head -n `grep -n '^$' conf/npc.conf | head -n1 | awk -F: '{print $1}'` conf/npc.conf | grep -v username | grep -v password > conf/npc.conf.tmp
  mv conf/npc.conf.tmp conf/npc.conf
  [ $NPC_SERVER_ADDR ] && sed -i "/server_addr/s|127.0.0.1:8024|$NPC_SERVER_ADDR|g" conf/npc.conf
  [ $NPC_CONN_TYPE ] && sed -i "/conn_type/s|tcp|$NPC_CONN_TYPE|g" conf/npc.conf
  [ $NPC_VKEY ] && sed -i "/vkey/s|123|$NPC_VKEY|g" conf/npc.conf
  /nps/npc > nps.log &
fi
tail -f nps.log