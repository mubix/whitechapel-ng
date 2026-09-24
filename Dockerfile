FROM ruby:3.2

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential git libpq-dev libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
ENV BUNDLE_PATH=/usr/local/bundle

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4

COPY . .
RUN mkdir -p tmp log

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-b", "tcp://0.0.0.0:3000"]
