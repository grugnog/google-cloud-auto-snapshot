FROM google/cloud-sdk

ADD google-cloud-auto-snapshot.sh /opt/google-cloud-auto-snapshot.sh
ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod u+x /opt/google-cloud-auto-snapshot.sh /opt/entrypoint.sh
WORKDIR /opt
ENTRYPOINT entrypoint.sh
