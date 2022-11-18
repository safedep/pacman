configurationPath="$HOME/.safedep/pacman.env"

function loadConfigurationIfPresent() {
  if [ -f "$configurationPath" ]; then
    print_msg "Loading config from $configurationPath"
    source $configurationPath
  fi;
}

function configureFromEnv() {
  print_msg "Configuring from environment"

  if [ -z "$GATEWAY_URL" ] || [ -z "$GATEWAY_USERNAME" ] || [ -z "$GATEWAY_PASSWORD" ]; then
    warn_msg "Required environment variables are not present"
  fi

  mkdir -p `dirname $configurationPath` 2>/dev/null
  cat > $configurationPath <<_EOF
GATEWAY_URL=$GATEWAY_URL
GATEWAY_USERNAME=$GATEWAY_USERNAME
GATEWAY_PASSWORD=$GATEWAY_PASSWORD
_EOF

}

function interactiveConfiguration() {
  print_msg "Running interactive configuration"
  echo -n "Gateway Base URL (without trailing /): "
  read -r gatewayURL
  echo -n "Username: "
  read -r username
  echo -n "Password: "
  read -r password

  mkdir -p `dirname $configurationPath` 2>/dev/null
  cat > $configurationPath <<_EOF
GATEWAY_URL=$gatewayURL
GATEWAY_USERNAME=$username
GATEWAY_PASSWORD=$password
_EOF
}
