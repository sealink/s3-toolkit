[![Gem Version](https://badge.fury.io/rb/s3-toolkit.svg)](http://badge.fury.io/rb/s3-toolkit)
[![Build Status](https://github.com/sealink/s3-toolkit/workflows/Build%20and%20Test/badge.svg?branch=master)](https://github.com/sealink/s3-toolkit/actions)
[![Coverage Status](https://coveralls.io/repos/sealink/s3-toolkit/badge.svg)](https://coveralls.io/r/sealink/s3-toolkit)

## Purpose

This provides a simple way to fetch files from an s3 bucket using the AWS Ruby SDK.

Once this gem is installed you can use it to download the contents of a remote s3 bucket.

For example

```ruby
bundle exec s3-toolkit fetch s3://remote-bucket/config/ config/
```

To show all available options

```ruby
bundle exec s3-toolkit --help
```

## Release

To publish a new version of this gem the following steps must be taken.

* Update the version in the following files
  ```
    CHANGELOG.md
    lib/s3-toolkit/version.rb
  ````
* Create a tag using the format v0.1.0
* Follow build progress in GitHub actions

## Contributing

1. Fork it ( https://github.com/sealink/s3-toolkit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
