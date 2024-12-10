FROM maven:latest-amazoncorretto-17 AS build


WORKDIR /app
COPY pom.xml .
COPY src src 


RUN mvn package -Dskiptest
