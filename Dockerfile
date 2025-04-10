FROM alpine AS git
RUN apk update && apk add git
WORKDIR /app
RUN git clone https://github.com/OpqTech/java-onlinebookstore.git

FROM maven:amazoncorretto AS build
COPY --from=git /app/* /usr/app/
RUN mvn clean -f /usr/app/pom.xml install

FROM mlkrtk/tomcat-final
COPY --from=build /usr/app/target/*.war /usr/local/tomcat/webapps/
