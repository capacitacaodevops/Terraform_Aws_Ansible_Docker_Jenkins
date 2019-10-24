FROM alpine:3.10.3

MAINTAINER Dielly R. Vial (diellyr@gmail.com)

WORKDIR /ansible

RUN apk update \
    && apk add ansible

#ENTRYPOINT ["ansible-playbook"]
ENTRYPOINT ["ansible"]
