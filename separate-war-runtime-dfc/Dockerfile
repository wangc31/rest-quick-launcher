FROM tomcat:8.0-jre8-alpine

MAINTAINER Chen Wang <chen.wang@emc.com>

ENV REST_WAR_TMP /tmp/war
ENV REST_CONFIG_REST_TMP /tmp/rest/config
ENV REST_CONFIG_DFC_TMP /tmp/dfc/config
ENV DCTM_REST_HOME ${CATALINA_HOME}/webapps/dctm-rest

# Copy the script in work dir
COPY entrypoint.sh ./
RUN chmod a+x ./entrypoint.sh

#expose the ports
EXPOSE 8080 8443 8009

# Launch Tomcat
ENTRYPOINT ["./entrypoint.sh"]
