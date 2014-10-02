FROM ubuntu:14.04.1

ENV DEBIAN_FRONTEND noninteractive
ENV NODE_VERSION v0.11.14
ENV NODE_ENV production

ADD install.sh /
RUN bash -xe /install.sh
