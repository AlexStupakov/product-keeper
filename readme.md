# Poroduct Keeper

## Sinatra application

can:
* Reading the CSV every day

* storing the updated data in a DB

* exposing a single API to get a list of products by a producer. you should include some kind of pagination mechanism in your implementation

## To install

* Install MongoDB and Redis on your system

* run bundle install

## To run

### Start application server
bundle exec ruby application.rb

### Start sidekiq
run bundle exec sidekiq -r ./application.rb

### Start worker
* create file .env like .env_example with csv file location url 
* run clockwork clock.rb