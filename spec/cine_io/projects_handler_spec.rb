require 'spec_helper'

describe CineIo::ProjectsHandler do

  let(:client) { CineIo::Client.new(secretKey: "MY SECRET", publicKey: "MY PUBLIC") }

  subject { described_class.new(client) }

  describe '#get' do
    it "returns a project" do
      VCR.use_cassette('get_project') do
        project = subject.get
        expect(project).to be_a(CineIo::Project)
        expect(project.name).to eq("THE PROJECT")
      end
    end
  end

end
