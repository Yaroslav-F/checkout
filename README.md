## README

Ruby version: `2.2.1`

# Usage

1. Clone the repository
2. Create `database.yml`
3. `bundle install`
4. `rake db:setup`

# Testing

* run rspec specs with `rspec` command
* run mutant, to check the test coverage, with `env RAILS_ENV=test bundle exec mutant -r ./config/environment --use rspec *FILENAME*`

# Deployment

The project can be found at [Heroku](http://checkout-task.herokuapp.com) now. If used on production - the `ENV["SECRET_KEY_BASE"]` variable should be set on the server.

# Minimalistic version
Task itself, and more minimalistic solution to this task, can be found in this [Gist](https://gist.github.com/Yaroslav-F/ca17bb69fb32b78e912c)

#TODO:

1. Increase test coverage to absolute 100%, instead of 90-100%.