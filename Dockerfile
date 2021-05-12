FROM ubuntu:latest
#docker run -it --name kafka1 -v /mnt/c/data_science_tasks/docker_setup/kafka_setup:/mounted ubuntu bash
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV TZ="Asia/Kolkata"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y curl grep sed dpkg wget vim \
    iputils-ping vim inetutils-tools telnet net-tools \
	software-properties-common python3-pip \
    && rm -rf /var/lib/apt/lists/*
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1
COPY ./jdk-8u281-linux-x64.tar.gz /opt/
COPY ./kafka_2.13-2.8.0.tgz /opt/
RUN cd /opt/ && tar -xzf jdk-8u281-linux-x64.tar.gz && tar -xzf kafka_2.13-2.8.0.tgz
RUN echo "export JAVA_HOME=/opt/jdk1.8.0_281" >> ~/.bashrc && \
    echo "export JRE_HOME=${JAVA_HOME}/jre" >> ~/.bashrc && \
    echo "export PATH=${PATH}:${JAVA_HOME}/bin:${JRE_HOME}/bin" >> ~/.bashrc && \
    echo "export CLASSPATH=${CLASSPATH}:${JAVA_HOME}/lib:${JRE_HOME}/lib" >> ~/.bashrc && \
    echo "alias ll='ls -lart'" >> ~/.bashrc && \
    echo "export SHELL=/bin/bash" >> ~/.bashrc && \
    echo 'if [ -f ~/.custom_bashrc ]; then source ~/.custom_bashrc ; fi' >> ~/.bashrc
RUN pip install jupyterlab
COPY ./config /opt/kafka_2.13-2.8.0/
WORKDIR /opt/kafka_2.13-2.8.0/
#EXPOSE 2181 9092, 9000, 8080 and 8888
CMD [ "/bin/bash" ]
