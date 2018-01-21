FROM alpine:latest
LABEL maintainer="gwaewion@gmail.com"
EXPOSE 25 143 587 993
VOLUME /mail

ENV DB_SERVER_ADDRESS 10.0.2.15
ENV DB_NAME mail
ENV DB_USER mail
ENV DB_USER_PASSWORD mail_password
ENV FQDN p1ng.win
ENV MAIL_DOMAIN p1ng.win

RUN apk update
RUN apk add dovecot dovecot-mysql postfix postfix-mysql postfix-pcre mariadb-client rsyslog shadow
RUN mkdir /etc/postfix/sql
COPY dovecot.conf dovecot-sql.conf /etc/dovecot/
COPY sql_virtual_alias_domain_catchall_maps.cf sql_virtual_alias_domain_mailbox_maps.cf sql_virtual_alias_domain_maps.cf sql_virtual_alias_maps.cf sql_virtual_domains_maps.cf sql_virtual_mailbox_maps.cf /etc/postfix/sql/
COPY main.cf /etc/postfix/
COPY run.sh /root

CMD ["sh", "/root/run.sh"]