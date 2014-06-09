# cine.io ruby gem

[![Build Status](https://travis-ci.org/cine-io/cineio-ruby.svg?branch=master)](https://travis-ci.org/cine-io/cineio-ruby)

The ruby gem for [cine.io](cine.io).

## Installation

Add this line to your application's Gemfile:

    gem 'cine_io'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cine_io

## Usage

### Initialization

```ruby
require('cine_io')
client = CineIo::Client.new(secretKey: 'YOUR_SECRET_KEY')
```

### Methods

#### Projects

To get data about your project:

```ruby
project = client.project.get
# => CineIo::Project
```

To delete your project:

```ruby
deleted_date = client.project.destroy
# => Date String
```

#### Streams

To get all your streams:

```ruby
streams = client.streams.index
# => [CineIo::Stream, …]
```

To get a specific stream:

```ruby
stream = client.streams.get('STREAM_ID')
# => CineIo::Stream
```

To delete a specific stream:

```ruby
deleted_date = client.streams.destroy('STREAM_ID')
# => Date String
```

To create a new stream:

```ruby
stream = client.streams.create
# => CineIo::Stream
```

To fetch the [Flash Media Live Encoder](http://www.adobe.com/products/flash-media-encoder.html) profile for a stream:

```ruby
stream = client.streams.fmle_profile('STREAM_ID')
# => String of profile contents
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
