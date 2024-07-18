FROM openjdk:17-jdk-alpine
EXPOSE 8080
ADD target/elastic-beanstalk-deployment-0.0.1-SNAPSHOT.jar demo.jar
ENTRYPOINT ["java","-jar","/demo.jar"]