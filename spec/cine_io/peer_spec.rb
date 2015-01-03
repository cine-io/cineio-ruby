require 'spec_helper'

describe CineIo::Peer do

  let(:client) { CineIo::Client.new(:secretKey => "MY SECRET", :publicKey => "MY PUBLIC") }

  subject { described_class.new(client) }


  describe '#generate_identity_signature' do
    it 'returns the correct signature' do
      time = Time.parse("Jan 2 2015")
      allow(Time).to receive(:now) { time }

      expect(subject.generate_identity_signature('Thomas')).to eq(identity: "Thomas", signature: "604d94e08118b3539d12d9394fc5c0e27f9959dc", timestamp: 1420156800)
    end
  end

end
