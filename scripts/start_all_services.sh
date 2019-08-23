#!/bin/sh

SS_MERLIN_HOME=/opt/share/ss-merlin

ss_pid=$(pidof ss-redir)
if [[ -z "$ss_pid" ]]; then
  if [[ ! -f ${SS_MERLIN_HOME}/etc/shadowsocks/config.json ]]; then
    cp ${SS_MERLIN_HOME}/etc/shadowsocks/config.sample.json ${SS_MERLIN_HOME}/etc/shadowsocks/config.json
  fi
  ss-redir -c ${SS_MERLIN_HOME}/etc/shadowsocks/config.json -f /opt/var/run/ss-redir.pid
fi

local_pid=$(pidof ss-local)
if [[ -z "$local_pid" ]]; then
  if [[ ! -f ${SS_MERLIN_HOME}/etc/shadowsocks/local.json ]]; then
    cp ${SS_MERLIN_HOME}/etc/shadowsocks/local.sample.json ${SS_MERLIN_HOME}/etc/shadowsocks/local.json
  fi
  ss-local -c ${SS_MERLIN_HOME}/etc/shadowsocks/local.json -f /opt/var/run/ss-local.pid
fi

dot_pid=$(pidof https_dns_proxy)
if [[ -z "$dot_pid" ]]; then
  https_dns_proxy -a 127.0.0.1 -p 15253 -d -b 8.8.8.8,1.1.1.1,8.8.4.4,1.0.0.1 -t socks5://127.0.0.1:9050  
fi

echo "All service started."
