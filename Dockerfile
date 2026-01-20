FROM maven AS buildstage 
RUN mkdir /opt/project
WORKDIR /opt/project
COPY . .
RUN mvn clean install 


FROM tomcat 
WORKDIR webapps
COPY --from=buildstage /opt/project/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
