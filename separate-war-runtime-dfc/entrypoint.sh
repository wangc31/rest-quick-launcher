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
cp ${REST_CONFIG_REST_TMP}/*.properties ${DCTM_REST_HOME}/WEB-INF/classes/
cp ${REST_CONFIG_DFC_TMP}/dfc.properties ${DCTM_REST_HOME}/WEB-INF/classes/
${CATALINA_HOME}/bin/catalina.sh run
