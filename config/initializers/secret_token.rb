# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

Rails.application.config.secret_token = ENV['SECRET_TOKEN'] || '1b228e683401a9f44b6dfd3e8deab5b560813a9b8b880f9db285c7a292c571c01aa71f8e9cd8c0ee2d255c796dc4e2df38de8b5521b1d06919a21b39788e953e'
Rails.application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || '9493868b2a8834f61b4203faa4e00a9988901ccaf0c3644fd05615aca19c7bf732a4e2ba4e64ccd125215fc6d372d3bf4a5401e3ab37faad476f9eaf42c66915'
