# Haskell stack install path
set -xg PATH $HOME/.local/bin $PATH

# SSL certificate file
set -xg SSL_CERT_FILE $NIX_SSL_CERT_FILE

# emacs alias
function emacs
  eval "$HOME/.nix-profile/Applications/Emacs.app/Contents/MacOS/Emacs $argv &"
end

# start CNTLM
function cntlmon
  set cntlm_config "$HOME/.etc/cntlm.conf"
  if pgrep cntlm > /dev/null
    echo 'cntlm is already running: pid '(pgrep cntlm)
  else
    cntlm -c $cntlm_config
    echo 'started cntlm: pid '(pgrep cntlm)
  end
  setproxy
  wifioff
end

# stop CNTLM
function cntlmoff
  if pgrep cntlm > /dev/null
    echo "killing cntlm: pid "(pgrep cntlm)
    kill -9 (pgrep cntlm)
  else
    echo 'cntlm was not running'
  end
  unsetproxy
end

# set proxy environment variables
function setproxy
  set -xg HTTP_PROXY 'http://127.0.0.1:3128'
  set -xg http_proxy $HTTP_PROXY
  set -xg HTTPS_PROXY $HTTP_PROXY
  set -xg https_prosy $HTTP_PROXY
end

# unset proxy environment variables
function unsetproxy
  set -e HTTP_PROXY
  set -e http_proxy
  set -e HTTPS_PROXY
  set -e https_proxy
end

# turn off McAfee
function mcaoff
  sudo /usr/local/McAfee/StatefulFirewall/bin/StatefullFirewallControl stop
end

# turn on McAfee
function mcaon
  sudo /usr/local/McAfee/StatefulFirewall/bin/StatefullFirewallControl start
end

# turn on wifi
function wifion
  unsetproxy
  networksetup -setairportpower en0 on
end

# turn off wifi
function wifioff
  setproxy
  networksetup -setairportpower en0 off
end
