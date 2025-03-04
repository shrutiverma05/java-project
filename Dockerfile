# Use official Tomcat base image
FROM tomcat:9.0

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Add the built WAR file to webapps
COPY target/*.jar /usr/local/tomcat/webapps/ROOT.jar

# Expose port
EXPOSE 8000

# Start Tomcat
CMD ["catalina.sh", "run"]

