FROM tomcat:9.0

COPY target/fastfood-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/fastfood.war
