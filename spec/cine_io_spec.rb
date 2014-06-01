require 'spec_helper'

describe CineIo do
  let(:client) { CineIo::Client.new(publicKey: 'My public key', secretKey: 'My secret key') }
  subject { client }

  it 'takes a public and secret key' do
    expect(subject.config).to eq(publicKey: 'My public key', secretKey: 'My secret key')
  end
  describe '#projects' do
    subject {client.project}
    it { should be_a(CineIo::ProjectsHandler) }
  end

  describe '#streams' do
    subject {client.streams}
    it { should be_a(CineIo::StreamsHandler) }
  end

end
