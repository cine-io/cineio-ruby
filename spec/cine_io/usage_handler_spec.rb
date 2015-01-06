require 'spec_helper'

describe CineIo::UsageHandler do

  let(:client) { CineIo::Client.new(:secretKey => "THE PROJECT SECRET KEY") }

  subject { described_class.new(client) }

  describe '#project' do
    it "returns the project usage report" do
      time = Time.parse("January 06 2015")
      VCR.use_cassette('usage_project') do
        options = {:month => time, :report => ['bandwidth', 'storage']}
        result = subject.project(options)

        expect(result["secretKey"]).to eq('THE PROJECT SECRET KEY')
        expect(result["bandwidth"]).to eq(1073741824)
        expect(result["storage"]).to eq(2147483648)
        expect(result["month"]).to eq("2015-01-06T00:00:00.000Z")
      end
    end
  end

  describe '#stream' do
    it "returns the stream usage report" do
      time = Time.parse("January 06 2015")
      VCR.use_cassette('usage_stream') do
        id = "THE STREAM ID"
        options = {:month => time, :report => ['bandwidth', 'storage']}
        result = subject.stream(id, options)

        expect(result["id"]).to eq('THE STREAM ID')
        expect(result["secretKey"]).to eq('THE PROJECT SECRET KEY')
        expect(result["bandwidth"]).to eq(1073741824)
        expect(result["storage"]).to eq(2147483648)
        expect(result["month"]).to eq("2015-01-06T00:00:00.000Z")
      end
    end
  end

end
