# frozen_string_literal: true

module S3Toolkit
  module Commands
    extend Dry::CLI::Registry

    class Fetch < Dry::CLI::Command
      desc 'Fetch the contents of a remote URL into a local folder'

      argument :s3_url, type: :string, required: true, desc: 'S3 Bucket / Prefix to fetch'
      argument :dest_dir, type: :string, required: true, desc: 'Destination to copy into'

      option :overwrite, type: :boolean, required: false, default: false, desc: 'Overwrite existing files'
      option :request_concurrency, type: :integer, required: false, default: 10, desc: 'Request concurrency'
      option :region, type: :string, required: false, default: 'ap-southeast-2', desc: 'S3 client region'

      def call(s3_url:, dest_dir:, **options)
        S3Toolkit::Fetcher.call(
          s3_url: s3_url,
          dest_dir: dest_dir,
          request_concurrency: options.fetch(:request_concurrency),
          region: options.fetch(:region),
          overwrite: options.fetch(:overwrite)
        )
      end
    end

    register 'fetch', Fetch
  end
end
