Beacon [![Circle CI](https://circleci.com/gh/dobtco/beacon-rb.svg?style=shield)](https://circleci.com/gh/dobtco/beacon-rb) [![Code Climate](https://codeclimate.com/github/dobtco/beacon-rb/badges/gpa.svg)](https://codeclimate.com/github/dobtco/beacon-rb) [![Test Coverage](https://codeclimate.com/github/dobtco/beacon-rb/badges/coverage.svg)](https://codeclimate.com/github/dobtco/beacon-rb/coverage)
====

## Install

You'll need to first install the following:

- Ruby 2.3.0
- Bundler
- node.js
- Postgres
- imagemagick

Then, run `script/bootstrap` to install gems and seed your database.

## Developing

Run `script/server` and navigate to http://localhost:3000.

We automatically generate a dummy user account. You can login as `admin@example.com` with the password `password`.

## Testing

Make sure you have a test database by running `rake db:test:prepare`. Then, either use `bundle exec guard`, which will watch for changes and run tests automatically, or run `rspec` directly.

If you're on Linux, you'll need to [manually run an X server](https://github.com/thoughtbot/capybara-webkit/blob/v1.3.0/README.md#ci) before running javascript-enabled specs.
