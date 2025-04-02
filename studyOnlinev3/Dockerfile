FROM openjdk:19-alpine
LABEL authors="Qi"
# 创建应用目录
RUN mkdir -p /app && mkdir -p /app/config
# 进入工作目录
WORKDIR /app
# 复制jar
COPY target/studyOnlinev3-0.0.1-SNAPSHOT.jar .
# EXPOSE 映射端口
EXPOSE 9099
# CMD 运行以下命令(如果yaml文件定义了command会被覆盖)
CMD ["/bin/sh","-c","set -e && java -jar studyOnlinev3-0.0.1-SNAPSHOT.jar --server.port=9099 --server.port=9099 --spring.profiles.active=prod"]
