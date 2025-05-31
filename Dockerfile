FROM gradle:8.5-jdk21 AS build

WORKDIR /home/gradle/src

# COPY BUILD FILES
COPY build.gradle settings.gradle ./

# COPY SOURCE CODE
COPY --chown=gradle:gradle . .

RUN gradle build --no-daemon --info --scan -x test

FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Copiamos el .jar
COPY --from=build /home/gradle/src/build/libs/greeting-0.0.1-SNAPSHOT.jar /app/greeting.jar


EXPOSE 8891


ENTRYPOINT ["java", "-jar", "/app/greeting.jar"]
