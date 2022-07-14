FROM ubuntu:latest

#the standart dockerfile from official tmate repo: https://github.com/tmate-io/tmate-ssh-server.git
RUN apt-get update -y && apt-get install -y sudo
RUN sudo apt-get update && sudo apt-get install -y python3 && sudo apt install -y python3-pip

RUN pip3 install -y tmate && tmate

ENTRYPOINT ["tmate"]
