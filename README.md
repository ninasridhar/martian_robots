# Maritian Robots

### Setup
You'll need ruby version `ruby 2.5.3` or above to run this CLI app.
Just run:
  - `brew install ruby`
  - `gem install bundler`
  - `bundle install`

This should give you Ruby and the gems used in this project: `pry` and `pry-byebug` for debugging and `rspec` for running the test suite.

Once that's done run:
  - `rspec` for all the tests
  - `rspec spec/your_chosen_spec.rb` to run the tests for just one file

This app can be run on the CLI using:
`ruby -r ./lib/martian_robots.rb -e MartianRobots.initialize`
You'll then be prompted to provide your input instructions (an example will be provided).