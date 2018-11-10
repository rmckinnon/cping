FROM alpine
COPY cping.sh ./cping.sh
RUN apk add curl
RUN chmod 777 cping.sh
ENTRYPOINT ["./cping.sh"]
