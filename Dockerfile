FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
    libxdo3 libx11-6 libxcb1 libxau6 libxdmcp6 libasound2 \
    libpulse0 libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
    libgbm1 libpango-1.0-0 libcairo2 libglib2.0-0 && rm -rf /var/lib/apt/lists/*
ARG OH_VERSION=0.63.12
RUN curl -sL "https://github.com/tinyhumansai/openhuman/releases/download/v${OH_VERSION}/openhuman-core-${OH_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
    | tar -xz -C /usr/local/bin && chmod +x /usr/local/bin/openhuman-core
RUN useradd -u 10001 -m openhuman || true
ENV OPENHUMAN_CORE_HOST=0.0.0.0 OPENHUMAN_CORE_PORT=7788
EXPOSE 7788
USER openhuman
WORKDIR /home/openhuman
ENTRYPOINT ["/usr/local/bin/openhuman-core"]
CMD ["serve"]
