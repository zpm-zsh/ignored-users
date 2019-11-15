if [[ -e /etc/passwd ]]; then
  zstyle ':completion:*:*:*:users' ignored-patterns $(cat /etc/passwd | awk -F':' '($3<1000 && $3>0)||$3>10000{print $1}' | xargs)
fi
