#!/bin/bash
set -e

# Run Sidekiq (background worker) in the background
bundle exec sidekiq -C config/sidekiq.yml &

# Run the Rails/Puma web server in the foreground
exec bin/rails server -b 0.0.0.0 -p "${PORT:-3000}" -e "${RAILS_ENV:-production}"
