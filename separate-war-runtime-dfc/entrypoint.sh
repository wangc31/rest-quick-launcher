#!/bin/sh
mkdir -p ${DCTM_REST_HOME}
if [ ! -f ${DCTM_REST_HOME}/WEB-INF/classes/dfc.properties ]; then
    unzip ${REST_WAR_TMP}/dctm-rest.war -d ${CATALINA_HOME}/webapps/dctm-rest
fi
cp ${REST_CONFIG_REST_TMP}/*.properties ${DCTM_REST_HOME}/WEB-INF/classes/
cp ${REST_CONFIG_DFC_TMP}/*.properties ${DCTM_REST_HOME}/WEB-INF/classes/
${CATALINA_HOME}/bin/catalina.sh run