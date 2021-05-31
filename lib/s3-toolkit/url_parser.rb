# frozen_string_literal: true

module S3Toolkit
  class UrlParser
    def self.call(s3_url)
      raise URI::InvalidURIError, "Unexpected format, expected: s3://<bucket>/<key>" unless s3_url&.start_with?("s3://")

      uri = URI.parse(s3_url)
      bucket = uri.host
      key = uri.path[1..] # Strip the leading /

      [bucket, key]
    end
  end
end
