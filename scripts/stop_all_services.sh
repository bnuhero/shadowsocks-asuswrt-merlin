#!/bin/sh

# Kill all services
killall ss-redir 2>/dev/null
killall ss-local 2>/dev/null
killall v2ray-plugin 2>/dev/null
/opt/etc/init.d/S02haveged stop
/opt/etc/init.d/S09dnscrypt-proxy2 stop

echo "All service stopped."
