FROM chatwoot/chatwoot:latest

# Single-container entrypoint: run BOTH the web server (puma) and the
# background worker (sidekiq) so we don't need a separate Render worker.
RUN printf '#!/bin/bash\nset -e\nbundle exec sidekiq -C config/sidekiq.yml &\nexec bin/rails server -b 0.0.0.0 -p "${PORT:-3000}" -e "${RAILS_ENV:-production}"\n' > /render-entrypoint.sh \
  && chmod +x /render-entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["/render-entrypoint.sh"]
