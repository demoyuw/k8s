FROM java
workdir /
ADD apache-tomcat-7.0.82.tar.gz .
VOLUME ["/apache-tomcat-7.0.82/webapps"]
EXPOSE 8080
CMD ["/apache-tomcat-7.0.82/bin/catalina.sh", "run"]
