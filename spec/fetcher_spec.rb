# frozen_string_literal: true

RSpec.describe S3Toolkit::Fetcher do
  let(:request_concurrency) { 5 }
  let(:region) { "ap-southeast-2" }
  let(:overwrite) { false }
  let(:s3_url) { "s3://config/test" }
  let(:dest_dir) { "tmp" }

  let(:client) do
    s3 = Aws::S3::Client.new(stub_responses: true)
    s3.stub_responses(:list_objects, {contents: [{key: "file1.txt"}, {key: "file2.txt"}]})
    s3
  end

  subject do
    S3Toolkit::Fetcher.call(
      client: client,
      s3_url: s3_url,
      dest_dir: dest_dir,
      request_concurrency: request_concurrency,
      region: region,
      overwrite: overwrite
    )
  end

  context "files already exist" do
    before do
      FileUtils.mkdir_p("tmp")
      FileUtils.touch("tmp/file1.txt")
      FileUtils.touch("tmp/file2.txt")
    end

    context "overwrite mode files - OFF" do
      let(:overwrite) { false }
      it { is_expected.to eq 0 }
    end

    context "overwrite mode files - ON" do
      let(:overwrite) { true }
      it { is_expected.to eq 2 }
    end
  end

  context "files do not exist" do
    before do
      FileUtils.rm("tmp/file1.txt", force: true)
      FileUtils.rm("tmp/file2.txt", force: true)
    end

    context "overwrite mode files - OFF" do
      let(:overwrite) { false }
      it { is_expected.to eq 2 }
    end

    context "overwrite mode files - ON" do
      let(:overwrite) { true }
      it { is_expected.to eq 2 }
    end
  end
end
