FROM ubuntu:16.04
MAINTAINER Sasha Gerrand <github+docker-glibc-builder@sgerrand.com>
ENV PREFIX_DIR /usr/glibc-compat
ENV GLIBC_VERSION 2.27
RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get -q update \
	&& apt-get -qy install \
		bison \
		build-essential \
		wget \
		openssl \
		gawk \
		# arm64v8 Linux
		gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
		# armel (armv4t) Linux
		gcc-arm-linux-gnueabi g++-arm-linux-gnueabi \
		# armhf (armv7) Linux
		gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf \
		# s390x Linux
		gcc-s390x-linux-gnu g++-s390x-linux-gnu \
		# ppc64le (ppc64el) Linux
		gcc-powerpc64le-linux-gnu g++-powerpc64le-linux-gnu \
		# GIT
		git \
	&& wget https://patchwork.ozlabs.org/project/buildroot/patch/20170803213027.27565-1-thomas.petazzoni@free-electrons.com/raw/ -O /patch.diff
COPY configparams /glibc-build/configparams
COPY builder /builder
ENTRYPOINT ["/builder"]
