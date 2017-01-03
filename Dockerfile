FROM google/cloud-sdk
ADD google-cloud-auto-snapshot.sh /opt/google-cloud-auto-snapshot.sh
RUN chmod u+x /opt/google-cloud-auto-snapshot.sh
ENTRYPOINT /opt/google-cloud-auto-snapshot.sh
