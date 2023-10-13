FROM debian:12

RUN apt update && apt install -y --no-install-recommends jq curl && apt autoclean
RUN apt install -y --no-install-recommends ca-certificates

RUN curl -L -o /usr/local/bin/json-status https://raw.githubusercontent.com/ADSBexchange/adsbexchange-stats/master/json-status
RUN chmod 755 /usr/local/bin/json-status

COPY adsbexchange-stats /etc/default/
COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT /usr/local/bin/entrypoint.sh
