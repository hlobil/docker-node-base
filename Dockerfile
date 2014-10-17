FROM ubuntu:14.04.1

ENV DEBIAN_FRONTEND noninteractive
ENV NODE_VERSION v0.11.14
ENV NODE_ENV production

# Exclude npm cache from the image
VOLUME ["/root/.npm"]

# define mountable directories
VOLUME ["/var/www"]

ADD install.sh /
RUN bash -xe /install.sh

# define working directory.
WORKDIR /var/www


