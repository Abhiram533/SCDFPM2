FROM node:latest
# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN npm install pm2 -g
ADD spring-cloud-dataflow-server-2.7.0.jar  spring-cloud-dataflow-server-2.7.0.jar
ADD spring-cloud-skipper-server-2.6.0.jar  spring-cloud-skipper-server-2.6.0.jar
ADD process.json process.json
CMD ["pm2-runtime","process.json"]




