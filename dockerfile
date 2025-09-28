FROM debian:stable-slim

RUN apt-get update && apt-get install -y fortune-mod cowsay netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Adding path so cowsay command can be found
ENV PATH="/usr/games:${PATH}"

# Create a non-root user and switch to it
RUN useradd -u 1001 -m wisecowuser
RUN mkdir -p /app && chown wisecowuser:wisecowuser /app
WORKDIR /app

COPY wisecow.sh .

RUN chmod +x wisecow.sh

USER wisecowuser

EXPOSE 4499

CMD ["./wisecow.sh"]
