FROM centos:7
MAINTAINER Satoshi <xxxx@gmail.com>

#ARG temp=${temp:-2}

#RUN echo ${temp}
#RUN if test ${temp} -ne 2; then echo succeed; fi

RUN echo 'リポジトリ更新'
RUN yum -y update
RUN echo '必要なものをインストール'
RUN yum install -y passwd openssh-server openssh-clients initscripts
RUN echo '空パスワードでログインできるようにする'
RUN sed -ri 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN passwd -d root

RUN echo 'ポート開放'
EXPOSE 22
RUN echo '実行時にサービス起動'
CMD /usr/sbin/sshd -D