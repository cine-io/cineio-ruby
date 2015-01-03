require 'spec_helper'

describe CineIo do
  let(:client) { CineIo::Client.new(:publicKey => 'My public key', :secretKey => 'My secret key', :something => 'else') }
  subject { client }

  it 'takes a config' do
    expect(subject.config).to eq(:publicKey => 'My public key', :secretKey => 'My secret key', :something => 'else')
  end

  describe '#projects' do
    subject {client.projects}
    it { should be_a(CineIo::ProjectsHandler) }
  end

  describe '#project' do
    subject {client.project}
    it { should be_a(CineIo::ProjectHandler) }
  end

  describe '#streams' do
    subject {client.streams}
    it { should be_a(CineIo::StreamsHandler) }
  end

  describe '#peer' do
    subject {client.peer}
    it { should be_a(CineIo::Peer) }
  end

end
