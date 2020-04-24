if [[ -e /etc/passwd ]]; then
  CACHE_FILE="${TMPDIR:-/tmp}/zsh-${UID}/ignored-users.zsh"
  if [[ -f "$CACHE_FILE" ]]; then
    source "$CACHE_FILE"
  else
    ignored=( $(cat /etc/passwd | awk -F':' '($3<1000 && $3>0)||$3>10000{print $1}' | xargs) )
    zstyle ':completion:*:*:*:users' ignored-patterns $ignored
    echo "zstyle ':completion:*:*:*:users' ignored-patterns $ignored" >! "$CACHE_FILE" 2> /dev/null
    zcompile "$CACHE_FILE"
  fi
fi
