require 'spec_helper'

describe CineIo::StreamsHandler do

  let(:client) { CineIo::Client.new(secretKey: "MY SECRET", publicKey: "MY PUBLIC") }

  subject { described_class.new(client) }

  describe '#get' do
    it "returns a project" do
      VCR.use_cassette('get_stream') do
        project = subject.get("53718cef450ff80200f81856")
        expect(project).to be_a(CineIo::Stream)
        expect(project.id).to eq("53718cef450ff80200f81856")
        expect(project.password).to eq("THEPASSWORD")
        expect(project.play.keys.sort).to eq(['hls', 'rtmp'])
        expect(project.publish.keys.sort).to eq(['stream', 'url'])
      end
    end
  end

  describe '#create' do
    it "returns a project" do
      VCR.use_cassette('create_stream') do
        project = subject.create
        expect(project).to be_a(CineIo::Stream)
        expect(project.id).to eq("537b7f48bc03be080085a389")
        expect(project.password).to eq("PASSWORD")
        expect(project.play.keys.sort).to eq(['hls', 'rtmp'])
        expect(project.publish.keys.sort).to eq(['stream', 'url'])
      end
    end
  end

end
