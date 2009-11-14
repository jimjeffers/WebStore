# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Cactus-Sports_session',
  :secret      => '1fdf6f323b56e343e4a39839a1c13a7949cb0459a4df176a834863d3bfe0e3e64948e8e1b1aec3c18b99c99935cf225e4e761464fa5a94c4b6489f6ff39fa0df'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
