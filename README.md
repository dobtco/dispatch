Dispatch [![Circle CI](https://circleci.com/gh/dobtco/dispatch.svg?style=shield)](https://circleci.com/gh/dobtco/dispatch) [![Code Climate](https://codeclimate.com/github/dobtco/dispatch/badges/gpa.svg)](https://codeclimate.com/github/dobtco/dispatch) [![Test Coverage](https://codeclimate.com/github/dobtco/dispatch/badges/coverage.svg)](https://codeclimate.com/github/dobtco/dispatch/coverage)
====

Dispatch is an application for cities to advertise their contract opportunities. It was inspired by Beacon, a Code for America 2015 fellowship project, but it has been completely rewritten from the ground-up for solidity and [customizability](docs/customization.md).

## Technical overview

Dispatch is a Rails application, backed by a PostgreSQL database. It does not have any other significant dependencies, which makes it easy to deploy and maintain.

## Installation

You'll need to first install the following:

- Ruby 2.3.0
- Bundler
- node.js
- Postgres
- imagemagick

Then, run `script/bootstrap` to install gems and seed your database.

## Development

Run `script/server` and navigate to http://localhost:3000.

We automatically generate a dummy user account. You can login as `admin@example.com` with the password `password`.

## Testing

Make sure you have a test database by running `rake db:test:prepare`. Then, either use `bin/guard`, which will watch for changes and run tests automatically, or run `rspec` directly.

(If you're on Linux, you'll need to [manually run an X server](https://github.com/thoughtbot/capybara-webkit/blob/v1.3.0/README.md#ci) before running javascript-enabled specs.)

## License

[MIT](http://dobtco.mit-license.org)
