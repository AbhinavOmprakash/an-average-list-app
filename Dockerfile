FROM openjdk:8-alpine

COPY target/uberjar/an_average_list_app.jar /an_average_list_app/app.jar

EXPOSE 3000

CMD ["java", "-jar", "/an_average_list_app/app.jar"]
