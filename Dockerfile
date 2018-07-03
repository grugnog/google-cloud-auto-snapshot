FROM google/cloud-sdk:alpine
RUN apk add --no-cache curl coreutils
COPY google-cloud-auto-snapshot.sh /opt/google-cloud-auto-snapshot.sh
COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT /opt/entrypoint.sh
