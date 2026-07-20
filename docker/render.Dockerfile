# Use the official, pre-built Chatwoot image as the base.
# This avoids a slow/fragile Ruby build on Render's free tier.
FROM chatwoot/chatwoot:latest

# Add an entrypoint that runs BOTH the web server (puma) and the
# background worker (sidekiq) in a single container, so we don't
# need a separate Render "worker" service (unavailable on free plan).
COPY docker/render-entrypoint.sh /render-entrypoint.sh
RUN chmod +x /render-entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["/render-entrypoint.sh"]
