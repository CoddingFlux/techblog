# Use the official Tomcat 11 base image with JDK 21
FROM tomcat:11.0.2-jdk21

# Set environment variables
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

# Copy the WAR file into the Tomcat webapps directory
COPY target/techblog.war $CATALINA_HOME/webapps/

# Expose Tomcat's default port
EXPOSE 8080

# Wait for PostgreSQL to be ready before starting Tomcat
CMD ["sh", "-c", "sleep 10 && catalina.sh run"]
