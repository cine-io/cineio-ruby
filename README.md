# cine.io ruby gem

[![Build Status](https://travis-ci.org/cine-io/cineio-ruby.svg?branch=master)](https://travis-ci.org/cine-io/cineio-ruby)

The [ruby gem](https://rubygems.org/gems/cine_io) for [cine.io](cine.io).

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

To update your project:

```ruby
# params:
#   name: 'a helpful project name'
project = client.project.update(params)
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

To update a specific stream:

```ruby
# params:
#   name: 'a helpful stream name'
#  record: true|false (updating a stream from true to false will delete old stream recordings)
stream = client.streams.update('STREAM_ID', params)
# => CineIo::Stream
```

To delete a specific stream:

```ruby
deleted_date = client.streams.destroy('STREAM_ID')
# => Date String
```

To create a new stream:

```ruby
# params (optional):
#  name (optional): 'a helpful stream name'
#  record: true|false (default false). record: true will save recordings of all streaming sessions
stream = client.streams.create(params)
# => CineIo::Stream
```

To fetch the [Flash Media Live Encoder](http://www.adobe.com/products/flash-media-encoder.html) profile for a stream:

```ruby
stream = client.streams.fmle_profile('STREAM_ID')
# => String of profile contents
```

#### Stream Recordings

To get all the recordings of stream:

```ruby
recordings = client.streams.recordings.index('STREAM_ID')
# => [CineIo::StreamRecording, …]
```

To delete a the recordings of stream:

```ruby
recordings = client.streams.recordings.delete('STREAM_ID', 'recordingName')
# => Date String
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
