Beacon [![status]](https://circleci.com/gh/dobtco/beacon-rb/tree/master)
====

## Install

You'll need to first install the following:

- Ruby 2.3.0
- Bundler
- node.js
- Postgres

Then, run `script/bootstrap` to install gems and seed your database.

## Developing

Run `script/server` and navigate to http://localhost:3000.

We automatically generate a dummy user account. You can login as `admin@example.com` with the password `password`.

## Testing

Make sure you have a test database by running `rake db:test:prepare`. Then, either use `bundle exec guard`, which will watch for changes and run tests automatically, or run `rspec` directly.

If you're on Linux, you'll need to [manually run an X server](https://github.com/thoughtbot/capybara-webkit/blob/v1.3.0/README.md#ci) before running javascript-enabled specs.

[status]: https://circleci.com/gh/dobtco/beacon-rb.svg?style=shield&circle-token=f9ce7050f7aef21dbbc8fee7b8db904502cc90e6
