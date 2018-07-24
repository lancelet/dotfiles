# Theme setup
set -g theme_nerd_fonts yes
set -g theme_color_scheme solarized

# Haskell stack install path
set -xg PATH $HOME/.local/bin $PATH

# Rust tools path
set -xg PATH $HOME/.cargo/bin $PATH
set -xg RUST_SRC_PATH $HOME/workspace/rust/src

# SSL certificate file
set -xg SSL_CERT_FILE $NIX_SSL_CERT_FILE

# emacs alias
function emacs
  eval "$HOME/.nix-profile/Applications/Emacs.app/Contents/MacOS/Emacs $argv &"
end

# new emacs setup alias
function newmacs
  eval "$HOME/.nix-profile/Applications/Emacs.app/Contents/MacOS/Emacs -Q -l $HOME/workspace/dotfiles/newmacs/init.el $argv &"
end

# nix-shell, but with fish
alias nix-fish='nix-shell --command fish'

# Haskell tools
function haskell-tools
  stack install apply-refact hlint stylish-haskell hasktags hoogle intero fast-tags ghcid
end

# brings work secrets into scope as environment variables
function work-secrets
  eval "ansible-vault view $HOME/.secrets/work.fish.encrypted | source -"
end

# install the CBA root certificate
function install-cba-root-cert
  if not set -q NIX_SSL_CERT_FILE
    echo 'NIX_SSL_CERT_FILE is not set!' 
    exit -1
  end
  sudo bash -c "/usr/bin/security find-certificate -c CBAInternalRootCA -p >> $NIX_SSL_CERT_FILE"
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
end

# stop CNTLM
function cntlmoff
  if pgrep cntlm > /dev/null
    echo "killing cntlm: pid "(pgrep cntlm)
    kill -9 (pgrep cntlm)
  else
    echo 'cntlm was not running'
  end
end

# set proxy environment variables
function setproxy
  set -xg HTTP_PROXY 'http://127.0.0.1:3128'
  set -xg http_proxy $HTTP_PROXY
  set -xg HTTPS_PROXY $HTTP_PROXY
  set -xg https_proxy $HTTP_PROXY
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
  networksetup -setairportpower en0 on
end

# turn off wifi
function wifioff
  networksetup -setairportpower en0 off
end

###########
# sbt stuff

# Java home location
if [ (hostname) = 'C02MC13TFD58' ]
    set -xg JAVA_HOME '/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home'
end

# SBT using global repository settings
function gsbt
  set GCMD_OPTS '-J-Xmx4g -J-XX:+CMSClassUnloadingEnabled -J-XX:+UseConcMarkSweepGC -J-Xss2M'
  set GSBT_OPTS ''
  set GJAVA_OPTS ''
  eval "env JAVA_OPTS='$GJAVA_OPTS' SBT_OPTS='$GSBT_OPTS' sbt $GCMD_OPTS $argv"
end

# SBT using global repository settings and proxy
function gsbt-proxy
  set GCMD_OPTS '-J-Xmx4g -J-XX:+CMSClassUnloadingEnabled -J-XX:+UseConcMarkSweepGC -J-Xss2M'
  set PROXY_OPTS '-J-Dhttp.proxyHost=127.0.0.1 -J-Dhttp.proxyPort=3128 -J-Dhttps.proxyHost=127.0.0.1 -J-Dhttps.proxyPort=3128'
  set GSBT_OPTS ''
  set GJAVA_OPTS ''
  eval "env JAVA_OPTS='$GJAVA_OPTS' SBT_OPTS='$GSBT_OPTS' sbt $GCMD_OPTS $PROXY_OPTS $argv"
end

