require 'spec_helper'

describe CineIo::StreamRecordingsHandler do

  let(:client) { CineIo::Client.new(:secretKey => "MY SECRET", :publicKey => "MY PUBLIC") }

  subject { described_class.new(client) }

  describe '#index' do
    it "returns a stream" do
      VCR.use_cassette('get_stream_recordings') do
        recordings = subject.index("53718cef450ff80200f81856")
        expect(recordings.length).to eq(2)

        recording = recordings.first
        expect(recording).to be_a(CineIo::StreamRecording)
        expect(recording.name).to eq("recordingName")
        expect(recording.url).to eq("recordingUrl")
        expect(recording.date).to eq("recording Date")
        expect(recording.size).to eq(12345)
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('get_stream_recordings_error') do
        expect {subject.index("NOT_AN_ID")}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

  describe '#delete' do
    it "returns a stream" do
      VCR.use_cassette('delete_stream_recording') do
        recordingDeletedAt = subject.delete("53718cef450ff80200f81856", "VALID_RECORDING")
        expect(recordingDeletedAt).to eq("2014-06-09T20:11:20.608Z")
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('delete_stream_recording_error') do
        expect {subject.delete("53718cef450ff80200f81856", "NOT_A_RECORDING")}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

end
