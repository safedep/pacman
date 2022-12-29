pipScriptDst="$HOME/$PIP_CONFIG_PATH"

function setupPip() {
  gatewayURL=$1
  username=$2
  password=$3

  finalURL=$(ruby -ruri -rcgi -e "u = ::URI.parse(\"$gatewayURL\");u.user = ::CGI.escape(\"$username\");u.password = ::CGI.escape(\"$password\");print u.to_s")

  if [ -f "$pipScriptDst" ]; then
    warn_msg "Overwriting $pipScriptDst"
  else
    print_msg "Writing gateway config in $pipScriptDst"
  fi;

  pypiPath=${GATEWAY_PYPI_PATH:-/pypi}

  mkdir -p `dirname $pipScriptDst`
  cat > $pipScriptDst <<_EOF
[global]
index = $finalURL$pypiPath
index-url = $finalURL$pypiPath/simple
_EOF
}

setupPip $GATEWAY_URL $GATEWAY_USERNAME $GATEWAY_PASSWORD
