# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Cactus-Sports_session',
  :secret      => '65feceee6ef7b741f04371ae35c0a59c61fc2841af2ef34b6a6cd5cc85e1a9eef9131bdd40da8638aea6f2a21831af8ef88b8ea343afd4dbe68372d09f457057'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
