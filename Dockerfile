FROM centos:7

#To install the kubectl command

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

#Executing the command

RUN chmod +x kubectl

#To access the command from anywhere, we need to add it in /usr/bin file:

RUN mv kubectl /usr/sbin


#Install java 

RUN yum install java -y

#To install openssh server so that the container could connect with the Jenkins as slave

RUN yum install openssh-server -y

#Creating the root directory for jenkins slave

RUN mkdir /root/jenkins

#Generating the ssh key in the container

RUN ssh-keygen -A

#We need to run the services of ssh

CMD [ "/usr/sbin/sshd", "-D" ] 

RUN mkdir /root/.kube
COPY config /root/.kube
COPY *.crt /root/
COPY client.key /root/
COPY web.yml /root/

#Install sudo command so that we do not have any conflict of permissions in Jenkins

RUN yum install sudo -y


CMD /bin/bash


