FROM google/cloud-sdk
RUN apt-get -y install curl
COPY google-cloud-auto-snapshot.sh /opt/google-cloud-auto-snapshot.sh
COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT /opt/entrypoint.sh
