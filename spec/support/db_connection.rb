ActiveRecord::Base.establish_connection(
  adapter:  'postgresql', # or 'postgresql' or 'sqlite3'
  database: 'pagelux_test',
  username: 'socialchorus',
  host:     'localhost'
)
