whitechapel-ng beta
==============

This is a rails port of whitechapel. It is still in a beta state. More
features are in work and some existing features may cause issues.

Whitechapel is ment for you to feed known passwords from your
environment into the tool for indexing. It will also take the known
cleartext passwords and hash them in various form so you can search for
the cleartext equivalent without needing to crack the hash.

The app does not have authentication so host/protect it wisely.

Requires:
* Ruby 3.2+
* PostgreSQL (hash search relies on pg_search)
* Docker (optional, but the recommended way to run/test everything
  without touching the host system)

Setup (Docker, recommended):
----------
* git clone
* cd whitechapel-ng
* docker compose up -d --build
* open the website (http://localhost:3100)

The `app` service runs the web server (Puma) and the `worker` service
runs the delayed_job worker that performs hash generation.

Run the test suite:
```
docker compose run --rm test
```

Tear everything down (including the database volume):
```
docker compose down -v
```

Setup (native):
----------
* git clone
* cd whitechapel-ng
* bundle install
* cp config/database.yml.example config/database.yml
* vim config/database.yml (Setup your database)
* bundle exec rails db:prepare
* foreman start
* open the website (port 3000)

For additional workers:
```
bin/delayed_job -n5 start
```

Notes on the security upgrade (Rails 4.0 -> 7.1):
* `librex` (dead git repo) was replaced by the maintained `rex` gem
  (2.x), which provides the same `Rex::Proto::NTLM::Crypt` API.
* MD4 was removed in OpenSSL 3, so a pure-Ruby MD4 (RFC 1320) in
  `lib/md4.rb` is used as a fallback for NTLM hashing.
* The dead `guard`/`spork`/`cucumber` test tooling and `jbuilder`,
  `uglifier`, `coffee-rails`, `rails_12factor` were removed; their
  functionality is either unused or provided by current gems.
