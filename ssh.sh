#!/bin/bash
# add line in /etc/pam.d/sshd
# auth [default=ignore]   pam_exec.so /opt/EZ-Server-Alerting/ssh.sh
# default ignore otherwise we need to set an exit code in this script
# make sure /root/.config/ntfy/ntfy.yml is setup properly

if [ "$PAM_TYPE" != "close_session" ]; then
  host="`hostname`"
  message=":unlock: SSH Login: $PAM_USER from $PAM_RHOST on $host"

ntfy send "$(
echo $message
  echo "User: $PAM_USER"
  echo "Remote Host: $PAM_RHOST"
  echo "Service: $PAM_SERVICE"
  echo "TTY: $PAM_TTY"
  echo "Date: `date`"
  echo "Server: `curl -s ifconfig.co --connect-timeout 1`"
)"
fi
