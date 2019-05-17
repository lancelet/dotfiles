# Theme setup
set -g theme_nerd_fonts yes
set -g theme_color_scheme terminal

# Haskell stack install path
set -xg PATH $HOME/.local/bin $PATH

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

# vault stuff
function setvaultproxy
  work-secrets   # Bring VAULT_ADDR and VAULT_PROXY secrets into scope
  set -xg HTTP_PROXY $VAULT_PROXY
  set -xg http_proxy $VAULT_PROXY
  set -xg HTTPS_PROXY $VAULT_PROXY
  set -xg https_proxy $VAULT_PROXY
end
function vaultlogin
  vault login -method=ldap username=merrijo
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

# SBT using Omnia settings
function osbt
  set JVM_TMP_DIR "$HOME/workspace/tmp"
  if not test -d "$JVM_TMP_DIR"
    mkdir -p "$JVM_TMP_DIR"
  end
  set TR_REPO "$HOME/workspace/tooling.repositories"
  if not test -d "$TR_REPO"
    pushd "$HOME/workspace"
    git clone https://github.source.internal.cba/AnalyticsInformation/tooling.repositories.git tooling.repositories
    popd
  end
  set STANDARD_JVM_OPTS "-J-Djava.io.tmpdir=$HOME/workspace/tmp -J-Dfile.encoding=UTF8 -J-XX:MaxPermSize=2G -J-Xms512m -J-Xmx3g -J-XX:+CMSClassUnloadingEnabled -J-XX:+UseConcMarkSweepGC"
  set JVM_OPTS "-J-Dsbt.override.build.repos=true -J-Dsbt.repository.config=$TR_REPO/repositories $STANDARD_JVM_OPTS"
  eval "env SBT_OPTS='' sbt $JVM_OPTS $argv"
end

# SBT using ZBI settings
function zsbt
  set JVM_TMP_DIR "$HOME/workspace/tmp"
  if not test -d "$JVM_TMP_DIR"
    mkdir -p "$JVM_TMP_DIR"
  end
  set ZBI_REPO "$HOME/workspace/zbi-repo-settings"
  if not test -d "$ZBI_REPO"
    pushd "$HOME/workspace"
    git clone https://github.ai.cba/ZBI/repo-settings zbi-repo-settings
    popd
  end
  set STANDARD_JVM_OPTS "-J-Djava.io.tmpdir=$HOME/workspace/tmp -J-Dfile.encoding=UTF8 -J-XX:MaxPermSize=2G -J-Xms512m -J-Xmx3g -J-XX:+CMSClassUnloadingEnabled -J-XX:+UseConcMarkSweepGC"
  set JVM_OPTS "-J-Dsbt.override.build.repos=true -J-Dsbt.repository.config=$ZBI_REPO/sbt/repositories $STANDARD_JVM_OPTS"
  eval "env SBT_OPTS='' sbt $JVM_OPTS $argv"
end
