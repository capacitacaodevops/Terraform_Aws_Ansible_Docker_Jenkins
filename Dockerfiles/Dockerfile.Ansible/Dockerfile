FROM alpine:3.10.3

WORKDIR /ansible

RUN apk update \
    && apk add ansible

#ENTRYPOINT ["ansible-playbook"]
ENTRYPOINT ["ansible"]
