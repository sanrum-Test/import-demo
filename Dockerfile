FROM python:3.7.5-slim as base
FROM base as builder
RUN apt-get -qq update \
    && apt-get install -y --no-install-recommends \
        g++ \
    && rm -rf /var/lib/apt/lists/*

# Enable unbuffered logging
FROM base as final
ENV PYTHONUNBUFFERED=1

RUN apt-get -qq update \
    && apt-get install -y --no-install-recommends \
        wget

#WORKDIR /

# Grab packages from builder
COPY --from=builder /usr/local/lib/python3.7/ /usr/local/lib/python3.7/

# Add the application
COPY backend1 .

EXPOSE 8080
CMD [ "/bin/bash", "-c", "pwd; ls -latr; python server.py" ]
#CMD [ "/bin/bash", "-c", "sleep 9000" ]
#ENTRYPOINT [ "python", "server.py" ]
