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

# Copy thư mục target từ stage build vào
COPY --from=build /app/target /app/target




# Mở cổng ứng dụng, Spring Boot WAR mặc định chạy trên cổng 8080
EXPOSE 8080

# Chạy ứng dụng Java với file WAR tên ROOT.war
ENTRYPOINT ["java", "-jar", "/app/target/teashop-0.0.1-SNAPSHOT.war"]

# docker build -t project-javaspring:0.0.1 .

# docker run --name project-java --network teashop-network -p 8080:8080 -e DB_URL=jdbc:mysql://mysql:3306/teashop project-javaspring:0.0.1