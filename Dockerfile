FROM ruby:2.5

COPY Gemfile .
RUN bundle install && gem list && apt-get update && apt-get install unzip
ADD https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip?_ga=2.52437996.558673595.1518797908-1702434526.1516199087 .
RUN unzip terraform_0.11.3_linux_amd64.zip && mv terraform /usr/local/bin/ && mkdir /inspec
WORKDIR /inspec
