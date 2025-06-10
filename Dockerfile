# builder image
FROM ubuntu:latest AS builders

# install dependencies
RUN apt update
RUN apt install -y golang-go git make gcc python3-jinja2 python3-toml less vim

# -- build and install glow md parser --
RUN git clone https://github.com/charmbracelet/glow
RUN mkdir -p /home/go/bin
# this is needed to install old glow version which correctly renders description.md
RUN cd glow && git checkout 8fc9a300a4494bd6f9dc0255f638c42163a168a4
RUN cd glow && env GOBIN=/home/go/bin/ go install

COPY challenges/ challenges/

# create home directories and internal directories
RUN mkdir -p /home/challenges/home
RUN mkdir -p /home/challenges/internal
COPY scripts/ scripts/
RUN cd scripts && make

# create users and store flags
RUN chmod +x scripts/create_users.py
RUN ./scripts/create_users.py

#################
#################

# build final image
FROM ubuntu:latest AS release

# install runtime tools
RUN apt update
RUN apt install -y python3 

# set proper timezone
RUN echo "Europe/Rome" > /etc/timezone 
RUN ln -fs /usr/share/zoneinfo/`cat /etc/timezone` /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

# copy internal challenge files (description, hints) to internal folder
COPY --from=builders /home/challenges/internal /internal/

# copy home directories
COPY --from=builders /home/challenges/home/ /home/

# copy created users
COPY --from=builders /etc/passwd /etc/passwd
COPY --from=builders /etc/shadow /etc/shadow
COPY --from=builders /etc/group /etc/group
COPY --from=builders /etc/gshadow /etc/gshadow

RUN chmod -R 400 /internal

# copy essential tools and scripts to path
COPY --from=builders   /home/go/bin /usr/bin
COPY --from=builders   /usr/bin/less /usr/bin
COPY --from=builders   /usr/bin/vim /usr/bin
COPY --chown=root:root scripts/display-current-challenge.sh /usr/bin/display-challenge
COPY --chown=root:root scripts/get_next_challenge.py /usr/bin/_get-next-challenge
COPY --from=builders /scripts/guess_flag /usr/bin/_guess-flag
COPY --from=builders /scripts/guess_flag.sh /usr/bin/_guess-flag.sh

# allow execute permission to everyone
RUN chmod a+x /usr/bin/display-challenge

# set /etc/profile to display challenge upon login
RUN sed -i '1s;^;alias flag="exec /usr/bin/_guess-flag.sh"\ndisplay-challenge\n\n;' /etc/bash.bashrc

# set user and workdir to first challenge
ENV PROMPT_CHALLENGE=1
USER challenge00
WORKDIR /home/challenge00
ENTRYPOINT /bin/bash
