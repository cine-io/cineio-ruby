require 'spec_helper'

describe CineIo::StreamsHandler do

  let(:client) { CineIo::Client.new(:secretKey => "MY SECRET", :publicKey => "MY PUBLIC") }

  subject { described_class.new(client) }

  describe '#get' do
    it "returns a stream" do
      VCR.use_cassette('get_stream') do
        stream = subject.get("53718cef450ff80200f81856")
        expect(stream).to be_a(CineIo::Stream)
        expect(stream.id).to eq("53718cef450ff80200f81856")
        expect(stream.password).to eq("THEPASSWORD")
        expect(stream.play.keys.sort).to eq(['hls', 'rtmp'])
        expect(stream.publish.keys.sort).to eq(['stream', 'url'])
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('get_stream_error') do
        expect {subject.get("NOT_AN_ID")}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

  describe '#fmle_profile' do
    it "returns a fmle profile" do
      VCR.use_cassette('get_fmle_profile') do
        profile = subject.fmle_profile("537bee46bc03be080085a38a")
        expect(profile).to be_a(String)
        expect(profile).to include("flashmedialiveencoder_profile")
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('get_fmle_profile_error', record: :once) do
        expect {subject.get("NOT_AN_ID")}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

  describe '#streams' do
    it "returns the streams" do
      VCR.use_cassette('get_streams') do
        streams = subject.index
        expect(streams.length).to eq(1)
        stream = streams.first
        expect(stream).to be_a(CineIo::Stream)
        expect(stream.id).to eq("53718cef450ff80200f81856")
        expect(stream.password).to eq("THEPASSWORD")
        expect(stream.play.keys.sort).to eq(['hls', 'rtmp'])
        expect(stream.publish.keys.sort).to eq(['stream', 'url'])
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('get_streams_error', record: :once) do
        expect {subject.index}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

  describe '#create' do
    it "returns a stream" do
      VCR.use_cassette('create_stream') do
        stream = subject.create
        expect(stream).to be_a(CineIo::Stream)
        expect(stream.id).to eq("537b7f48bc03be080085a389")
        expect(stream.password).to eq("PASSWORD")
        expect(stream.play.keys.sort).to eq(['hls', 'rtmp'])
        expect(stream.publish.keys.sort).to eq(['stream', 'url'])
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('create_stream_error') do
        expect {subject.create}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

end
