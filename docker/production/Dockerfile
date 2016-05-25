# Kitodo.Production

# Start MariaDB, create a database and fill it with default values.
# docker run --detach=true --name kitodo-database kitodo/database:latest

# Start Kitodo.Production.
# docker run -it --rm -p 8888:8080 --name kitodo-production --link kitodo-database:mysql kitodo/production

# Useful links:
# https://docs.docker.com/engine/reference/builder/
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
# https://hub.docker.com/_/tomcat/

# tomcat:7-jre7 fails because of unresolved symbols.
#FROM tomcat:7-jre7
FROM tomcat:8-jre8

MAINTAINER Stefan Weil <stefan.weil@bib.uni-mannheim.de>

# Run in /tmp
WORKDIR /tmp

# Add the build files
# Add the script files.
ADD kitodo-production/Goobi Goobi
ADD kitodo-production/build.xml build.xml
ADD kitodo-production/build.properties.template build.properties
ADD kitodo-production/Goobi/scripts /usr/local/goobi/scripts

# Install the JDK
RUN apt-get update && apt-get install -y ant openjdk-8-jdk-headless

# Setup build properties
# Build
# Unpack the Kitodo war file because we must patch the configuration later.
# Fix database URL in Kitodo configuration before starting Tomcat.
RUN sed -i \
        -e "s,#tomcat.dir.lib.*,tomcat.dir.lib=/usr/local/tomcat/lib," \
        -e "s,#tomcat.compile.jsp.*,tomcat.compile.jsp=false," \
        -e "\$a dist.war=/usr/local/tomcat/webapps/kitodo.war" \
        build.properties \
    && ant \
    && unzip /usr/local/tomcat/webapps/kitodo.war \
        -d /usr/local/tomcat/webapps/kitodo \
    && sed -i \
        "s/localhost/$MYSQL_PORT_3306_TCP_ADDR:$MYSQL_PORT_3306_TCP_PORT/" \
        /usr/local/tomcat/webapps/kitodo/WEB-INF/classes/hibernate.cfg.xml \
    && rm /usr/local/tomcat/webapps/kitodo.war

EXPOSE 8080

# CMD ["catalina.sh", "run"]
