FROM ruby
ENV RAILS_ENV=development
# Set the workdir inside the container
WORKDIR /usr/src/app

# Set the gemfile and install
#COPY Gemfile* ./
# Copy the main application (this copies gemfiles which will be updated in following commands)
COPY . ./

RUN bundle config set --local without 'production'
RUN bundle update --bundler
RUN bundle lock --add-platform x86_64-linux
RUN bundle install
RUN bundle update



# For specific apps, mine that I'm working on now I will use webpacker
RUN gem install rails
RUN gem install nokogiri -v 1.13.3
#RUN gem install nokogiri #this will likely install version 1.14.1

# for db client
RUN apt update -y
RUN apt install sqlite3 -y





# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000
