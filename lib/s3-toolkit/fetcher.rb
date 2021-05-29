# frozen_string_literal: true

module S3Toolkit
  class Fetcher
    def self.call(region:, s3_url:, dest_dir:, request_concurrency:, overwrite:, client: nil)
      files = 0
      FileUtils.mkdir_p(dest_dir)
      queue = Queue.new

      bucket, key = S3Toolkit::UrlParser.call(s3_url)

      s3 = client || Aws::S3::Client.new(region: region)
      resp = s3.list_objects(bucket: bucket, prefix: key)
      resp.contents.each { |content| queue.push(content.key) }

      puts "Found #{queue.size} files"
      request_concurrency.times.map do
        Thread.new do
          until queue.empty?
            download = queue.pop
            base_name = File.basename(download)
            destination = "#{dest_dir}/#{base_name}"
            next unless !File.exist?(destination) || overwrite

            puts "download #{s3_url}/#{base_name} to #{destination}"
            File.open(destination, 'wb') do |file|
              resp = s3.get_object({ bucket: bucket, key: download }, target: file)
              files += 1
            end
          end
          Thread.exit
        end
      end.each(&:join)
      files
    end
  end
end
