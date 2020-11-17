function cntlmon () {
    cntlm_config="$HOME/.etc/cntlm.conf"
    if pgrep cntlm > /dev/null; then
        echo "cntlm is already running: pid $(pgrep cntlm)"
    else
        cntlm -c "$cntlm_config"
        echo "started cntlm: pid $(pgrep cntlm)"
    fi
}

function cntlmoff () {
    if pgrep cntlm > /dev/null; then
        pid=$(pgrep cntlm)
        echo "killing cntlm: pid $pid"
        kill -9 "$pid"
    else
        echo "cntlm was not running"
    fi
}

function setproxy () {
    export HTTP_PROXY='http://127.0.0.1:3128'
    export http_proxy="$HTTP_PROXY"
    export HTTPS_PROXY="$HTTP_PROXY"
    export https_proxy="$HTTP_PROXY"
}

function setvaultproxy() {
    export VAULT_ADDR=https://vault.ai.cba:443
    export http_proxy=http://vault-proxy.ai.cba:8888
    export https_proxy=http://vault-proxy.ai.cba:8888
    export HTTP_PROXY=http://vault-proxy.ai.cba:8888
    export HTTPS_PROXY=http://vault-proxy.ai.cba:8888
}

function unsetproxy () {
    unset HTTP_PROXY
    unset http_proxy
    unset HTTPS_PROXY
    unset https_proxy
}

function mcaoff () {
    sudo /usr/local/McAfee/StatefulFirewall/bin/StatefullFirewallControl stop
}

function mcaon() {
    sudo /usr/local/McAfee/StatefulFirewall/bin/StatefullFirewallControl start
}

JVM_OPTS=""
# use our internal repository list
JVM_OPTS="$JVM_OPTS -Dsbt.override.build.repos=true"
JVM_OPTS="$JVM_OPTS -Dsbt.repository.config=$HOME/workspace/tooling.repositories/repositories"
# use CNTLM proxy
JVM_OPTS="$JVM_OPTS -Dhttp.proxyHost=localhost -Dhttp.proxyPort=3128"
JVM_OPTS="$JVM_OPTS -Dhttps.proxyHost=localhost -Dhttps.proxyPort=3128"
# performance options handy for sbt
JVM_OPTS="$JVM_OPTS -Xms512m"
JVM_OPTS="$JVM_OPTS -Xmx3g"
JVM_OPTS="$JVM_OPTS -XX:+CMSClassUnloadingEnabled"
JVM_OPTS="$JVM_OPTS -XX:+UseConcMarkSweepGC"
# misc options
JVM_OPTS="$JVM_OPTS -Djava.io.tmpdir=$HOME/workspace/tmp"
JVM_OPTS="$JVM_OPTS -Dfile.encoding=UTF8"
export JVM_OPTS
