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

# modify /opt/etc/dnscrypt-proxy.toml to use the ss-local server
/opt/etc/init.d/S09dnscrypt-proxy2 start

echo "All service started."
