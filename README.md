# Slapp

SLAckware Package Parser

## Installation

Add this line to your application's Gemfile:

    gem 'slapp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slapp

## Usage

    parser = Slapp::Parser.new('path/to/PACKAGES.TXT')
    parser.packages # Like JSON

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
