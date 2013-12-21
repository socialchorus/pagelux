# Pagelux

Basic pagination for ActiveRecord::Relation objects

## Installation

Add this line to your application's Gemfile:

    gem 'pagelux'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pagelux

## Usage

    Pagelux::Query.new(page, limit).perform(the_ar_query)

## Contributing

Test database can be created with this:
    createdb pagelux_test

In pgsql you will need to setup the table:

    psql -d pagelux_test

    CREATE TABLE queries (n int);

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
