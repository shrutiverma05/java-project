# Use official Tomcat base image
FROM tomcat:9.0

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file into Tomcat's webapps directory
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (default Tomcat port)
EXPOSE 8000

# Start Tomcat
CMD ["catalina.sh", "run"]

