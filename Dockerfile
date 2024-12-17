# Stage 1: Build with Maven
FROM maven:3.9.8 AS build

WORKDIR /app

# Copy chỉ file pom.xml để tận dụng cache Docker
COPY pom.xml ./

# Tải các dependency mà không cần phải build (giúp cache khi không thay đổi pom.xml)
RUN mvn dependency:go-offline

# Sau đó copy mã nguồn
COPY src ./src

# Build ứng dụng và tạo file WAR (bỏ qua việc chạy tests)
RUN mvn clean package -DskipTests

# Stage 2: Tạo image cuối cùng với JDK
FROM amazoncorretto:17.0.13

WORKDIR /app
COPY pom.xml .
COPY src src 


RUN mvn package -Dskiptest
