# frozen_string_literal: true

RSpec.describe S3Toolkit::UrlParser do
  let(:expected_error) { "Unexpected format, expected: s3://<bucket>/<key>" }
  subject { described_class.call(s3_url) }

  context "valid url" do
    let(:s3_url) { "s3://some-bucket/some-prefix/nested" }
    it { is_expected.to eq ["some-bucket", "some-prefix/nested"] }
  end

  context "removes double slash" do
    let(:s3_url) { "s3://some-bucket//some-prefix//nested" }
    it { is_expected.to eq ["some-bucket", "some-prefix/nested"] }
  end

  context "nil" do
    let(:s3_url) { nil }
    it "should raise error" do
      expect { subject }.to raise_error URI::InvalidURIError, expected_error
    end
  end

  context "invalid url" do
    let(:s3_url) { "http://s3-test" }
    it "should raise error" do
      expect { subject }.to raise_error URI::InvalidURIError, expected_error
    end
  end
end
