# Pull base image
From tomcat:8-jre8

# Maintainer
MAINTAINER "markymark08@gmail.com"

# copy war file on to container
COPY ./petclinic.war /usr/local/tomcat/webapps