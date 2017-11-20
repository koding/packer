FROM amazonlinux

LABEL maintainer="sonmez@koding.com"

ADD base/amazon-linux/ /
ADD base/provision.sh /scripts/provision.sh
ADD scripts/ /scripts/
RUN /scripts/provision.sh
