#!/bin/sh

# Kill all services
killall ss-redir 2>/dev/null
killall ss-local 2>/dev/null
killall v2ray-plugin 2>/dev/null
/opt/etc/init.d/S02haveged kill
/opt/etc/init.d/S09dnscrypt-proxy2 kill

echo "All service stopped."
