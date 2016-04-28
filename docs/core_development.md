Developing the Dispatch "Core Application"
---

> Developing the Dispatch Core Application is much different than [customizing](customization.md) your instance of Dispatch. Before making changes to the core application, check to see if your use case is covered in our [customization docs](customization.md) first.

## Some general rules of thumb

- `dvl-core` is the default theme, so the views in `app/views/` use class names for that theme
- Strings should be internationalized. Run `i18n-tasks normalize` before committing in order to sort the keys inside of `en.yml` properly
- Don't add too much JavaScript -- this will make it harder to customize the app
