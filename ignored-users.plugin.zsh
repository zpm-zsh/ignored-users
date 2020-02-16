if [[ -e /etc/passwd ]]; then
  cache_file="${TMPDIR:-/tmp}/zpm-zsh-ignored-users-cache.$UID.zsh"
  if [[ /etc/passwd -nt "$cache_file" || ! -s "$cache_file"  ]]; then
    ignored=( $(cat /etc/passwd | awk -F':' '($3<1000 && $3>0)||$3>10000{print $1}' | xargs) )
    zstyle ':completion:*:*:*:users' ignored-patterns $ignored
    echo "zstyle ':completion:*:*:*:users' ignored-patterns $ignored" >! "$cache_file" 2> /dev/null
  else
    source "$cache_file"
  fi
fi
