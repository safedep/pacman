mavenScriptSrc="$BASEDIR/data/maven-settings.xml"
mavenScriptDst="$HOME/$MAVEN_M2_SETTINGS_PATH"

function setupMaven() {
  gatewayURL=$1
  username=$2
  password=$3

  gatewayMavenCentralURL="$gatewayURL$MAVEN_CENTRAL_ROUTE"
  mkdir -p `dirname $mavenScriptDst` 2>/dev/null

  if [ -f "$mavenScriptDst" ]; then
    warn_msg "Overwriting $mavenScriptDst"
  else
    print_msg "Writing gateway config in $mavenScriptDst"
  fi;

  cat $mavenScriptSrc | \
    sed "s,{{GATEWAY_USERNAME}},$username," | \
    sed "s,{{GATEWAY_PASSWORD}},$password," | \
    sed "s,{{GATEWAY_MAVEN_CENTRAL_URL}},$gatewayMavenCentralURL," \
    > $mavenScriptDst
}

setupMaven $GATEWAY_URL $GATEWAY_USERNAME $GATEWAY_PASSWORD
