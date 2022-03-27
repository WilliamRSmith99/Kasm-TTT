
FROM kasmweb/core-ubuntu-bionic:1.10.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


RUN apt-get update && apt-get upgrade -y

## Installing Python3-pygame ##
RUN  apt install python-pip -y \
     && pip install pygame

## Cloning Github Repo ##
RUN git clone https://github.com/WilliamRSmith99/Tic-Tac-Toe-project.git \
    && cd Tic-Tac-Toe-project \
    && chmod u+x Launch_Game.sh \
    && chmod u+x Tic-Tac-Toe.py \
    && chown 1000:1000 Tic-Tac-Toe.py \
    && cd ~ \
    && cp -r Tic-Tac-Toe-project $HOME/Desktop 

## Creating Desktop Shortcut
RUN  cp -r Tic-Tac-Toe-project/TTT.desktop $HOME/Desktop

RUN echo "/usr/bin/desktop_ready && $HOME/Desktop/Tic-Tac-Toe-project/Launch_Game.sh &" > $STARTUPDIR/custom_startup.sh \
&& chmod +x $STARTUPDIR/custom_startup.sh


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
