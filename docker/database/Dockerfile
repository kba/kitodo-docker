# Kitodo.Production

# Build Docker image:
# cp -a ../../../Goobi/setup .
# docker build -t database .

# Start MariaDB, create a database and fill it with default values.
# docker run --detach=true --name kitodo-database kitodo/database:latest

# Useful links:
# https://docs.docker.com/engine/reference/builder/
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/

FROM mariadb:latest

MAINTAINER Stefan Weil <stefan.weil@bib.uni-mannheim.de>

ENV MYSQL_ROOT_PASSWORD goobi
ENV MYSQL_DATABASE goobi
ENV MYSQL_USER goobi
ENV MYSQL_PASSWORD goobi

COPY kitodo-production/Goobi/setup /tmp/setup
COPY initdb.sh /docker-entrypoint-initdb.d/initdb.sh
