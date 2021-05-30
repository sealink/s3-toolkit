# frozen_string_literal: true

RSpec.describe S3Toolkit::Commands do
  context 'Fetcher' do
    let(:fetcher_class) { double('FetcherClass') }
    let(:options) do
      {
        request_concurrency: 5,
        region: 'ap-southeast-2',
        overwrite: false
      }
    end
    let(:s3_url) { 's3://config/test' }
    let(:dest_dir) { '/tmp' }

    let(:command) { S3Toolkit::Commands::Fetch.new }

    before do
      stub_const 'S3Toolkit::Fetcher', fetcher_class
      allow(fetcher_class).to receive(:call)

      command.call(s3_url: s3_url, dest_dir: dest_dir, **options)
    end

    it 'should call the fetcher with the given arguments' do
      expect(fetcher_class).to have_received(:call).with(
        s3_url: s3_url,
        dest_dir: dest_dir,
        request_concurrency: 5,
        region: 'ap-southeast-2',
        overwrite: false
      )
    end
  end
end
