require 'spec_helper'

describe CineIo::ProjectHandler do

  let(:client) { CineIo::Client.new(:secretKey => "MY SECRET", :publicKey => "MY PUBLIC") }

  subject { described_class.new(client) }

  describe '#get' do
    it "returns a project" do
      VCR.use_cassette('get_project') do
        project = subject.get
        expect(project).to be_a(CineIo::Project)
        expect(project.name).to eq("THE PROJECT")
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('get_project_error') do
        expect {subject.get}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

  describe '#delete' do
    it "returns a date" do
      VCR.use_cassette('delete_project') do
        deleted_date = subject.delete
        expect(deleted_date).not_to be_nil
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('delete_project_error') do
        expect {subject.delete}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

  describe '#update' do
    it "updates the project" do
      VCR.use_cassette('update_project') do
        new_project_details = subject.update(name: 'new project name')
        expect(new_project_details.name).to eq("new project name")
      end
    end

    it 'can throw an error on api exception' do
      VCR.use_cassette('update_project_error') do
        expect {subject.update(name: '')}.to raise_error(CineIo::ApiError, "An unknown error has occured.")
      end
    end
  end

end
