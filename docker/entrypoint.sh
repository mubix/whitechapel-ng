#!/bin/sh
set -e

# Wait for PostgreSQL, then create/migrate the database as needed.
ruby -rsocket -e '
  host = ENV.fetch("DATABASE_HOST", "localhost")
  start = Time.now
  loop do
    begin
      TCPSocket.new(host, 5432).close
      exit 0
    rescue StandardError
      abort "Timed out waiting for database" if Time.now - start > 60
      sleep 1
    end
  end
'

bundle exec rails db:prepare

exec "$@"
