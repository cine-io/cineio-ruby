require 'spec_helper'

describe CineIo::Peer do

  let(:client) { CineIo::Client.new(:secretKey => "MY SECRET", :publicKey => "MY PUBLIC") }

  subject { described_class.new(client) }


  describe '#generate_identity_signature' do
    it 'returns the correct signature' do
      time = Time.parse("Jan 2 2015")
      allow(Time).to receive(:now) { time }

      expect(subject.generate_identity_signature('Thomas')).to eq(identity: "Thomas", signature: "6fbb691889a3db90f6be439aaaaebfca50f1e94d", timestamp: 1420185600)
    end
  end

end
