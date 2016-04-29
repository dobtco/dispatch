## Deployment

This guide assumes that you are deploying _your own fork_ of Dispatch, as per the [customization docs](customization.md).

### Heroku

**1. Create a new application**

`heroku create name_of_app`

**2. Install add-ons:**

- `heroku addons:create heroku-postgresql`
- `heroku addons:create scheduler`
- `heroku addons:create sendgrid`
- `heroku addons:create newrelic` (optional)


**3. Configure environment variables**

Set the following variables by using `heroku config:set KEY=VAL`.

```
# Configure a bucket on AWS for storing uploads:
AWS_BUCKET:               bucket-name
AWS_REGION:               us-west-2
AWS_KEY:                  xxx
AWS_SECRET:               xxx
UPLOAD_STORAGE:           aws

# The domain name of your app
BASE_DOMAIN:              dispatch-demo.herokuapp.com
SSL:                      1

# Generate these values with `rake secret`
SECRET_KEY_BASE:          xxx
SECRET_TOKEN:             xxx

SMTP_ADDRESS:             smtp.sendgrid.net
SMTP_AUTHENTICATION:      plain
SMTP_DOMAIN:              heroku.com

# Find this value with `heroku config:get SENDGRID_PASSWORD`
SMTP_PASSWORD:            xxx

# Find this value with `heroku config:get SENDGRID_USERNAME`
SMTP_USER:                xxxxxxxxx@heroku.com

SMTP_PORT:                587
SMTP_STARTTLS_AUTO:       1
```

**4. Configure your scheduled jobs:**

Run `heroku addons:open scheduler` and configure your schedule to look like this: http://take.ms/938wy

**5. Deploy it!**

```
git push heroku master
```

### Other providers

Deployment documentation for other providers may be added in the future.
