#!/bin/sh

# Improve tomcat startup performance, http://openjdk.java.net/jeps/123
java_security=$(find /usr/lib/jvm | grep jre | grep java.security$)
if grep -q securerandom.source=file:/dev/random ${java_security}; then
    sed -i -e "s/securerandom.source=file:\/dev\/random/securerandom.source=file:\/dev\/\\.\/urandom/" ${java_security}
elif grep -q securerandom.source=file:/dev/urandom ${java_security}; then
    sed -i -e "s/securerandom.source=file:\/dev\/urandom/securerandom.source=file:\/dev\/\\.\/urandom/"  ${java_security}
fi

mkdir -p ${DCTM_REST_HOME}
if [ ! -f ${DCTM_REST_HOME}/WEB-INF/classes/dfc.properties ]; then
    unzip ${REST_WAR_TMP}/dctm-rest.war -d ${CATALINA_HOME}/webapps/dctm-rest
fi
cp ${REST_CONFIG_REST_TMP}/* ${DCTM_REST_HOME}/WEB-INF/classes/
cp ${REST_CONFIG_DFC_TMP}/dfc.properties ${DCTM_REST_HOME}/WEB-INF/classes/

# Add Tomcat SSL configuration in server.xml
if [ -n "${COMM_KEYSTORE_FILE}" ] && [ -n "${COMM_KEYSTORE_PWD}" ]; then
    echo "Setting Tomcat SSL/TLS connector: key store file and password..."
    sed -i '/<!--$/{N;/Connector port=\"8443\"/{N;N;N;s|\(.*<!--\n\)\(.*\)\(\/>\n.*-->\)|\1\2 keystoreFile="'"$COMM_KEYSTORE_FILE"'" keystorePass="'"$COMM_KEYSTORE_PWD"'"\3|}}' ${CATALINA_HOME}/conf/server.xml
else
    echo "Communication keystore file or password is not specified..."
fi

if [ -n "${COMM_KEY_ALIAS}" ] && [ -n "${COMM_KEY_PWD}" ]; then
    echo "Setting Tomcat SSL/TLS connector: key alias and password..."
    sed -i '/<!--$/{N;/Connector port=\"8443\"/{N;N;N;s|\(.*<!--\n\)\(.*\)\(\/>\n.*-->\)|\1\2 keyAlias="'"$COMM_KEY_ALIAS"'" keyPass="'"$COMM_KEY_PWD"'" \3|}}' ${CATALINA_HOME}/conf/server.xml
else
    echo "Communication key alias or password is not specified..."
fi

if [ -n "${COMM_KEY_STORE_TYPE}" ]; then
    echo "Setting Tomcat SSL/TLS connector: keystore type..."
    sed -i '/<!--$/{N;/Connector port=\"8443\"/{N;N;N;s|\(.*<!--\n\)\(.*\)\(\/>\n.*-->\)|\1\2 keystoreType="'"$COMM_KEY_STORE_TYPE"'" \3|}}' ${CATALINA_HOME}/conf/server.xml
else
    echo "Communication keystore type is not specified..."
fi

# Uncomment the Tomcat SSL configuration to make it effect
if [ -n "${COMM_KEYSTORE_FILE}" ] || [ -n "${COMM_KEYSTORE_PWD}" ] || [ -n "${COMM_KEY_ALIAS}" ] || [ -n "${COMM_KEY_PWD}" ] || [ -n "${COMM_KEY_STORE_TYPE}" ]; then
    echo "Enable Tomcat SSL/TLS configuration..."
    sed -i '/<!--$/{N;/Connector port=\"8443\"/{N;N;N;s|.*<!--\n\(.*\/>\)\n.*-->|\1|}}' ${CATALINA_HOME}/conf/server.xml
else
    echo "Tomcat SSL/TLS configuration is not enabled..."
fi

${CATALINA_HOME}/bin/catalina.sh run
