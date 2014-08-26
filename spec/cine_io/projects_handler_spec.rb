require 'spec_helper'

describe CineIo::ProjectsHandler do

  let(:client) { CineIo::Client.new(:secretKey => "MY SECRET", :masterKey => "MY MASTER KEY") }

  subject { described_class.new(client) }

  describe '#index' do
    it "returns the projects" do
      VCR.use_cassette('get_projects') do
        projects = subject.index
        expect(projects).to be_an(Array)
        expect(projects[0]).to be_a(CineIo::Project)
        expect(projects[0].name).to eq("THE PROJECT")
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('get_projects_error') do
        expect {subject.index}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

end
