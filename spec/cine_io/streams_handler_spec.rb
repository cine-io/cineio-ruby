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

  describe '#recordings' do
    it 'returns an instance of a StreamRecordingsHandler' do
      expect(subject.recordings).to be_a(CineIo::StreamRecordingsHandler)
    end

    it 'passes along the client to the StreamRecordingsHandler' do
      expect(subject.recordings.instance_variable_get(:@client)).to eq(client)
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

  describe '#index' do
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

    it "returns the streams with a name" do
      VCR.use_cassette('get_streams_with_name') do
        streams = subject.index(name: 'my name')
        expect(streams.length).to eq(1)
        stream = streams.first
        expect(stream).to be_a(CineIo::Stream)
        expect(stream.id).to eq("53718cef450ff80200f81856")
        expect(stream.name).to eq("my name")
        expect(stream.password).to eq("THEPASSWORD")
        expect(stream.play.keys.sort).to eq(['hls', 'rtmp'])
        expect(stream.publish.keys.sort).to eq(['stream', 'url'])
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('get_streams_error') do
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
        expect(stream.name).to eq(nil)
        expect(stream.password).to eq("PASSWORD")
        expect(stream.record).to eq(false)
        expect(stream.play.keys.sort).to eq(['hls', 'rtmp'])
        expect(stream.publish.keys.sort).to eq(['stream', 'url'])
      end
    end

    it "can take a name parameter" do
      VCR.use_cassette('create_stream_with_name') do
        stream = subject.create(name: 'new stream')
        expect(stream).to be_a(CineIo::Stream)
        expect(stream.id).to eq("537b7f48bc03be080085a389")
        expect(stream.name).to eq("new stream")
        expect(stream.password).to eq("PASSWORD")
        expect(stream.record).to eq(false)
        expect(stream.play.keys.sort).to eq(['hls', 'rtmp'])
        expect(stream.publish.keys.sort).to eq(['stream', 'url'])
      end
    end

    it "can take a record parameter" do
      VCR.use_cassette('create_stream_with_record') do
        stream = subject.create(record: true)
        expect(stream).to be_a(CineIo::Stream)
        expect(stream.id).to eq("537b7f48bc03be080085a389")
        expect(stream.name).to eq(nil)
        expect(stream.password).to eq("PASSWORD")
        expect(stream.record).to eq(true)
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

  describe '#delete' do
    it "returns a date" do
      VCR.use_cassette('delete_stream') do
        deleted_date = subject.delete('538f79dddfd24d0a00647085')
        expect(deleted_date).not_to be_nil
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('delete_stream_error') do
        expect {subject.delete('NOT_A_STREAM')}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

  describe '#update' do
    it "updates the name" do
      VCR.use_cassette('update_stream') do
        stream = subject.update('53718cef450ff80200f81856', name: 'homepage stream')
        expect(stream.id).to eq('53718cef450ff80200f81856')
        expect(stream.name).to eq('homepage stream')
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('update_stream_error') do
        expect {subject.update('NOT_A_STREAM', name: '')}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

end
