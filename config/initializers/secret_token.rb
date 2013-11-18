# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.


# Old secret_key_base
# 'dd6ef1b3fc054e2d6949cc87fdea29c9ec0948288070bcdc6a563f10cba47714a6cd3628001e18a6748a4c9c0f6b659492a06ec350626a0f3ed882d1dc6d3582'

Budget::Application.config.secret_key_base = ENV['BUDGET_SECRET_KEY_BASE']
