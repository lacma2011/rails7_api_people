FROM ruby
ENV RAILS_ENV=development
# Set the workdir inside the container
WORKDIR /usr/src/app

# Set the gemfile and install
COPY Gemfile* ./
RUN bundle config set --local without 'production'
RUN bundle install




# For specific apps, mine that I'm working on now I will use webpacker
RUN gem install rails

# for db client
RUN apt update -y
RUN apt install sqlite3 -y

# Copy the main application.
COPY . ./



# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]