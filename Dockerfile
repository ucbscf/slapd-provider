FROM ubuntu:22.04

ENV DEBIAN_PRIORITY=high
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        slapd \
        slapd-contrib \
        ldap-utils \
        ldapvi \
        less \
        vim-tiny \
        ;

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 389 636

CMD /usr/sbin/slapd -h "ldap:/// ldapi:///" \
    -u openldap -g openldap \
    -f /etc/ldap/SITE-slapd.conf \
    -d sync 2>&1
