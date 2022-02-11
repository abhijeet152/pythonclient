FROM python:alpine3.7
RUN pip install kubernetes
RUN set -ex && apk --no-cache add sudo

ENV USR=user1
ENV GRP=user1
ENV UID=5000
ENV GID=5000

RUN mkdir -p /home/$USR/myfolder
WORKDIR /home/$USR/myfolder
COPY deployment.py /home/$USR/myfolder
COPY nginx-deployment.yaml /home/$USR/myfolder
RUN chown -R 5000:5000 /home/$USR/myfolder
RUN chmod -R 777 /home/$USR/myfolder
ENV PATH /home/$USR/myfolder:$PATH

RUN addgroup -g ${GID} user1
RUN adduser -h /myfolder \
-s "/bin/bash" \
-D \
-u "$UID" \
-G "$GRP" "$USR" && exit 0 ; exit 1

USER $USR

CMD /usr/local/bin/python /home/$USR/myfolder/deployment.py
