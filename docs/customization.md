Customizing Dispatch
---

Dispatch is designed to allow for significant customization _without_ needing to override the "core" of the application. This allows for a cleaner upgrade path, and a better pattern for re-use across multiple government agencies.

Dispatch exposes the concept of "themes". When you customize Dispatch, you should always use this theme mechanism instead of editing the core Dispatch files. If you do not — that is, if you make custom changes to the main Dispatch source code — you may not be able to update your site with newer Dispatch code (new features and occasional bug fixes).

Sometimes you may want to change the core templates in a way that would benefit everyone, in which case: great! But please discuss the changes in our issue tracker, make them in a fork of Dispatch, and then open a pull request.

## Getting started

Currently, the best way to create your own theme of Dispatch is by forking this repository. Once you do so, you will create a theme inside of `themes/YOUR_THEME_NAME`. As long as you don't modify anything outside of this directory, [upgrading](#upgrading) should be painless.

### Editing configuration settings

Copy `config.yml.example` to `config.yml`. Go through each setting and set a new value if necessary. Any secrets should be set in environment variables instead.

### Customizing the default color scheme

- [x] Edit variables in the dvl-core theme.

### Adding your logo

- [x] Override assets in `theme/` directory.

### Adding custom JS/CSS

- [x] Override assets in `theme/` directory. Alternatively, append scripts to the page using the `:extra_js` content block.

### Changing CSS class names

- [x] Override templates.
- [x] Override `simple_form` configuration.

### Editing site language

- [x] Override i18n in `theme/` directory.

### Adding new submission adapters

- [x] Add adapters to `theme/` directory.

### Adding fields to vendor registration

- [x] Override `views/users/registrations/_business_data.html.erb`

### Adding static pages

Add templates to `views/static`, add keys to `static_pages` configuration.

### Upgrading Dispatch

Assume that you forked Dispatch, here's how you can merge the latest changes:

1. `git remote add upstream git@github.com:dobtco/dispatch.git`
2. `git fetch upstream`
3. `git merge upstream/master`

Then, take a look at [CHANGELOG.md](../CHANGELOG.md) and review the changes. There may be additional upgrade instructions to follow.
