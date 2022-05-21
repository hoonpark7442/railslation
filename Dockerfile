FROM ruby:3.0.2

# Install plugin
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev vim libcairo2-dev libpango1.0-dev \
                                             libjpeg-dev libgif-dev librsvg2-dev

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
apt-get install -y nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn imagemagick postgresql postgresql-client tzdata && \
    gem update --system && \
    gem install bundler

ENV WORKSPACE=/app
ENV LANG C.UTF-8
ENV RAILS_ENV=production

RUN mkdir -p $WORKSPACE
WORKDIR $WORKSPACE
COPY Gemfile* ./
RUN bundle install --jobs 4 --retry 5

COPY . $WORKSPACE

RUN rm -rf node_modules

RUN yarn upgrade

RUN RAILS_ENV=production bundle exec rake assets:precompile

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]